#!/bin/bash

echo "----------------------------------------"
echo "Welcome $USER on $HOSTNAME."

FREERAM=$(free -m | grep Mem | awk '{print $7}')
LOAD=$(uptime | awk '{print $10}')
ROOTFREE=$(df -h | grep 'mnt' | awk '{print $4}')

echo "----------------------------------------"
echo "Available free RAM is $FREERAM MB"
echo "----------------------------------------"
echo "Current load average $LOAD"
echo "----------------------------------------"
echo "Free ROOT partition size is $ROOTFREE"
echo "----------------------------------------"
