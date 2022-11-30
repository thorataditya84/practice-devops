#!/bin/bash

# update
sudo yum update -y

# install required packages
sudo yum install -y epel-release socat erlang wget

# install rabbitmq
cd /tmp/
sudo wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_10/rabbitmq-server-3.6.10-1.el7.noarch.rpm
sudo wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_10/rabbitmq-server-3.6.10-1.el7.noarch.rpm.asc -O key
sudo rpm --import key
sudo rpm -Uvh rabbitmq-server-3.6.10-1.el7.noarch.rpm

# start rabbitmq-server
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server

# configure rabbitmq
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administratorRestart RabbitMQ service
sudo systemctl restart rabbitmq-server

# configure firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=25672/tcp --permanent
sudo firewall-cmd --reload
