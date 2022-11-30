#!/bin/bash

# update
sudo yum update -y

# install required packages
sudo yum install -y epel-release java-1.8.0-openjdk git maven wget

# download tomcat
cd /tmp/
sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz
sudo tar xzvf apache-tomcat-8.5.37.tar.gz

# configure tomcat
sudo useradd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat
sudo rsync -avzh /tmp/apache-tomcat-8.5.37/ /usr/local/tomcat8/
sudo chown -R tomcat.tomcat /usr/local/tomcat8
sudo cp /vagrant/tomcat.service /etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

# configure firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload

# project setup
sudo git clone -b local-setup https://github.com/devopshydclub/vprofile-project.git

cd vprofile-project/
sudo cp /vagrant/application.properties src/main/resources/application.properties

sudo mvn install

sudo systemctl stop tomcat
sudo rm -rf /usr/local/tomcat8/webapps/ROOT
sudo rm -rf /usr/local/tomcat8/webapps/ROOT.war
sudo cp target/vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war
sudo systemctl start tomcat
sudo chown tomcat.tomcat /usr/local/tomcat8/webapps -R
sudo systemctl restart tomcat
