#!/bin/sh
sudo mkdir -p /home/ubuntu/volumes/web1/web/html
sudo mkdir -p /home/ubuntu/volumes/web2/web/html
sudo mkdir -p /home/ubuntu/volumes/web3/web/html
sudo mkdir -p /home/ubuntu/volumes/lb
sudo mkdir -p /home/ubuntu/volumes/db1
sudo mkdir -p /home/ubuntu/volumes/db2
sudo mkdir -p /home/ubuntu/volumes/db3
sudo mkdir -p /home/ubuntu/volumes/dbproxy
sleep 2
cd /home/ubuntu/volumes/web1/web/html/
sudo git init 
sleep 5
sudo git clone https://github.com/AsifHasan-ops/PE2.git
sleep  5
cd PE2
sudo cp  * ../
sudo cp  -r * ../
cd ../
sudo rm -rf PE2
sleep 2
sudo touch /home/ubuntu/volumes/web1/web/html/Dockerfile
echo "#Dockerfile_web1" > /home/ubuntu/volumes/web1/web/html/Dockerfile
sleep 2
sudo sed -i "1 i\FROM richarvey/nginx-php-fpm:latest" /home/ubuntu/volumes/web1/web/html/Dockerfile
sleep 2
sudo sed -i '2 i COPY . /var/www/html' /home/ubuntu/volumes/web1/web/html/Dockerfile
sleep 2
sudo docker build -t web1 /home/ubuntu/volumes/web1/web/html/.
sleep 5
sudo docker run --name=web1  -d web1
sleep 3
cd /home/ubuntu/volumes/web2/web/html/
sudo git init 
sleep 5
sudo git clone https://github.com/AsifHasan-ops/PE2.git
sleep  5
cd PE2
sudo cp  * ../
sudo cp  -r * ../
cd ../
sudo rm -rf PE2

sudo touch /home/ubuntu/volumes/web2/web/html/Dockerfile
echo "#Dockerfile_web2" > /home/ubuntu/volumes/web2/web/html/Dockerfile
sleep 2
sudo sed -i "1 i\FROM richarvey/nginx-php-fpm:latest" /home/ubuntu/volumes/web2/web/html/Dockerfile
sleep 2
sudo sed -i '2 i COPY . /var/www/html' /home/ubuntu/volumes/web2/web/html/Dockerfile
sleep 2
sudo docker build -t web2 /home/ubuntu/volumes/web2/web/html/.
sleep 5
sudo docker run --name=web2  -d web2
sleep 3
cd /home/ubuntu/volumes/web3/web/html/
sudo git init 
sleep 5
sudo git clone https://github.com/AsifHasan-ops/PE2.git
sleep  5
cd PE2
sudo cp  * ../
sudo cp  -r * ../
cd ../
sudo rm -rf PE2
sleep 2
sudo touch /home/ubuntu/volumes/web3/web/html/Dockerfile
echo "#Dockerfile_web3" > /home/ubuntu/volumes/web3/web/html/Dockerfile
sleep 2
sudo sed -i "1 i\FROM richarvey/nginx-php-fpm:latest" /home/ubuntu/volumes/web3/web/html/Dockerfile
sleep 2
sudo sed -i '2 i COPY . /var/www/html' /home/ubuntu/volumes/web3/web/html/Dockerfile
sleep 2
sudo docker build -t web3 /home/ubuntu/volumes/web3/web/html/.
sleep 5
sudo docker run --name=web3  -d web3
sleep 3
sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/haproxy.cfg > /home/ubuntu/volumes/lb/haproxy.cfg
sleep 2
sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/web_if_set.sh > /home/ubuntu/web_if_set.sh
sleep 2
sudo chmod 777 /home/ubuntu/web_if_set.sh
/home/ubuntu/web_if_set.sh
sleep 2
sudo touch /home/ubuntu/volumes/lb/Dockerfile
echo "#Dockerfile_haproxy" > /home/ubuntu/volumes/lb/Dockerfile
sleep 2
sudo sed -i "1 i\FROM haproxy:latest" /home/ubuntu/volumes/lb/Dockerfile
sudo docker build -t lb /home/ubuntu/volumes/lb/.
sleep 5
sudo docker run -d --name=haproxy -p 80:80 -v /home/ubuntu/volumes/lb/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg lb
sleep 3
