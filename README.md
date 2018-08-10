# Container Orchestration Demo Cluster init with Vagrant

## Description

This project allow to init a multi machines cluster to test some container orchestration solution.
Platorm are provisioned and initialized with vagrant and VirtualBox

- master
- node1
- node2

## available platform

- Kubernetes Vanilla init with kubeadm
- Docker EE 2 (UCP 3.x)
- Rancher 2 (need custom option to create cluster see. [readme](./rancher2/README.md))

## vagrant command

### Init the cluster
In the folder of your choice
vagrant up

### Stop
All the cluster
```vagrant halt```

A machine
```vagrant halt <machine-name>```

### Connection
vagrant ssh <machine-name>

## Config
### IP
The static IP are in the .\provision\etc_hosts_extend file used to init  /etc/hosts of each machine (to be improved)

