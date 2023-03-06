#!/bin/bash

# update packages
sudo yum update -y
sudo yum install -y epel-release





# Memcached
sudo yum install -y memcached

sudo systemctl start memcached
sudo systemctl enable memcached

sudo memcached -p 11211 -U 11111 -u memcached -d





# RabbitMQ
sudo yum install -y socat erlang wget

cd /tmp/
sudo wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_10/rabbitmq-server-3.6.10-1.el7.noarch.rpm
sudo wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_10/rabbitmq-server-3.6.10-1.el7.noarch.rpm.asc -O key
sudo rpm --import key
sudo rpm -Uvh rabbitmq-server-3.6.10-1.el7.noarch.rpm

sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server

sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administratorRestart RabbitMQ service
sudo systemctl restart rabbitmq-server





# MySQL
sudo yum install -y git mariadb-server

sudo sed -i 's/^127.0.0.1/0.0.0.0/' /etc/my.cnf

sudo systemctl start mariadb
sudo systemctl enable mariadb

DATABASE_PASS='admin123'
sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

cd /tmp/
sudo git clone -b vp-rem https://github.com/devopshydclub/vprofile-repo.git

sudo mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/vprofile-repo/src/main/resources/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

sudo systemctl restart mariadb



db01 172.31.81.104
mc01 172.31.80.89
rmq01 172.31.91.60