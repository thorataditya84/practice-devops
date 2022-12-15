#!/bin/bash

# update
sudo apt update
sudo apt upgrade -y

# install required packages
sudo apt install -y openjdk-8-jdk git
sudo apt install -y tomcat8 tomcat8-admin tomcat8-docs tomcat8-common
