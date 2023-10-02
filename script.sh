#!/bin/bash
sudo apt-get update

echo "Instalando o Docker"
sudo apt -y remove docker docker-engine docker.io containerd runc
    sudo apt update
    sudo apt -y install ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo docker-compose -f /tmp/docker/api-cep/docker-compose.yml up -d
    sudo docker-compose -f /tmp/docker/zabbix/docker-compose.yml up -d

mkdir /usr/share/nginx
mkdir /usr/share/nginx/html

echo "FROM nginx
COPY /site /usr/share/nginx/html/wavecafe
EXPOSE 80" > Dockerfile


    