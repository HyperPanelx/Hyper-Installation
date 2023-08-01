#!/bin/bash

echo 'version: "3"
services:
  backend:
    image: officialalikhani/ssh_api:v1.2.1
    container_name: api
    restart: always
    ports:
      - 6655:3838
      - 2222:22
    environment:
      ENVPORT: 3838
      ENVMONGOPASS: mongo_password
      ENVUSER: test
      ENVPASS: P@ssw0rd
    networks:
        - hyper-installation_default
networks:
  hyper-installation_default:
    external: true' > docker-compose.yml

read -p "Enter Web Port: " web_port
read -p "Enter SSH Port: "  ssh_port
read -p "Enter DB Password: "  db_passwd
read -p "Enter Your Panel Password: "  pass_panel
read -p "Enter Your Panel Username: "  user_panel

sudo sed -i "s/8081/$web_port/g" ./docker-compose.yml
sudo sed -i "s/2222/$ssh_port/g" ./docker-compose.yml
sudo sed -i "s/mongo_password/$db_passwd/g" ./docker-compose.yml
sudo sed -i "s/test/$pass_panel/g" ./docker-compose.yml
sudo sed -i "s/P@ssw0rd/$user_panel/g" ./docker-compose.yml

sudo docker stop api
sudo docker compose run -d
sudo rm -rf ./docker-compose.yml ./update.sh