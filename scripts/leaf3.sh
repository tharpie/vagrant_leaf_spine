#!/usr/bin/env bash

FastCli -p 15 -c"

hostname leaf3

aaa authorization exec default local
username ansible-user privilege 15 role network-admin secret sha512 $6$uONAST1Yfdlqj6Ix$M7LJIrc.2YYNJxU9wqw1bLXGUeJzttIPC.gRjuz3/SzwniFVn3//srzvu4VNEQx/R0GGGp7AwZgoOb6IdeJ6K/

ip virtual-router mac-address aa:bb:aa:bb:00:01

vlan 13
   name leaf3-app

interface Ethernet1
   description server3-eth0
   switchport mode trunk
interface Ethernet2
   description spine1-eth3
   no switchport
   ip address 10.1.0.9/30

interface Vlan13
   description leaf3-app
   ip address 192.168.13.2/24
   ip virtual-router address 192.168.13.1
   no autostate

interface Loopback0
   description router-id
   ip address 3.3.3.3/32

ip routing

router bgp 65003
   router-id 3.3.3.3
   neighbor 10.1.0.10 remote-as 65000
   network 3.3.3.3/32
   network 192.168.13.0/24

management api http-commands
   protocol http
   no shutdown

"
