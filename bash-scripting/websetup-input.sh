: '
sudo -i

cat /etc/redhat-release

cd /opt/
mkdir scripts
cd scripts

vi websetup-input.sh
'

#!/bin/bash

# This sript will setup sloopa website on CENTOS 7.5 HTTPD service.

# Declaring Variables
# SVC=httpd
# WEBURL=https://www.tooplate.com/zip-templates/2098_health.zip
# PACKS='httpd wget unzip'

read -p "Enter SVC Name: " SVC
read -p "Enter WEBURL: " WEBURL
read -p "Enter Package Names: " PACKS
read -p "Enter Dir Name: " WEBDIR

# Setup packages
echo "----------------------------------------"
echo "Installing Packages"
echo '----------------------------------------'
yum install -y $PACKS
echo

# Start & Enable Service
echo "----------------------------------------"
echo "Starting Services"
echo '----------------------------------------'
systemctl start $SVC
systemctl enable $SVC
echo

# Copy website data to apache Doc Root Dir.
echo "----------------------------------------"
echo "Copying Website Data"
echo '----------------------------------------'
cd /tmp && wget -O website.zip $WEBURL
cd /tmp && unzip website.zip
cp -r /tmp/$WEBDIR/* /var/www/html/
echo

# Restart Service
echo "----------------------------------------"
echo "Restarting Services"
echo '----------------------------------------'
systemctl restart $SVC
echo

: '
chmod u+x websetup-input.sh
./websetup-input.sh
'
