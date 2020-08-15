#!/bin/bash

## logs
## cat /var/log/yum.log
## cat /tmp/terraform.log

#################################################################
## Update system
#################################################################
sudo yum update -y
sudo yum install -y wget unzip mailx

sudo yum install -y epel-release
sudo yum install -y ansible
sudo yum install -y git libc6-compat python-devel py-pip python3 sshpass openssh-client

wait $!

#################################################################
## Config mail for external smtp
#################################################################
echo "
set smtp=mail.gmx.com:587
set smtp-use-starttls
set ssl-verify=ignore
set nss-config-dir=/etc/pki/nssdb
set smtp-auth=login
set from=sap-hana-poc@gmx.com
set smtp-auth-user=sap-hana-poc@gmx.com
set smtp-auth-password=sap-hana-poc
" > /etc/mail.rc

### echo "Your message" | mail -v -s "Message Subject" roumen.alvarado@soprasteria.com


#################################################################
## INstall Terraform
#################################################################
## https://phoenixnap.com/kb/how-to-install-terraform-centos-ubuntu
#sudo wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
sudo rm -rf /tmp/*.zip
sudo rm -rf /usr/local/bin/terraf*
sudo wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip -P /tmp
sudo unzip /tmp/terraform_0.12.29_linux_amd64.zip -d /usr/local/bin

wait $!

#################################################################
## Installing the Terraform CLI and the IBM Cloud Provider plug-in
#################################################################
#mkdir $HOME/.terraform.d/plugins
sudo rm -rf /root/.terraform.d
mkdir -p /root/.terraform.d/plugins
wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.10.0/terraform-provider-ibm_1.10.0_linux_amd64.zip -P /tmp
wait $!
#unzip /tmp/terraform-provider-ibm_1.10.0_linux_amd64.zip -d $HOME/.terraform.d/plugins/
unzip /tmp/terraform-provider-ibm_1.10.0_linux_amd64.zip -d /root/.terraform.d/plugins/
#mv $HOME/Downloads/terraform-provider-ibm* $HOME/.terraform.d/plugins/


#################################################################
## Install DOCKER
#################################################################
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






#################################################################
## ssh key
#################################################################
## ~.ssh/id_rsa
echo "-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA1CslE+hsviK4AUDUKgWNkxmyaO3R016qFO9d7x5KQLQR7HwL
q9rQ0Pgxy3CCT6eOQHWPsmkQWHcGnyEzva1P7ASiSiZL8jdzP59IY1eqLCHJEFM0
nzEQ3PRaiHZWyKo+TZ889DZPTKhnU7D33k/JUD0o+Ra5BF2FmQtLIMp4cBJ0FpQT
AacjPCwNpmlwH0oHvflc5AwD7DbLqFzWgArD6fUsuTJuVjgcvz4710o62eEhh6Zz
oLJ5J58dUFmNn/jA4WTBsBYk3aJeUBES/AVYUyMgSTW6ApmPgc5O0w2Hbnu/x0h8
ou3iJujlK10l6MrijWJFe8rVQ3BUbHNCQXi3GwIDAQABAoIBAC819ocqhd/9K8Kj
oVJEcA9WfXuZx8Hn46LK7LUDoXQqXX6oz5QLGcIWKEZjn6uH1kCDqFkDxe5ZdfC8
252OTiVvlok3Yljge9WhZOMuI6C0V+A5E5GEwoLYILkS1BbMwxZUo6SX3Sdqpata
ypz+VgZzxYU/yCWvhcXbXHlMdGZDXS852kPEbkImQsKXvn6fdzfRDbni37tD9FoV
7XekU9AdZCsrIn6QDj3ecADIdKcoGqi0wWW6CabW7/fKU8PQIwOsudYHKpNyXMGo
zv0XsdKYHh7hOTgbAJHj7+HHMt0OJLGEAYwykztRCUJf0Wkns/4tgcQ9VbMazWU1
yTzsiKECgYEA7vlKN35kFmIDv65uBtUKjiZqxbQIVqXpVBqWZkXMBNokqH6pttTq
6bEDw5I19/8FcDXqPHdimZqzEKaMTc/Zlzt/XZC0C47jWydt+njBLmmHBL1X7GJP
hmBzXdsYlaqFz8KXn79MZRTRMWLGejbv4l0fIQMdo75nY870CF5qwEsCgYEA40jy
RL4BV7H3NKhK4TwZfUqFssjaPKiqwmOEH+ei58foLN3gBa5xS5kt66Kntn6T07ZV
d1C28p31E3G1l+Zh/xTLJ8qckBth2JaW+L2SKSKTZ83QNtNaFhrnXX8k3/7kQ7Cg
crcBMG3GqOR2y46WCxeSVSetbDb+2s/krzFDwnECgYAw1v4WDVzDPlDp0epmtw+r
MarMsRirLMldCPoH+OfTbgnj7c8dsLI6BJVyWOVyw8oGvt4acYPTRMyn8IHoPTyJ
Lf2/z50cZ52Luak+cYN5ytNvYosfopACNKAfZHHH1Mv4RBrc6Snh1rlSUI+j1qp8
Ju//vTVHi9hxi5BQTYuftQKBgHthBeK7Ig9w1DkJglxyO4QACEPdNFrpVIjhbL/F
BnG72xU//HQZFfdr17mqOlCetbCfshVrA2UAyiEcAO/MaDYIG6AmJIc11g+0749n
mQgrdMlMuFKKuMR3JlFiy6msvEzifLbJESQw8z6LhtFJPboXuZ/wQfwUfpRZdlKD
87yBAoGAZjPk2SmdNhl8AuROBq9IFmK81LQHhHkog3oX+enwyv1vMRO9EsV64Lpy
g8Bm7pbuco2Fg42vO799ZjL+w9dN6VFXfEGYASKB3gKRVCgywxRTOMkJyJugBwWt
OSlw75AnJFy9nDdZgOQ7ldnhIgW7vc+WSPhuEE5CjrPye0ODq5Q=
-----END RSA PRIVATE KEY-----
" > /root/.ssh/id_rsa

## ~.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUKyUT6Gy+IrgBQNQqBY2TGbJo7dHTXqoU713vHkpAtBHsfAur2tDQ+DHLcIJPp45AdY+yaRBYdwafITO9rU/sBKJKJkvyN3M/n0hjV6osIckQUzSfMRDc9FqIdlbIqj5Nnzz0Nk9MqGdTsPfeT8lQPSj5FrkEXYWZC0sgynhwEnQWlBMBpyM8LA2maXAfSge9+VzkDAPsNsuoXNaACsPp9Sy5Mm5WOBy/PjvXSjrZ4SGHpnOgsnknnx1QWY2f+MDhZMGwFiTdol5QERL8BVhTIyBJNboCmY+Bzk7TDYdue7/HSHyi7eIm6OUrXSXoyuKNYkV7ytVDcFRsc0JBeLcb jambo@mambo.com" > /root/.ssh/id_rsa.pub

## ~.ssh/knnown_hosts
echo "innersource.soprasteria.com,40.66.59.79 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBO6V+xHHX52SjDLkxtHivqZAOl9TjFiWEUB7F7PV3+/XeK1DtSmqXX9QTnLjQiCJg9F5oTGtltXGku4RV+DE67s=" >> /root/.ssh/known_hosts

## https://gist.github.com/grenade/6318301
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/authorized_keys
chmod 644 /root/.ssh/id_rsa.pub
chmod 644 /root/.ssh/known_hosts





#################################################################
## Config sopra repo
#################################################################
xrepo_temp=/tmp/sopra-sap-hana
xrepo_gitlab=innersource.soprasteria.com/roumen.alvarado/ansible-test-00.git
#xrepo_gitlab=innersource.soprasteria.com:luis-alberto.pedroza/IBM-SAP-POC.git
xjenkins_home=/root/jenkins_home

# remove all docker containers and images
docker kill $(docker ps -q)
#docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

wait $!

# remove innersource repo if exists
sudo rm -rf $xrepo_temp



#################################################################
# clone innersource repo
#################################################################
#git clone ssh://git@innersource.soprasteria.com/roumen.alvarado/ansible-test-00.git $xrepo_temp
git clone ssh://git@$xrepo_gitlab $xrepo_temp
#git clone git@$xrepo_gitlab $xrepo_temp

wait $!



#################################################################
# Config JENKINS_HOME
#################################################################
sudo rm -rf $xjenkins_home
sudo mkdir $xjenkins_home
sudo chmod 777 $xjenkins_home
cp -R /tmp/sopra-sap-hana/xjenkins/jenkins/jenkins_home/credentials.xml $xjenkins_home/
mkdir -p $xjenkins_home/secrets
#cp -R /tmp/sopra-sap-hana/xjenkins/jenkins/jenkins_home/secret* $xjenkins_home/

wait $!



#################################################################
# Terraform test
#################################################################
#mkdir -p /root/00-tf-test
cd /tmp/sopra-sap-hana/zterraform

export TF_LOG="INFO"
export TF_LOG_PATH="/tmp/terraform.log"

# https://learn.hashicorp.com/tutorials/terraform/automate-terraform

terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan


#################################################################
# Run Ansible playbook
#################################################################
#
#ansible-playbook /tmp/sopra-sap-hana/ansible/site.yml -vvv
ansible-playbook /tmp/sopra-sap-hana/xjenkins/ansible/site.yml



#################################################################
# Send mail
#################################################################
ip=$(/sbin/ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
hn=$(hostname)
echo "Server $hn is alredy up and ready." > /tmp/msg.txt
echo "Open your browser to https://$ip:8080 to run Jenkins jobs" >> /tmp/msg.txt
echo "Your message" | mail -v -s "Message Subject" roumen.alvarado@soprasteria.com

cat /tmp/msg.txt | mail -v -s "IBMCloud virtual server instance (VSI): $hn" roumen.alvarado@soprasteria.com