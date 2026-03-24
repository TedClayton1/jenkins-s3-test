#!/bin/bash
set -euxo pipefail

# Update packages
sudo dnf update -y || sudo yum update -y || sudo apt-get update -y

# Install basic utilities
if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y unzip curl wget git python3
elif command -v yum >/dev/null 2>&1; then
  sudo yum install -y unzip curl wget git python3
else
  sudo apt-get update -y
  sudo apt-get install -y unzip curl wget git python3 python3-pip
fi

# Install Java 21
if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y java-21-amazon-corretto
elif command -v yum >/dev/null 2>&1; then
  sudo yum install -y java-21-amazon-corretto
else
  sudo apt-get install -y openjdk-21-jdk
fi

# Install Terraform
TERRAFORM_VERSION="1.8.5"
curl -fsSL -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo unzip -o /tmp/terraform.zip -d /usr/local/bin/
chmod +x /usr/local/bin/terraform

# Install AWS CLI v2
curl -fsSL -o /tmp/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
unzip -o /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install --update

# Verify tools
terraform version
aws --version
python3 --version
java -version