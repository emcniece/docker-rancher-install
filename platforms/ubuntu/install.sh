#!/bin/bash

# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Docker
apt-get update
apt-get install -y \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual

apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
add-apt-repository \
  "deb https://apt.dockerproject.org/repo/ \
  ubuntu-$(lsb_release -cs) \
  main"

apt-get update
apt-get -y install docker-engine