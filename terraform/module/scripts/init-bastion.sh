#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
  stable" -y
sudo sysctl -p
sudo apt-get update &&
sudo apt-get install -y docker-ce apt-transport-https curl ansible -y &&
sudo usermod -aG docker ubuntu &&
sudo systemctl restart docker &&
sudo systemctl enable docker.service &&
sudo systemctl daemon-reload

sudo apt-get install python3-pip -y
sudo pip install boto3
sudo mkdir -p /opt-ansible/inventory
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

sudo mkdir -p ~/prometheus/conf
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

sudo docker run -p9090:9090 -d --volume "~/prometheus.yml:/opt/bitnami/prometheus/conf/prometheus.yml:ro" --volume "prometheus_data:/opt/bitnami/prometheus/data" --name prometheus bitnami/prometheus:latest