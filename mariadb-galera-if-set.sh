#!/bin/sh
# Set the server's hostname
myHostName1=dbgc1
myHostName2=dbgc2
myHostName3=dbgc3

dck=$(docker inspect db1 | grep  '"IPAddress":' | cut -c34-44 > /tmp/d.txt)
ipaddr1=$(cat /tmp/d.txt  | grep 172.17 | cut -d '"' -f2)
dck2=$(docker inspect db2 | grep  '"IPAddress":' | cut -c34-44 > /tmp/e.txt)
ipaddr2=$(cat /tmp/e.txt  | grep 172.17 | cut -d '"' -f2)
dck3=$(docker inspect db3 | grep  '"IPAddress":' | cut -c34-44 > /tmp/f.txt)
ipaddr3=$(cat /tmp/f.txt  | grep 172.17 | cut -d '"' -f2)

echo "$ipaddr1 $myHostName1" >> /etc/hosts
echo "$ipaddr2 $myHostName2" >> /etc/hosts
echo "$ipaddr3 $myHostName3" >> /etc/hosts
