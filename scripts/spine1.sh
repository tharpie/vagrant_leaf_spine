#!/usr/bin/env bash

FastCli -p 15 -c"
enable
configure

hostname spine1

aaa authorization exec default local

interface Ethernet1
   description leaf1-eth2
   no switchport
   ip address 10.1.0.2/30
interface Ethernet2
   description leaf2-eth2
   no switchport
   ip address 10.1.0.6/30
interface Ethernet3
   description leaf3-eth2
   no switchport
   ip address 10.1.0.10/30
interface Ethernet4
   description leaf4-eth2
   no switchport
   ip address 10.1.0.14/30

interface Loopback0
   description router-id
   ip address 20.20.20.20/32

ip routing

router bgp 65000
   router-id 20.20.20.20
   neighbor 10.1.0.1 remote-as 65001
   neighbor 10.1.0.5 remote-as 65002
   neighbor 10.1.0.9 remote-as 65003
   neighbor 10.1.0.13 remote-as 65004
   network 20.20.20.20/32

management api http-commands
   protocol http
   no shutdown

"
