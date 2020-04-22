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


