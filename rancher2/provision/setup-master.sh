#!/bin/sh

# 
echo "setup-master.sh hostname=$(hostname) ip=$(hostname -i)"

# init rancher/server
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:v2.0.2
