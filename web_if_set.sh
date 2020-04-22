#!/bin/sh
# Set the server's hostname
myHostName1=web1
myHostName2=web2
myHostName3=web3

dck=$(docker inspect web1 | grep  '"IPAddress":' | cut -c34-44 > /tmp/a.txt)
ipaddr1=$(cat /tmp/a.txt  | grep 172.17 | cut -d '"' -f2)
dck2=$(docker inspect web2 | grep  '"IPAddress":' | cut -c34-44 > /tmp/b.txt)
ipaddr2=$(cat /tmp/b.txt  | grep 172.17 | cut -d '"' -f2)
dck3=$(docker inspect web3 | grep  '"IPAddress":' | cut -c34-44 > /tmp/c.txt)
ipaddr3=$(cat /tmp/c.txt  | grep 172.17 | cut -d '"' -f2)

echo "$ipaddr1 $myHostName1" >> /etc/hosts
echo "Server $myHostName1 $ipaddr1:80" >> /home/ubuntu/volumes/lb/haproxy.cfg
echo "$ipaddr2 $myHostName2" >> /etc/hosts
echo "Server $myHostName2 $ipaddr2:80" >> /home/ubuntu/volumes/lb/haproxy.cfg
echo "$ipaddr3 $myHostName3" >> /etc/hosts
echo "Server $myHostName3 $ipaddr3:80" >> /home/ubuntu/volumes/lb/haproxy.cfg
