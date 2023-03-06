# web01 - centos
sudo -i
useradd devops # create new user
passwd devops
vi /etc/ssh/sshd_config # enable password authentication for ssh
systemctl restart sshd
visudo # add devops as sudoer
# add following line under root
# devops  ALL=(ALL) NOPASSWD: ALL
su - devops



# web02 - centos
sudo -i
useradd devops # create new user
passwd devops
vi /etc/ssh/sshd_config # enable password authentication for ssh
systemctl restart sshd
visudo # add devops as sudoer
# add following line under root
# devops  ALL=(ALL) NOPASSWD: ALL
su - devops



# web03 - ubuntu
sudo -i
adduser devops # create new user
passwd devops
vi /etc/ssh/sshd_config # enable password authentication for ssh
systemctl restart ssh
visudo # add devops as sudoer
# add following line under root
# devops  ALL=(ALL:ALL) NOPASSWD: ALL
su - devops



# scriptbox
for IP in $(cat webnodeIP.txt); do
    ssh devops@$IP
done

# webnodeIP.txt
# IP1
# IP2
# IP3


ssh-keygen
for IP in $(cat webnodeIP.txt); do
    ssh-copy-id devops@$IP
done

# change public key path
ssh -i $(key-path) devops@$IP

# remotely execute commands
ssh -i $(key-path) devops@$IP