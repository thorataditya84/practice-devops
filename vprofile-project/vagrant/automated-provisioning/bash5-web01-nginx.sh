#!/bin/bash

# update
sudo apt update
sudo apt upgrade -y

# install required packages
sudo apt install -y nginx

# configure nginx
sudo cp /vagrant/vproapp /etc/nginx/sites-available/vproapp
sudo rm -rf /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

sudo systemctl restart nginx
