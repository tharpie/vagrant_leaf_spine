#!/usr/bin/env bash
IP="$1"

IFCFG="
DEVICE=eth1
BOOTPROTO=static
ONBOOT=yes
TYPE=Ethernet
IPADDR=$IP
NETMASK=255.255.255.0
"
BASE=${IP:0:10}
ROUTES="
192.168.11.0/24 via $BASE.1 dev eth1
192.168.12.0/24 via $BASE.1 dev eth1
192.168.13.0/24 via $BASE.1 dev eth1
1.1.1.1/32 via $BASE.1 dev eth1
2.2.2.2/32 via $BASE.1 dev eth1
3.3.3.3/32 via $BASE.1 dev eth1
101.101.101.101/32 via $BASE.1 dev eth1
202.202.202.202/32 via $BASE.1 dev eth1
"

sudo echo "$IFCFG" > /etc/sysconfig/network-scripts/ifcfg-eth1
sudo echo "$ROUTES" > /etc/sysconfig/network-scripts/route-eth1

sudo ifdown eth1; sudo ifup eth1
