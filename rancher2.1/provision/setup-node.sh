#!/bin/sh
echo "setup-node hostname=$(hostname) ip=$(hostname -i)"


RANCHER_SAVED_IMAGES_PATH=/vagrant/rancher-saved-images/rancher-images.tar.gz
echo "Try to pull image from $RANCHER_SAVED_IMAGES_PATH if exists"
if [ -f "$RANCHER_SAVED_IMAGES_PATH" ]
then
  echo "Loading Rancher saved Images from $RANCHER_SAVED_IMAGES_PATH"
  docker load < $RANCHER_SAVED_IMAGES_PATH
else
  echo "No file $RANCHER_SAVED_IMAGES_PATH" 
fi
