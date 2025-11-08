#!/bin/bash

# Fetch ASG name from terraform output
ASG_NAME=$(terraform output -raw asg_name)

# Describe instances in the ASG using AWS CLI
IPS=$(aws ec2 describe-instances \
  --filters "Name=tag:aws:autoscaling:groupName,Values=${ASG_NAME}" "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].PublicIpAddress" \
  --output text)

# Create inventory file
echo "[webservers]" > hosts
for ip in $IPS; do
  echo "$ip ansible_user=ec2-user ansible_ssh_private_key_file=deployer-key.pem ansible_python_interpreter=/usr/bin/python3" >> hosts
done

echo "Inventory generated successfully!"
