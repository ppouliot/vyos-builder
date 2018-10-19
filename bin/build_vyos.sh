#!/usr/bin/env bash
set -x
git clone https://github.com/vyos/vyos-build /usr/src/vyos-build
rsync -av $HOME/packages/*.deb /usr/src/vyos/packages/
cd /usr/src/vyos-build
./configure
make iso
copy /usr/src/vyos-build/build/*.iso $HOME/
