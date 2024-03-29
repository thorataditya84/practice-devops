# ----- ----- ----- db01 ----- ----- -----

sudo -i
yum update -y
yum install -y epel-release git mariadb-server
systemctl start mariadb
systemctl enable mariadb

echo DATABASE_PASS='admin123' >> /etc/profile
source /etc/profile

sudo cp /vagrant/db_backup.sql /tmp/db_backup.sql

mysql_secure_installation

sudo mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON accounts.* TO 'admin'@'app01';"
sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES;"


systemctl start firewalld
systemctl enable firewalld
firewall-cmd --get-active-zones
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload
systemctl restart mariadb





# ----- ----- ----- mc01 ----- ----- -----

sudo -i
yum update -y
yum install -y epel-release memcached
systemctl start memcached
systemctl enable memcached

memcached -p 11211 -U 11111 -u memcached -d


systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld
firewall-cmd --add-port=11211/tcp --permanent
firewall-cmd --reload
memcached -p 11211 -U 11111 -u memcache -d





# ----- ----- ----- rmq01 ----- ----- -----

sudo -i
yum update -y
yum install -y epel-release socat erlang wget

cd /tmp/
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_10/rabbitmq-server-3.6.10-1.el7.noarch.rpm
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_10/rabbitmq-server-3.6.10-1.el7.noarch.rpm.asc -O key
rpm --import key
rpm -Uvh rabbitmq-server-3.6.10-1.el7.noarch.rpm

systemctl start rabbitmq-server
systemctl enable rabbitmq-server

sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administratorRestart RabbitMQ service
systemctl restart rabbitmq-server



systemctl start firewalld
systemctl enable firewalld
firewall-cmd --get-active-zones
firewall-cmd --zone=public --add-port=25672/tcp --permanent
firewall-cmd --reload





# ----- ----- ----- app01 ----- ----- -----

sudo -i
yum update -y
yum install -y epel-release java-1.8.0-openjdk git maven wget

cd /tmp/
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz
tar xzvf apache-tomcat-8.5.37.tar.gz

useradd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat

rsync -avzh /tmp/apache-tomcat-8.5.37/ /usr/local/tomcat8/

chown -R tomcat.tomcat /usr/local/tomcat8

cp /vagrant/tomcat.service /etc/systemd/system/tomcat.service

systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat


systemctl start firewalld
systemctl enable firewalld
firewall-cmd --get-active-zones
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload


git clone -b local-setup https://github.com/devopshydclub/vprofile-project.git

cd vprofile-project/
sudo cp /vagrant/application.properties src/main/resources/application.properties

mvn install

systemctl stop tomcat

rm -rf /usr/local/tomcat8/webapps/ROOT*

cp target/vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war

systemctl start tomcat

chown tomcat.tomcat usr/local/tomcat8/webapps -R

systemctl restart tomcat






# ----- ----- ----- web01 ----- ----- -----

sudo -i
apt update
apt upgrade -y
apt install -y nginx

sudo cp /vagrant/vproapp /etc/nginx/sites-available/vproapp

rm -rf /etc/nginx/sites-enabled/default

ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

systemctl restart nginx
