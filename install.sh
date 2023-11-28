#!/bin/bash

sudo apt-get update -y
sudo dpkg --configure -a
sudo apt-get install ca-certificates curl gnupg git tmux -y
sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl --now enable docker
sudo git clone https://github.com/HyperPanelx/hyper-front-vite.git
sudo git clone https://github.com/HyperPanelx/hyper-installation.git
htppassord='echo $(htpasswd -nb user password) | sed -e s/\\$/\\$\\$/g'
sudo sh -c  "echo 'APP_API_BASE=http://localhost:6655/' > ./hyper-front-vite/.env.production.local"
sudo sh -c 'echo "MONGO_PASSWD = \"password\"" > ./hyper-installation/.env'
# sudo python3 ssh-api-docker/hash.py
read -p "Enter IP Address: " ip_address
read -p "Enter Email Address: " email_address
read -p "Enter Domain Name: " domain_name
read -p "Enter Panel User: " PAUSER
read -p "Enter Panel Password: " PAPASSWD
read -p "Enter Web Port: " web_port
read -p "Enter SSH Port: "  ssh_port
read -p "Enter DB Password: "  db_passwd

sudo sed -i "s/localhost/$ip_address/g" ./hyper-front-vite/.env.production.local
sudo sed -i "s/__email__/$email_address/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/__domainname__/$domain_name/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/__htpasswd__/$htppassord/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/_web_port_/$web_port/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/_ENVUSER_/$PAUSER/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/_ENVPASS_/$PAPASSWD/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/_ssh_port_/$ssh_port/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/_mongo_password_/$db_passwd/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/password/$db_passwd/g" ./hyper-installation/.env
sudo ufw allow $web_port
sudo ufw allow $ssh_port
cd hyper-installation/
sudo docker compose up -d 
sudo rm -rf ../hyper-installation/
sudo rm -rf ../hyper-front-vite/
