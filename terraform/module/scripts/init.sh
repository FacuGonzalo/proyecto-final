#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
  stable" -y
sudo sysctl -p
sudo apt-get update &&
sudo apt-get install -y docker-ce apt-transport-https curl -y &&
sudo apt-get install python3-pip -y
sudo usermod -aG docker ubuntu &&
sudo systemctl restart docker &&
sudo systemctl enable docker.service &&
sudo systemctl daemon-reload
sudo docker run -d --rm --net="host" --pid="host" -v "/:/host:ro,rslave" quay.io/prometheus/node-exporter:latest
sudo docker run -d --rm -p80:3000 --name=${DOCKER_CONTAINER} ${DOCKER_IMAGE}