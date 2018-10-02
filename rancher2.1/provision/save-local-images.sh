#!/bin/sh
RANCHER_SAVE_IMAGES_DIR=/vagrant/rancher-saved-images

RANCHER_SAVED_IMAGES_PATH=$RANCHER_SAVE_IMAGES_DIR/rancher-images.tar.gz

echo "Save Images"

if [ ! -d "$RANCHER_SAVE_IMAGES_DIR" ]
then
  mkdir -p $RANCHER_SAVE_IMAGES_DIR
fi

cd $RANCHER_SAVE_IMAGES_DIR

if [ ! -f "$RANCHER_SAVED_IMAGES_PATH" ]
then
  docker save $(docker images -q) -o $RANCHER_SAVED_IMAGES_PATH
else
  echo "File allready exists $RANCHER_SAVED_IMAGES_PATH"
fi

