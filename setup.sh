#!/bin/bash

# This script sets up or updates the Nimiq node using Ansible
# Usage: curl -s https://raw.githubusercontent.com/maestroi/nimiq-ansible/master/setup.sh | bash -s [<network>] [<node_type>]

set -e

# Set default values
NETWORK=${1:-testnet}
NODE_TYPE=${2:-validator}

# Function to install necessary dependencies
install_dependencies() {
    echo "Updating OS packages..."
    apt-get update -y > /dev/null
    echo "Installing necessary dependencies..."
    apt-get install -y software-properties-common > /dev/null
}

# Function to install Ansible
install_ansible() {
    echo "Adding Ansible repository..."
    apt-add-repository --yes --update ppa:ansible/ansible > /dev/null
    echo "Installing Ansible..."
    apt-get install -y ansible > /dev/null
}

# Function to clone or update the Nimiq Ansible repository
update_repository() {
    if [ -d "/opt/nimiq-ansible" ]; then
        echo "Updating the Nimiq Ansible repository..."
        cd /opt/nimiq-ansible
        git pull > /dev/null
    else
        echo "Cloning the Nimiq Ansible repository..."
        git clone https://github.com/maestroi/nimiq-ansible.git /opt/nimiq-ansible > /dev/null
        cd /opt/nimiq-ansible
    fi
}

# Function to run the Ansible playbook
run_playbook() {
    echo "Running the Ansible playbook..."
    ansible-playbook -i localhost, -c local /opt/nimiq-ansible/playbook.yml --extra-vars "network=${NETWORK} node_type=${NODE_TYPE}"
}

# Function to create symbolic link
create_symlink() {
    if [ ! -L /usr/local/bin/nimiq-setup ]; then
        echo "Creating symbolic link for setup script..."
        ln -s /opt/nimiq-ansible/setup.sh /usr/local/bin/nimiq-setup
    fi
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

# Create symbolic link
create_symlink

echo "Nimiq node setup/update complete!"
