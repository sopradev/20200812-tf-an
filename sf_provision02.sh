#!/bin/bash

sudo yum update -y
sudo yum install -y wget unzip

sudo yum install -y epel-release
sudo yum install -y ansible
sudo yum install -y git libc6-compat python-devel py-pip python3 sshpass openssh-client

## Terraform
## https://phoenixnap.com/kb/how-to-install-terraform-centos-ubuntu
#sudo wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
sudo wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip -P /tmp
sudo unzip /tmp/terraform_0.12.29_linux_amd64.zip -d /usr/local/bin

## Installing the Terraform CLI and the IBM Cloud Provider plug-in
mkdir $HOME/.terraform.d/plugins
wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.10.0/terraform-provider-ibm_1.10.0_linux_amd64.zip -P /tmp
unzip /tmp/terraform-provider-ibm_1.10.0_linux_amd64.zip -d $HOME/.terraform.d/plugins/
#mv $HOME/Downloads/terraform-provider-ibm* $HOME/.terraform.d/plugins/


## DOCKER
## https://docs.docker.com/engine/install/centos/
## Uninstall old versions
sudo yum remove -y docker \
                   docker-client \
                   docker-client-latest \
                   docker-common \
                   docker-latest \
                   docker-latest-logrotate \
                   docker-logrotate \
                   docker-engine
				  
sudo yum install -y yum-utils

## set up the Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y

## Install Docker Engine
## sudo yum list docker-ce --showduplicates | sort -r
###sudo yum install docker-ce docker-ce-cli containerd.io
###sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io
sudo yum install -y docker-ce-19.03.12-3.el7 docker-ce-cli-19.03.12-3.el7 containerd.io
#sudo yum install -y docker-ce-19.03.11-3.el7 docker-ce-cli-19.03.11-3.el7 containerd.io

## Start Docker
sudo systemctl start docker
sudo systemctl enable docker

