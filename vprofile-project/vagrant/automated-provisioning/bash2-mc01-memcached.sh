#!/bin/bash

# update
sudo yum update -y

# install required packages
sudo yum install -y epel-release memcached

# start memcached
sudo systemctl start memcached
sudo systemctl enable memcached

# set memcached port
sudo memcached -p 11211 -U 11111 -u memcached -d

# configure firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=11211/tcp --permanent
sudo firewall-cmd --reload

sudo memcached -p 11211 -U 11111 -u memcached -d
