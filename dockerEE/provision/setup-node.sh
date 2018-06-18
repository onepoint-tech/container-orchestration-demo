#!/bin/sh
echo "setup-node hostname=$(hostname) ip=$(hostname -i)"

# join the swarm
docker swarm join --token $(cat /vagrant/generated-conf/swarm-join-token) 192.168.33.10:2377

