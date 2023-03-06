#!/bin/bash

# assumption: nginx service is already installed on the system

if [ -f /var/run/nginx.pid ]; then
    echo "Nginx is running"
else
    echo "Starting Nginx service"
    service nginx start
fi
