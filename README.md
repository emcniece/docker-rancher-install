#Docker/Rancher Installer

This is a collection of scripts for fresh installing several packages on various operating systems:

## Install Packages

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker-Compose](https://docs.docker.com/compose/install/)
- Rancher
- [Rancher-Compose](https://docs.rancher.com/rancher/rancher-compose/)
- Various Bash aliases

##Supported Platforms

- Ubuntu

##Run Installer

```sh
curl -s https://raw.githubusercontent.com/emcniece/docker-rancher-install/master/platforms/ubuntu/install.sh | bash
```

##Post-Install

Be sure to do some cleanup after installing:

- Add your user to the Docker group: `usermod -aG docker [username]`
- [Add Rancher API keys for Rancher-Compose](https://docs.rancher.com/rancher/v1.4/en/cattle/rancher-compose/#setting-up-rancher-compose-with-rancher-server)