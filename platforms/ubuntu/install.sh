#!/bin/bash

# Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Docker-Compose
sudo usermod -aG docker $(whoami)
sudo apt-get -y install python-pip
sudo pip install docker-compose

# Rancher
docker pull rancher/server
docker pull rancher/agent
docker run -d -t rancher -p 8080:8080 rancher/server

# Rancher-Compose
RCDL=$(curl -s https://api.github.com/repos/rancher/rancher-compose/releases/latest | grep browser_download_url | grep linux-amd64 | grep tar.gz | head -n 1 | cut -d '"' -f 4)
wget -qO- $RCDL | tar xvz -C /tmp
sudo find /tmp -name rancher-compose -exec mv -t /usr/bin {} +
