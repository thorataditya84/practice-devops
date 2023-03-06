: '
sudo -i

cat /etc/redhat-release

cd /opt/
mkdir scripts
cd scripts

vi websetup-smart.sh
'

#!/bin/bash

: ' This sript will setup
website from tooplate on
CENTOS 7 / Ubuntu 16
HTTPD / apache2 service.
'
# Declaring Variables
# WEBURL=https://www.tooplate.com/zip-templates/2104_sloopa.zip
# WEBURL=https://www.tooplate.com/zip-templates/2098_health.zip
read -p "Enter WEBURL: " WEBURL
WEBDIR=$(echo $WEBURL | cut -d/ -f5 | cut -d. -f1)

echo "Dir Name is $WEBDIR"
read -p "Enter Y to continue, E to enter Dir Name, N to stop: " USRDEC

if [[ "$USRDEC" = "Y" ]] || [[ "$USRDEC" = "y" ]]; then
    echo "----------------------------------------"
    echo "Starting Websetup"
    echo '----------------------------------------'
elif [[ "$USRDEC" = "E" ]] || [[ "$USRDEC" = "e" ]]; then
    read -p "Enter Dir Name: " WEBDIR
    echo "----------------------------------------"
    echo "Starting Websetup"
    echo '----------------------------------------'
elif [[ "$USRDEC" = "N" ]] || [[ "$USRDEC" = "n" ]]; then
    echo "----------------------------------------"
    echo "Script execution cancelled by user"
    echo '----------------------------------------'
    exit 2
else
    echo "----------------------------------------"
    echo "Invalid input please retry"
    echo '----------------------------------------'
    exit 2
fi

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

: '
chmod u+x websetup-smart.sh
./websetup-smart.sh
'
