#!/usr/bin/env bash
set -x
apt-get update -y && apt-get --print-uris --yes install $1 | grep ^\' | cut -d\' -f2 > $HOME/packages/$1.list
cd $HOME/packages
wget -cv --input-file $1.list
