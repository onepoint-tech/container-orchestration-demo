#!/bin/sh
echo "setup hostname=$(hostname) ip=$(hostname -i)"

sudo su -
 
#extend /etc/hosts
cat /vagrant/provision/etc_hosts_extend >> /etc/hosts

#update
apt-get update > /dev/null

# GIT
#apt-get install git -y > /dev/null

# Docker
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    python-software-properties \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

# install last version of Docker-ce
apt-get install -y docker-ce

usermod -aG docker vagrant
