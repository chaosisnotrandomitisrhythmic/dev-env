#!/usr/bin/env bash

# Exit on error
set -e

# Update and install dependencies
sudo apt update && sudo apt install -y unzip curl

# Download AWS CLI v2 installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installer with default installation directory
sudo ./aws/install

# Cleanup installation files
rm -f awscliv2.zip
rm -rf ./aws

# Verify installation
echo "Installed AWS CLI version:"
aws --version

# Prompt for AWS credentials
echo "Now configuring AWS credentials..."
read -p "Enter your AWS Access Key ID: " AWS_ACCESS_KEY_ID
read -s -p "Enter your AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
echo
read -p "Enter your default region name (e.g., us-east-1): " AWS_DEFAULT_REGION
read -p "Enter your default output format (json, yaml, text) [json]: " AWS_OUTPUT_FORMAT

# Set default if empty
AWS_OUTPUT_FORMAT=${AWS_OUTPUT_FORMAT:-json}

# Configure AWS CLI credentials
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set default.region "$AWS_DEFAULT_REGION"
aws configure set default.output "$AWS_OUTPUT_FORMAT"

echo "✅ AWS CLI has been installed and configured successfully!"
