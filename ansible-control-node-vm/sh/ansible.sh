#!/bin/bash

# Ansible
echo "--------------------------------------------------------------------------------------"
echo "Installing Ansible..."
sudo apt remove ansible
sudo apt --purge autoremove
sudo apt update
sudo apt upgrade
sudo apt -y install software-properties-common
sudo apt install software-properties-common
sudo apt install -y ansible
echo "Creating vault password file..."
sh -c "echo '$1' > $HOME/.vault_pass"
echo "Editing ansible.cfg..."
sudo sed -i '/vault_password_file$/a vault_password_file = $HOME/.vault_pass' /etc/ansible/ansible.cfg


