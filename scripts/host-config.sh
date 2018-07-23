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
"

sudo echo "$IFCFG" > /etc/sysconfig/network-scripts/ifcfg-eth1
sudo echo "$ROUTES" > /etc/sysconfig/network-scripts/route-eth1

sudo ifdown eth1; sudo ifdown eth1
