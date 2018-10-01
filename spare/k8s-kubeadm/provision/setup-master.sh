#!/bin/sh

# 
echo "setup-master hostname=$(hostname) ip=$(hostname -i)"

# $(hostname -i) return 127.0.0.1 192.169.32.20, so IP must be hard coded
# add --pod-network-cidr=10.244.0.0/16 for flannel
echo "(2/4) init the cluster"
sudo kubeadm init --apiserver-advertise-address 192.169.32.20 --pod-network-cidr=10.244.0.0/16 --token 2c71ab.5292a7678e4fc5a9 --token-ttl 0


# allow current user (root) to use kubectl (mandatory to install a pod network)
echo "add kube config in $HOME/.kube"
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "(3/4) Installing a pod network : Flannel"
# https://stackoverflow.com/questions/47845739/configuring-flannel-to-use-a-non-default-interface-in-kubernetes
kubectl apply -f /vagrant/provision/kube-flannel.yml


# allow vagrant user to use kubectl
# here current user is still root and $HOME = /root so I set REGULAR_USER and REGULAR_USER_HOME as a work around
export REGULAR_USER="vagrant"
export REGULAR_USER_HOME="/home/$REGULAR_USER"
echo "allow $REGULAR_USER user to use kubectl"
echo "add kube config in $REGULAR_USER_HOME/.kube"
mkdir -p $REGULAR_USER_HOME/.kube
sudo cp /etc/kubernetes/admin.conf $REGULAR_USER_HOME/.kube/config
sudo chown $REGULAR_USER:$REGULAR_USER $REGULAR_USER_HOME/.kube/config

# deploiement du dashboard
echo "deploiement du dashboard"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# init du repertoire generated-conf
mkdir -p /vagrant/generated-conf
# copie du fichier admin.conf pour permettre la connection au cluster depuis la machine hote
sudo cp /etc/kubernetes/admin.conf /vagrant/generated-conf

echo "gestion acces du dashboard"
# creation du user admin pour le dashbord
kubectl create -f /vagrant/provision/admin-user.yaml
sleep 5
# attribution du role admin
kubectl create -f /vagrant/provision/clusterRoleBinding.yaml
# force pause to fix Error from server (NotFound): secrets "admin-user" not found
sleep 10
# affichage du token
kubectl -n kube-system describe secret admin-user
# copie du token pour utilisation ulterieur
kubectl -n kube-system describe secret admin-user > /vagrant/generated-conf/admin-user-token.txt
