#!/usr/bin/python

import jsonrpclib
import sys
import random


def print_help():
    print 'Help Menu'
    print '---------------------'
    print 'valid toplogies are %s' % ', '.join(topologies)
    print ''
    print 'Please use the following usage:'
    print 'python provision-topology.py [topology_name]'
    print ''
    return


# Define username / password for eAPI
# Read in topology from command line
usr, pwd = ('arista', 'arista')
topologies = ['bgp', 'evpn', 'mcast']
try:
    topology = sys.argv[1]
    if topology == '-h':
        print_help()
        sys.exit(1)
    elif topology not in topologies:
        raise Exception('Topology provided not supported')
except Exception as e:
    print e.message
    print_help()
    sys.exit(1)


# Read Vagrantfile and parse for determing local port
devices = []
vfile = open('Vagrantfile', 'r')
for line in vfile.readlines():
    if 'forwarded_port' in line:
        info = line.replace(',','').strip().split()
        device = info[0].replace('.vm.network','').strip()
        port = info[-1].strip()
        d = {'device': device, 'port': port}
        devices.append(d)
vfile.close()


# Connect to each device and provision based on topology
for device in devices:
    connection_url = 'http://%s:%s@localhost:%s/command-api' % (usr, pwd, device['port'])
    conn = jsonrpclib.Server(connection_url)

    # Start Session Configuration
    random_str = str(random.random())
    random_str = random_str.split('.')[-1]
    session_name = '%s-%s' % (topology, random_str)
    session_start = []
    session_start.append('configure session %s' % session_name)
    session_start.append('rollback clean-config')
        
    # Gather Management1 interface ip and add to configuration
    response = conn.runCmds(1, ['show ip interface Management1', 'show hostname'])
    ip = response[0]['interfaces']['Management1']['interfaceAddress']['primaryIp']
    hostname = response[1]['hostname']
    ma_config = []
    ma_config.append('hostname %s' % hostname)
    ma_config.append('interface Management1')
    ma_config.append('   ip address %s/%s' % (ip['address'], ip['maskLen']))

    # Gather Base Configuration
    conf_filename = 'configs/base-config.cfg'
    conf_file = open(conf_filename, 'r')
    base_config = conf_file.read().splitlines()
    conf_file.close()

    # Gather Topology Configuration
    conf_filename = 'configs/%s-%s.cfg' % (device['device'], topology)
    conf_file = open(conf_filename, 'r')
    topology_config = conf_file.read().splitlines()
    conf_file.close()

    # Assemble Configuration
    config = session_start + base_config + topology_config + ma_config
        
    result = conn.runCmds(1, config)
    result = conn.runCmds(1, ['configure session %s commit' % session_name,
                              'copy running-config startup-config'])
    
    print 'pushed %s configuration to %s' % (topology, device['device'])



