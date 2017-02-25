#!/bin/bash

# Docker
echo "Installing Docker..."
echo ""
sudo apt-get update && sudo apt-get install -y docker.io python-pip &&
echo "Installing Rancher-Compose..." &&
echo "" &&
RCDL=$(curl -s https://api.github.com/repos/rancher/rancher-compose/releases/latest \
  | grep browser_download_url \
  | grep linux-amd64 \
  | grep tar.gz \
  | head -n 1 \
  | cut -d '"' -f 4) &&
wget -qO- $RCDL | sudo tar xz -C /tmp &&
sudo find /tmp -name rancher-compose -exec mv -t /usr/bin {} + &&
echo "Adding Aliases..." &&
echo "" &&
cat >~/.profile <<EOL
alias dps='docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias dlog='docker logs -f'

# Docker Cleanup
alias dclean_cont="docker ps -q --filter "status=exited" | xargs docker rm"
alias dclean_img="docker images -qf 'dangling=true' | xargs docker rmi"
alias dclean_vol="docker volume ls -qf 'dangling=true' | xargs docker volume rm"
alias dclean_all="dclean_cont && dclean_img && dclean_vol"

# Rancher Compose config
export RANCHER_URL=http://[THIS.BOXS.IP.ADDRESS]:8080/
export RANCHER_ACCESS_KEY=[KEY_FROM_RANCHER_API]
export RANCHER_SECRET_KEY=[SECRET_FROM_RANCHER_API]

EOL &&
echo "Pulling Rancher..." &&
echo "" &&
docker pull rancher/server &&
docker pull rancher/agent &&
echo "Installing Docker-Compose..." &&
echo "" &&
sudo usermod -aG docker $(whoami) &&
exec su -l $USER &&
sudo pip install docker-compose &&
echo "-- INSTALL COMPLETE --" &&
echo "" &&
echo "1. Run Rancher: " &&
echo "docker run -d --name=rancher -p 8080:8080 rancher/server" &&
echo "" &&
echo "2. Generate API credentials for Rancher-Compose" &&
echo "http://localhost:8080/env/1a5/api/keys" &&
echo "" &&
echo "3. Add API keys to ~/.profile" &&