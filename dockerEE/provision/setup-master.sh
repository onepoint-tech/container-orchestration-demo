#!/bin/sh

UCP_VERSION=3.0.2

# 
echo "setup-master hostname=$(hostname) ip=$(hostname -i)"

# init du repertoire generated-conf
mkdir -p /vagrant/generated-conf
cd /vagrant/generated-conf/

if [ ! -f "/vagrant/generated-conf/ucp_images_$UCP_VERSION.tar.gz" ]
then
  wget https://packages.docker.com/caas/ucp_images_$UCP_VERSION.tar.gz
fi
docker load < ucp_images_$UCP_VERSION.tar.gz


UCP_ADMIN_USER=admin
UCP_ADMIN_PASSWORD=admin1234

# init UCP 192.169.33.10
# https://docs.docker.com/ee/ucp/admin/install/plan-installation/#avoid-ip-range-conflicts
docker container run --rm -i --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:$UCP_VERSION install \
  --host-address 192.169.33.10 \
  --admin-username=admin \
  --admin-password=admin1234 \
  --license "$(cat /vagrant/private-conf/docker_subscription.lic)"
#
## init DTR sur le master
docker run -i --rm \
  docker/dtr:2.5.3 install \
  --ucp-node master \
  --ucp-url https://192.169.33.10 \
  --ucp-insecure-tls \
  --ucp-username admin \
  --ucp-password admin1234 \
  --replica-https-port 9443 \
  --replica-http-port 9080 \
  --dtr-external-url https://192.169.33.10:9443



# print du token
docker swarm join-token -q worker > /vagrant/generated-conf/swarm-join-token