#!/bin/sh
RANCHER_VERSION=v2.0.8
RANCHER_SAVE_IMAGES_DIR=/vagrant/rancher-saved-images/$RANCHER_VERSION
RANCHER_TAR_FILE_NAME=rancher-images.tar.gz

echo "Save Images $RANCHER_VERSION"

if [ ! -d "$RANCHER_SAVE_IMAGES_DIR" ]
then
  mkdir -p $RANCHER_SAVE_IMAGES_DIR
fi

cd $RANCHER_SAVE_IMAGES_DIR

if [ ! -f "$RANCHER_SAVE_IMAGES_DIR/$RANCHER_TAR_FILE_NAME" ]
then
  curl -fsSL https://github.com/rancher/rancher/releases/download/$RANCHER_VERSION/rancher-save-images.sh -o rancher-save-images.sh
  # Rancher rancher-save-images.sh save docker images to a local file named rancher-images.tar.gz
  sh rancher-save-images.sh
fi

