#!/bin/sh

# Docker EE URL
echo "setup hostname=$(hostname) ip=$(hostname -i)"

sudo su -

# check if private docker EE repo is provided
if [ ! -f "/vagrant/private-conf/docker_private_repo.txt" ]
then
  (>&2 echo ">>> file docker_private_repo.txt not found in private-conf folder <<<")
  exit 1
fi

# check if docker EE licence is provided
if [ ! -f "/vagrant/private-conf/docker_subscription.lic" ]
then
  (>&2 echo ">>> file docker_subscription.lic not found in private-conf folder <<<")
  exit 1
fi

#extend /etc/hosts
cat /vagrant/provision/etc_hosts_extend >> /etc/hosts

#update
apt-get update > /dev/null

# Uninstall old versions
apt-get remove docker docker-engine docker-ce docker.io


# Docker
# https://docs.docker.com/install/linux/docker-ee/ubuntu/

# DOCKER_EE_URL="https://storebits.docker.com/ee/ubuntu/sub-5d2ab1c4-a679-4d15-af96-ef822463df9b"
DOCKER_EE_URL="$(cat /vagrant/private-conf/docker_private_repo.txt)"

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y


#Add Docker’s official GPG key using your customer Docker EE repository URL:
curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -

# verify that you now have the key with the fingerprint DD91 1E99 5A64 A202 E859 07D6 BC14 F10B 6D08 5F96, by searching for the last eight characters of the fingerprint. Use the command as-is. It works because of the variable you set earlier.
apt-key fingerprint 6D085F96

# Use the following command to set up the STABLE repository. Use the command as-is. It works because of the variable you set earlier.
# Pour installer une version de TEST replacer stable par test
add-apt-repository \
   "deb [arch=amd64] $DOCKER_EE_URL/ubuntu \
   $(lsb_release -cs) \
   stable"

#Update the apt package index.
apt-get update

#Affichage des versions
apt-cache madison docker-ee

apt-get install docker-ee -y

usermod -aG docker vagrant


