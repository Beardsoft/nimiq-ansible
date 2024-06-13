#!/bin/bash

# This script sets up or updates the Nimiq node using Ansible
# Usage: curl -s https://raw.githubusercontent.com/maestroi/nimiq-ansible/master/setup.sh | bash -s <network> <node_type>

set -e

# Check for required arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <network> <node_type>"
    exit 1
fi

NETWORK=$1
NODE_TYPE=$2

# Function to install necessary dependencies
install_dependencies() {
    echo "Installing necessary dependencies..."
    apt-get update -y
    apt-get install -y software-properties-common
}

# Function to install Ansible
install_ansible() {
    echo "Adding Ansible repository..."
    apt-add-repository --yes --update ppa:ansible/ansible
    echo "Installing Ansible..."
    apt-get install -y ansible
}

# Function to clone or update the Nimiq Ansible repository
update_repository() {
    if [ -d "/opt/nimiq-ansible" ]; then
        echo "Updating the Nimiq Ansible repository..."
        cd /opt/nimiq-ansible
        git pull
    else
        echo "Cloning the Nimiq Ansible repository..."
        git clone https://github.com/maestroi/nimiq-ansible.git /opt/nimiq-ansible
        cd /opt/nimiq-ansible
    fi
}

# Function to run the Ansible playbook
run_playbook() {
    echo "Running the Ansible playbook..."
    ansible-playbook -i localhost, -c local playbook.yml --extra-vars "network=${NETWORK} node_type=${NODE_TYPE}"
}

# Install necessary dependencies
install_dependencies

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    install_ansible
fi

# Clone or update the Nimiq Ansible repository
update_repository

# Run the Ansible playbook
run_playbook

echo "Nimiq node setup/update complete!"
