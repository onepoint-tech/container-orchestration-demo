#!/bin/sh
echo "setup-node hostname=$(hostname) ip=$(hostname -i)"

# join the cluster
echo "$(hostname) join the cluster"
sudo kubeadm join --token 2c71ab.5292a7678e4fc5a9 192.169.32.20:6443 --discovery-token-unsafe-skip-ca-verification
