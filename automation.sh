#!/bin/bash

terraform init
terraform apply --auto-approve
terraform output -raw key_pair_private_key > deployer-key.pem
chmod 600 deployer-key.pem

./generate_inventory.sh 

export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i hosts site.yml
