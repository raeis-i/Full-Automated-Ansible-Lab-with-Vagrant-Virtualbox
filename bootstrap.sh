#!/usr/bin/env bash
export NUM_NODES=$1
export NETWORK_RANGE=$2

#Change ssh config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/*
sudo systemctl restart ssh

# Add all nodes to hosts file in all servers
for ((id=1; id<=${NUM_NODES}; id++)); do
    echo "${NETWORK_RANGE}${id} node${id}" | sudo tee -a /etc/hosts > /dev/null
done