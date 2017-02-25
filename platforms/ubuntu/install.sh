#!/bin/bash

echo "Installing Docker..." && echo "" &&
sudo apt-get update &&
sudo apt-get upgrade -y &&
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual python-pip &&
sudo apt-get install -y apt-transport-https ca-certificates software-properties-common libltdl7 libsystemd-journal0 &&
sudo apt-get -f install -y &&
wget https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_1.13.1-0~ubuntu-trusty_amd64.deb &&
sudo dpkg -i docker-engine_1.13.1-0~ubuntu-trusty_amd64.deb &&
echo "Installing Docker-Compose..." && echo "" &&
sudo usermod -aG docker $(whoami) &&
sudo pip install docker-compose &&
echo "Installing Rancher-Compose..." && echo "" &&
RCDL=$(curl -s https://api.github.com/repos/rancher/rancher-compose/releases/latest | grep browser_download_url | grep linux-amd64 | grep tar.gz | head -n 1 | cut -d '"' -f 4) &&
wget -qO- $RCDL | sudo tar xz -C /tmp &&
sudo find /tmp -name rancher-compose -exec mv -t /usr/bin {} + &&
echo "Adding Aliases..." && echo "" &&
curl https://raw.githubusercontent.com/emcniece/docker-rancher-install/master/aliases.txt >> ~/.profile &&
echo "-- INSTALL COMPLETE --" &&
echo "" &&
echo "1. Restart this terminal session" &&
echo "" &&
echo "2. Run Rancher: " &&
echo "docker pull rancher/server" &&
echo "docker run -d --name=rancher -p 8080:8080 rancher/server" &&
echo "" &&
echo "3. Generate API credentials for Rancher-Compose" &&
echo "http://localhost:8080/env/1a5/api/keys" &&
echo "" &&
echo "4. Add API keys to ~/.profile"
