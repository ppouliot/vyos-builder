#!/usr/bin/env bash

VYOS_BRANCH=current
IMAGE=vyos-builder

# Removing old and pulling new images
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)

if [ !  -f packages ]; then
  mkdir -p packages
fi
if [ !  -f vyos-build ]; then
  getting source
  git clone https://github.com/vyos/vyos-build
  cd vyos-build 
  git checkout $VYOS_BRANCH 
  cd ..
fi
docker build -t $IMAGE -f vyos-build/Dockerfile .
docker run -v $PWD:/root -t $IMAGE /bin/sh -c '/root/bin/get_packages.sh openconnect'
sudo docker run --privileged -v $PWD:/root -t $IMAGE /bin/sh -c '/root/bin/build_vyos.sh'

#vyos-build/data/live-build-config/package-lists/vyos-utils.list.chroot
