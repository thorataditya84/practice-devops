#!/bin/bash

FILENAME=webnodeIP.txt
echo "checking connection for all machines in file $FILENAME"

for IP in $(cat $FILENAME); do
    ssh devops@$IP hostname
    if [ $? -eq 0 ]; then
        echo "$IP is connected over SSH"
    else
        echo "$IP not connected over SSH"
    fi
done
