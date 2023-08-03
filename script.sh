#!/bin/bash
sudo apt-get update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get  install docker.io -y
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull wordpress
sudo docker run -d -P  -e WORDPRESS_DB_HOST=my-rds-instance.ckqw8rifbuxe.us-east-1.rds.amazonaws.com:3306 -e WORDPRESS_DB_USER=admin -e WORDPRESS_DB_PASSWORD=password -e WORDPRESS_DB_NAME=wordpress wordpress
