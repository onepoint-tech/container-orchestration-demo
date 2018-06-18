#!/bin/sh
echo "setup hostname=$(hostname) ip=$(hostname -i)"

sudo -i
 
#extend /etc/hosts
cat /vagrant/provision/etc_hosts_extend >> /etc/hosts

#update
apt-get update > /dev/null

#Disable swap to avoid  fatal errors occurred:unning with swap on is not supported. Please disable swap
swapoff -a
sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Docker

echo "(1/4) Installing kubeadm on hostname=$(hostname) ip=$(hostname -i)"

# https://kubernetes.io/docs/setup/independent/install-kubeadm/ 
# ne pas changer le cgroupdriver car celui utilisé par Docker ET celui de kubectl sont deja TOUS LES DEUX cgroupfs


apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')

# le groupe docker est initialise lors de l'install de docker-ce
usermod -aG docker vagrant



# kubeadm, kubelet and kubectl
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
