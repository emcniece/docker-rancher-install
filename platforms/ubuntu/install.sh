#!/bin/bash

echo "Installing Docker..." && echo "" &&
sudo apt-get update &&
sudo apt-get install -y docker.io python-pip &&
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
