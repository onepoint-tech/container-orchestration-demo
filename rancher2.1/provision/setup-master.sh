#!/bin/sh

# 
echo "setup-master.sh hostname=$(hostname) ip=$(hostname -i)"

# init rancher/server
# https://rancher.com/docs/rancher/v2.x/en/installation/single-node-install/#option-a-default-self-signed-certificate
# you can change "latest" to a specific tag (v2.0.6 for example), see https://hub.docker.com/r/rancher/rancher/tags/ 
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  rancher/rancher:v2.1.0-rc8