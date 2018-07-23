#!/usr/bin/python

import jsonrpclib
import sys

# Define username / password for eAPI
# Read in topology from command line
usr, pwd = ('arista', 'arista')
topology = sys.argv[1]


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
    session_start = []
    session_start.append('configure session %s' % topology)
        
    # Gather Management1 interface ip and add to configuration
    response = conn.runCmds(1, ['show ip interface Management1'])
    ip = response[0]['interfaces']['Management1']['interfaceAddress']['primaryIp']
    ma_config = []
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

    # Build Configuration Session Config
    session_end = []
    session_end.append('configure replace session-config ignore-errors')

    # Assemble Configuration
    config = session_start + base_config + topology_config + ma_config + session_end
        
    result = conn.runCmds(1, config)
    
    print 'pushed %s configuration to %s' % (topology, device['device'])


