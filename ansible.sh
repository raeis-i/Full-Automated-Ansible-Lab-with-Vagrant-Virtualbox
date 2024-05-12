#!/bin/bash
#This file copy only on node1 as ansible node in order to manage other nodes

#Install Ansible and some tools on node1
sudo apt update 
sudo apt -y install curl wget net-tools iputils-ping sshpass 
sudo apt -y install ansible

#Read number of nodes and network range from vars.rb file.
NETWORK_RANGE=$(awk '/^NETWORK_RANGE =/{gsub(/"/, "", $3); print $3}' vars.rb)
NUM_NODES=$(awk '/^NUM_NODES =/{print $3}' vars.rb)

# Generate SSH key and distribute to other nodes
ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""
for ((id=1; id<=NUM_NODES; id++)); do
    sshpass -p 'vagrant' ssh-copy-id -o "StrictHostKeyChecking=no" vagrant@node${id}
done

# Create ansible configuration
PROJECT_DIRECTORY="/home/vagrant/ansible/"
mkdir -p "$PROJECT_DIRECTORY"
cd "$PROJECT_DIRECTORY"

# Creating the inventory file for all 5 nodes
for ((id=1; id<=NUM_NODES; id++)); do
    echo "node${id}" | sudo tee -a inventory
done
echo -e "[defaults]\ninventory = inventory" > ansible.cfg




