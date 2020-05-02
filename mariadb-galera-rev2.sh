#!/bin/sh
sudo mkdir -p /home/ubuntu/volumes/db1/conf.d
sudo mkdir -p /home/ubuntu/volumes/db2/conf.d
sudo mkdir -p /home/ubuntu/volumes/db3/conf.d
sudo mkdir -p /home/ubuntu/volumes/db1/datadir
sudo mkdir -p /home/ubuntu/volumes/db2/datadir
sudo mkdir -p /home/ubuntu/volumes/db3/datadir

#sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/Dockerfile > /home/ubuntu/volumes/db1/Dockerfile
sleep 2
sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/db1-my.cnf > /home/ubuntu/volumes/db1/conf.d/my.cnf
sleep 2
#sudo docker build -t db1 /home/ubuntu/volumes/db1/.
sleep 5
docker run -d \
--name db1 \
--hostname dbgc1 \
--expose "3306" \
--expose "4444" \
--expose "4567" \
--expose "4568" \
--env MYSQL_ROOT_PASSWORD="rootpass" \
--env MYSQL_USER="maxscaleuser" \
--env MYSQL_PASSWORD="maxscalepass" \
--volume /home/ubuntu/volumes/db1/datadir:/var/lib/mysql \
--volume /home/ubuntu/volumes/db1/conf.d:/etc/mysql/mariadb.conf.d \
mariadb/server:10.4

sleep 30
#sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/Dockerfile > /home/ubuntu/volumes/db2/Dockerfile
#sleep 2
sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/db2-my.cnf > /home/ubuntu/volumes/db2/conf.d/my.cnf
sleep 2
#sudo docker build -t db2 /home/ubuntu/volumes/db2/.
#sleep 5
docker run -d \
--name db2 \
--hostname dbgc2 \
--add-host=dbgc1:172.17.0.6 \
--expose "3306" \
--expose "4444" \
--expose "4567" \
--expose "4568" \
--env MYSQL_ROOT_PASSWORD="rootpass" \
--env MYSQL_USER="maxscaleuser" \
--env MYSQL_PASSWORD="maxscalepass" \
--volume /home/ubuntu/volumes/db2/datadir:/var/lib/mysql \
--volume /home/ubuntu/volumes/db2/conf.d:/etc/mysql/mariadb.conf.d \
mariadb/server:10.4



sleep 30
#sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/Dockerfile > /home/ubuntu/volumes/db3/Dockerfile
#sleep 2
sudo curl https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/db3-my.cnf > /home/ubuntu/volumes/db3/conf.d/my.cnf
sleep 2
#sudo docker build -t db3 /home/ubuntu/volumes/db3/.
#sleep 5
docker run -d \
--name db3 \
--hostname dbgc3 \
--add-host=dbgc1:172.17.0.6 \
--expose "3306" \
--expose "4444" \
--expose "4567" \
--expose "4568" \
--env MYSQL_ROOT_PASSWORD="rootpass" \
--env MYSQL_USER="maxscaleuser" \
--env MYSQL_PASSWORD="maxscalepass" \
--volume /home/ubuntu/volumes/db3/datadir:/var/lib/mysql \
--volume /home/ubuntu/volumes/db3/conf.d:/etc/mysql/mariadb.conf.d \
mariadb/server:10.4

sleep 30
docker exec -it db1 mysql -uroot -prootpass -e "SHOW STATUS LIKE 'wsrep_cluster_size'";

sudo curl  https://raw.githubusercontent.com/AsifHasan-ops/PE2-script/master/mariadb-galera-if-set.sh > /home/ubuntu/mariadb-galera-if-set.sh
sudo chmod +x /home/ubuntu/mariadb-galera-if-set.sh
/home/ubuntu/mariadb-galera-if-set.sh
