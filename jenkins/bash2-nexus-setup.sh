#!/bin/bash
sudo yum install wget java-1.8.0-openjdk.x86_64 -y

cd /opt
wget https://download.sonatype.com/nexus/3/nexus-3.29.0-02-unix.tar.gz
tar -xzvf nexus-3.29.0-02-unix.tar.gz
rm -rf nexus-3.29.0-02-unix.tar.gz

useradd nexus
echo 'run_as_user="nexus"' >> /opt/nexus-3.29.0-02/bin/nexus.rc

sudo ln -s /opt/nexus-3.29.0-02/bin/nexus /etc/init.d/nexus

echo "[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/etc/init.d/nexus start
ExecStop=/etc/init.d/nexus stop 
User=nexus
Restart=on-abort
TimeoutSec=600

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nexus.service

sudo chown nexus.nexus /opt/nexus-3.29.0-02/ -R
sudo chown nexus.nexus /opt/sonatype-work/ -R

sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service

ps -elf | grep nexus