sudo sysctl -w vm.max_map_count=262144

# Update package list
sudo apt-get update

# Install package dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add the Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update the package list again
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce

# Add the current user to the "docker" group
sudo usermod -aG docker ubuntu

# Test the installation
docker --version

# Update package list
sudo apt-get update

# Install package dependencies
sudo apt-get install -y curl

# Download the latest version of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Test the installation
sudo ocker-compose --version

#!/bin/bash

# Create a new directory for the ELK stack
sudo mkdir elk

# Change directory to the newly created directory
cd elk

# Create a new file named "docker-compose.yml"
sudo touch docker-compose.yml

# Populate the "docker-compose.yml" file with the following content
sudo cat > docker-compose.yml <<EOF
version: '3'
services:
  elasticsearch:
    image: elasticsearch:7.14.0
    ports:
      - "9200:9200"
      - "9300:9300"
    environment:
      - discovery.type=single-node
  logstash:
    image: logstash:7.14.0
    ports:
      - "5000:5000"
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf:ro
    depends_on:
      - elasticsearch
  kibana:
    image: kibana:7.14.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
EOF

# Create a new file named "logstash.conf"
sudo touch logstash.conf

# Populate the "logstash.conf" file with your desired configuration
# You can find an example logstash.conf file in the logstash documentation

# Run the ELK stack using Docker Compose
sudo docker-compose up -d
