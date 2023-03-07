#!/bin/bash

FILENAME=webnodeIP.txt
echo "checking connection for all machines in file $FILENAME"

for IP in $(cat $FILENAME); do
    echo "----------------------------------------"
    echo "Running websetup on $IP"
    echo "----------------------------------------"

    scp multiwebsetup.sh devops@$IP:/tmp
    scp vars.txt devops@$IP:/tmp
    ssh devops@$IP '
        sudo chmod u+x /tmp/multiwebsetup.sh
        sudo /tmp/multiwebsetup.sh >> /tmp/websetup.log 2>> /tmp/websetup.log
        echo
        sudo cat /tmp/websetup.log
        echo
    '

done
