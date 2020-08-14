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
#mkdir $HOME/.terraform.d/plugins
mkdir /root/.terraform.d/plugins
wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.10.0/terraform-provider-ibm_1.10.0_linux_amd64.zip -P /tmp
#unzip /tmp/terraform-provider-ibm_1.10.0_linux_amd64.zip -d $HOME/.terraform.d/plugins/
unzip /tmp/terraform-provider-ibm_1.10.0_linux_amd64.zip -d /root/.terraform.d/plugins/
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










## Config sopra repo
xrepo_temp=/tmp/sopra-sap-hana
xrepo_gitlab=innersource.soprasteria.com/roumen.alvarado/ansible-test-00.git
#xrepo_gitlab=innersource.soprasteria.com:luis-alberto.pedroza/IBM-SAP-POC.git
xjenkins_home=/home/jenkins_home

# remove all docker containers and images
docker kill $(docker ps -q)
#docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

wait $!

# remove innersource repo if exists
sudo rm -rf $xrepo_temp

# clone innersource repo
#git clone ssh://git@innersource.soprasteria.com/roumen.alvarado/ansible-test-00.git $xrepo_temp
############git clone ssh://git@$xrepo_gitlab $xrepo_temp
#git clone git@$xrepo_gitlab $xrepo_temp

wait $!

# remove JENKINS_HOME
sudo rm -rf $xjenkins_home
############sudo mkdir $xjenkins_home
############sudo chmod 777 $xjenkins_home
############cp -R /tmp/sopra-sap-hana/jenkins/jenkins_home/credentials.xml $xjenkins_home/

mkdir $xjenkins_home/secrets
############cp -R /tmp/sopra-sap-hana/jenkins/jenkins_home/secret* $xjenkins_home/

wait $!

#
#ansible-playbook /tmp/sopra-sap-hana/ansible/site.yml -vvv
############ansible-playbook /tmp/sopra-sap-hana/ansible/site.yml
