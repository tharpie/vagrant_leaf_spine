#!/usr/bin/env bash

FastCli -p 15 -c"

hostname leaf1

aaa authorization exec default local
username ansible-user privilege 15 role network-admin secret sha512 $6$uONAST1Yfdlqj6Ix$M7LJIrc.2YYNJxU9wqw1bLXGUeJzttIPC.gRjuz3/SzwniFVn3//srzvu4VNEQx/R0GGGp7AwZgoOb6IdeJ6K/

ip virtual-router mac-address aa:bb:aa:bb:00:01

vlan 11
   name leaf1-app

interface Ethernet1
   description server1-eth0
   switchport mode trunk
interface Ethernet2
   description spine1-eth1
   no switchport
   ip address 10.1.0.1/30

interface Vlan11
   description leaf1-app
   ip address 192.168.11.2/24
   ip virtual-router address 192.168.11.1
   no autostate

interface Loopback0
   description router-id
   ip address 1.1.1.1/32

ip routing

router bgp 65001
   router-id 1.1.1.1
   neighbor 10.1.0.2 remote-as 65000
   network 1.1.1.1/32
   network 192.168.11.0/24

management api http-commands
   protocol http
   no shutdown

"
