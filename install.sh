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
sudo git clone https://github.com/HyperPanelx/Hyper-admin-panel.git
sudo git clone https://github.com/HyperPanelx/hyper-installation.git

sudo sh -c  "echo 'API_BASE=http://localhost:6655/' > ./Hyper-admin-panel/.env.production"
sudo sh -c 'echo "MONGO_PASSWD = \"password\"" > ./hyper-installation/.env'
# sudo python3 ssh-api-docker/hash.py
read -p "Enter IP address: " ip_address
read -p "Enter Web Port: " web_port
read -p "Enter SSH Port: "  ssh_port
read -p "Enter DB Password: "  db_passwd

sudo sed -i "s/localhost/$ip_address/g" ./Hyper-admin-panel/.env.production
sudo sed -i "s/8081/$web_port/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/2222/$ssh_port/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/mongo_password/$db_passwd/g" ./hyper-installation/docker-compose.yml
sudo sed -i "s/password/$db_passwd/g" ./hyper-installation/.env
sudo ufw allow $web_port
sudo ufw allow $ssh_port
# sudo tmux new-session -d -s 'kill' 'killer.py'
# sudo tmux new-session -d -s 'exdate' 'exdate.py'
cd hyper-installation/
sudo docker compose up -d 
sudo rm -rf ../hyper-installation/
sudo rm -rf ../Hyper-admin-panel/