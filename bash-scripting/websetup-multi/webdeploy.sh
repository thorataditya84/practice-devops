#!/bin/bash

FILENAME=webnodeIP.txt
echo "checking connection for all machines in file $FILENAME"

for IP in $(cat $FILENAME); do
    echo "----------------------------------------"
    echo "Running websetup on $IP"
    echo "----------------------------------------"

    scp multiwebsetup.sh devops@$IP:/home/devops/scripts
    scp vars.txt devops@$IP:/home/devops/scripts
    ssh devops@$IP '
        chmod u+x /home/devops/scripts/multiwebsetup.sh
        sudo /home/devops/scripts/multiwebsetup.sh >> /tmp/websetup.log 2>> /tmp/websetup.log
        echo
        echo
        sudo cat /tmp/websetup.log
        echo
        echo
    '

done
