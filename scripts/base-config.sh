#!/usr/bin/env bash

FastCli -p 15 -c"
enable
configure

hostname $1

username arista secret 0 arista privilege 15 role network-admin

aaa authorization exec default local

management api http-commands
   protocol http
   no shutdown

"