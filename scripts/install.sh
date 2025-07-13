#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

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
sudo mv ./kubectl /usr/local/bin/kubectl

# Add AWS to PATH (only if not already present)
if ! grep -q "/usr/local/bin" ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
fi

# Cleanup temp files
rm -rf aws awscliv2.zip

# Print versions to verify
aws --version
kubectl version --client
