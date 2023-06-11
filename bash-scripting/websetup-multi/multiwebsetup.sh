#!/bin/bash

: ' This sript will setup
website from tooplate on
CENTOS 7 / Ubuntu 16
HTTPD / apache2 service.
'

source /tmp/vars.txt

yum --help >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    echo "----------------------------------------"
    echo "RedHat based OS detected"
    echo '----------------------------------------'
    SVC=httpd
    PACKS='httpd wget unzip'

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
else
    echo "----------------------------------------"
    echo "Debian based OS detected"
    echo '----------------------------------------'
    SVC=apache2
    PACKS='apache2 wget unzip'

    # Setup packages
    echo "----------------------------------------"
    echo "Installing Packages"
    echo '----------------------------------------'
    apt install -y $PACKS
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
fi
