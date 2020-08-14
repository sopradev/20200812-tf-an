#!/bin/bash

#sudo yum install -y epel-release
#sudo yum install -y ansible
sudo yum install -y epel-release git libc6-compat ansible python-devel py-pip python3 sshpass openssh-client


# DOCKER
# https://docs.docker.com/engine/install/centos/
# Uninstall old versions

# sudo yum remove -y docker \
#                    docker-client \
#                    docker-client-latest \
#                    docker-common \
#                    docker-latest \
#                    docker-latest-logrotate \
#                    docker-logrotate \
#                    docker-engine
				  
				  
sudo yum install -y yum-utils

# set up the Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y

# Install Docker Engine
#sudo yum install docker-ce docker-ce-cli containerd.io
#sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io
sudo yum install -y docker-ce-19.03.12-3.el7 docker-ce-cli-19.03.12-3.el7 containerd.io

# Start Docker
sudo systemctl start docker

