#!/usr/bin/env bash

FastCli -p 15 -c"

hostname leaf4

aaa authorization exec default local
username ansible-user privilege 15 role network-admin secret sha512 $6$uONAST1Yfdlqj6Ix$M7LJIrc.2YYNJxU9wqw1bLXGUeJzttIPC.gRjuz3/SzwniFVn3//srzvu4VNEQx/R0GGGp7AwZgoOb6IdeJ6K/

ip virtual-router mac-address aa:bb:aa:bb:00:01

vlan 14
   name leaf4-app

interface Ethernet1
   description server4-eth0
   switchport mode trunk
interface Ethernet2
   description spine1-eth4
   no switchport
   ip address 10.1.0.13/30

interface Vlan14
   description leaf4-app
   ip address 192.168.14.2/24
   ip virtual-router address 192.168.14.1
   no autostate

interface Loopback0
   description router-id
   ip address 4.4.4.4/32

ip routing

router bgp 65004
   router-id 4.4.4.4
   neighbor 10.1.0.14 remote-as 65000
   network 4.4.4.4/32
   network 192.168.14.0/24

management api http-commands
   protocol http
   no shutdown

"
