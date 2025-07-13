#!/bin/bash

# Update and install dependencies
apt-get update -y
apt-get install -y unzip curl jq

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install kubectl (latest stable)
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# Add AWS to PATH (in case it's not picked up)
echo 'export PATH=$PATH:/usr/local/bin' >> /home/ubuntu/.bashrc

# Cleanup
rm -rf aws awscliv2.zip kubectl

# Print versions to log
aws --version
kubectl version --client
