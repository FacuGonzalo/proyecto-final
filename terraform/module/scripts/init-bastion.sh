#!/bin/bash

#############################################################
# Instalación de dependencias
#############################################################

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
  stable" -y
sudo sysctl -p
sudo apt-get update &&
sudo apt-get install -y docker-ce docker-compose apt-transport-https curl ansible -y &&
sudo usermod -aG docker ubuntu &&
sudo systemctl restart docker &&
sudo systemctl enable docker.service &&
sudo systemctl daemon-reload
sudo apt-get install python3-pip -y
sudo pip install boto3

#############################################################
# Ansiible
#############################################################

sudo mkdir /etc/ansible

sudo mkdir -p /opt/ansible/inventory
sudo touch /opt/ansible/inventory/aws_ec2.yaml
sudo chmod 777 /opt/ansible/inventory/aws_ec2.yaml

sudo touch ${AWS_INSTANCE_PRIVATE_KEY_NAME}
sudo echo "${AWS_INSTANCE_PRIVATE_KEY}" > ${AWS_INSTANCE_PRIVATE_KEY_NAME}
sudo chmod 400 ${AWS_INSTANCE_PRIVATE_KEY_NAME}

sudo echo "[defaults]
inventory      = /opt/ansible/inventory/aws_ec2.yaml
host_key_checking = False
pipelining = True
remote_user = ubuntu
private_key_file = ${AWS_INSTANCE_PRIVATE_KEY_NAME}

[inventory]
enable_plugins = aws_ec2" > /etc/ansible/ansible.cfg

sudo echo "---
plugin: aws_ec2
aws_access_key: ${AWS_ACCESS_KEY_ID}
aws_secret_key: ${AWS_SECRET_ACCESS_KEY}
keyed_groups:
  - key: tags.Name" > /opt/ansible/inventory/aws_ec2.yaml

#############################################################
# PROMETHEUS & GRAFANA (Instalación)
#############################################################

sudo touch ~/docker-compose.yml
sudo chmod 777 ~/docker-compose.yml
sudo echo "
version: '3'

services:
  grafana:
    image: grafana/grafana-enterprise:latest
    container_name: grafana
    ports:
      - 3000:3000
    networks:
      - metrics_net
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana/provisioning:/etc/grafana/provisioning

  prometheus:
    image: bitnami/prometheus:latest
    container_name: prometheus
    restart: always
    ports:
      - 9090:9090
    volumes:
      - ~/prometheus/conf/prometheus.yml:/opt/bitnami/prometheus/conf/prometheus.yml:ro
      - prometheus_data:/opt/bitnami/prometheus/data
    networks:
      - metrics_net

volumes:
  prometheus_data:
  grafana_data:

networks:
  metrics_net:
" > ~/docker-compose.yml


#############################################################
# PROMETHEUS & GRAFANA (Configuraciones)
#############################################################

sudo mkdir -p ~/prometheus/conf
sudo touch ~/prometheus/conf/prometheus.yml
sudo chmod 777 ~/prometheus/conf/prometheus.yml
sudo echo "
global:
  scrape_interval: 10s
  evaluation_interval: 10s
  query_log_file: /opt/bitnami/prometheus/query.log

scrape_configs:
  - job_name: 'local'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'ec2'
    ec2_sd_configs:
      - region: us-west-2
        access_key: ${AWS_ACCESS_KEY_ID}
        secret_key: ${AWS_SECRET_ACCESS_KEY}
        port: 9100

#    relabel_configs:
#      - source_labels: [__meta_ec2_tag_Name]
#        regex: prod_*
#        action: keep
#        # Use the instance ID as the instance label
#      - source_labels: [__meta_ec2_instance_id]
#        target_label: instance
" > ~/prometheus/conf/prometheus.yml

sudo mkdir -p ~/grafana/provisioning/datasources
sudo touch ~/grafana/provisioning/datasources/default.yml
sudo chmod 777 ~/grafana/provisioning/datasources/default.yml

sudo echo "
apiVersion: 1

deleteDatasources:
  - name: Prometheus
    orgId: 1

datasources:
- name: Prometheus
  type: prometheus
  access:
  url: http://prometheus:9090
  password:
  user:
  database:
  basicAuth: false
  basicAuthUser:
  basicAuthPassword:
  withCredentials:
  isDefault: true
  jsonData:
     tlsAuth: false
     tlsAuthWithCACert: false
  secureJsonData:
    tlsCACert: ""
    tlsClientCert: ""
    tlsClientKey: ""
  version: 1
  editable: true
" > ~/grafana/provisioning/datasources/default.yml

# Configuración Dashboard
sudo touch ~/grafana/provisioning/dashboards/node-exporter-full.json
sudo chmod 777 ~/grafana/provisioning/dashboards/node-exporter-full.json
sudo curl https://raw.githubusercontent.com/rfmoz/grafana-dashboards/master/prometheus/node-exporter-full.json > ~/grafana/provisioning/dashboards/node-exporter-full.json

sudo mkdir -p ~/grafana/provisioning/dashboards
sudo touch ~/grafana/provisioning/dashboards/default.yml
sudo chmod 777 ~/grafana/provisioning/dashboards/default.yml

sudo echo "
apiVersion: 1
providers:
- name: 'Prometheus'
  orgId: 1
  folder: ''
  type: file
  disableDeletion: false
  editable: true
  options:
    path: /etc/grafana/provisioning/dashboards
" > ~/grafana/provisioning/dashboards/default.yml

sudo docker-compose up -d