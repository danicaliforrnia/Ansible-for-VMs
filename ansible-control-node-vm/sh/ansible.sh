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
sudo apt install -y sshpass
echo "Editing Ansible Inventory..."
sudo sh -c "echo '[servers]' > /etc/ansible/hosts"
sudo sh -c "echo 'node-host ansible_host=192.168.59.3 ansible_ssh_user=ansible-host ansible_ssh_common_args='-o StrictHostKeyChecking=no'' >> /etc/ansible/hosts"
