#!/usr/bin/python

#import jsonrpc
import sys


vfile = open('Vagrantfile', 'r')
topology = sys.argv[1]
devices = []


for line in vfile.readlines():
    if 'forwarded_port' in line:
        info = line.replace(',','').strip().split()
        device = info[0].replace('.vm.network','').strip()
        port = info[-1].strip()
        d = {'device': device, 'port': port}
        devices.append(d)

vfile.close()


for device in devices:
    connection_url = 'http://localhost:%s/command-api' % device['port']
    print connection_url
    #conn = jsonrpc.Server(connection_url)
    #response = conn.runCmd(1, ['show ip interface Management1'])

    device['ipAddress'] = ''
    device['cidr'] = ''
    conf_filename = 'configs/%s-%s.cfg' % (device['device'], topology)
    conf_file = open(conf_filename, 'r')
    config = conf_file.read().splitlines()
    conf_file.close()

    for k,v in device.iteritems():
        print k,v
    
    for line in config:
        print line








    



