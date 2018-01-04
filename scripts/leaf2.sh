#!/usr/bin/env bash

FastCli -p 15 -c"

hostname leaf2

aaa authorization exec default local
username ansible-user privilege 15 role network-admin secret sha512 $6$uONAST1Yfdlqj6Ix$M7LJIrc.2YYNJxU9wqw1bLXGUeJzttIPC.gRjuz3/SzwniFVn3//srzvu4VNEQx/R0GGGp7AwZgoOb6IdeJ6K/

ip virtual-router mac-address aa:bb:aa:bb:00:01

vlan 12
   name leaf2-app

interface Ethernet1
   description server2-eth0
   switchport mode trunk
interface Ethernet2
   description spine1-eth2
   no switchport
   ip address 10.1.0.5/30

interface Vlan12
   description leaf2-app
   ip address 192.168.12.2/24
   ip virtual-router address 192.168.12.1
   no autostate

interface Loopback0
   description router-id
   ip address 2.2.2.2/32

ip routing

router bgp 65002
   router-id 2.2.2.2
   neighbor 10.1.0.6 remote-as 65000
   network 2.2.2.2/32
   network 192.168.12.0/24

management api http-commands
   protocol http
   no shutdown

"
