#!/bin/bash

# Ansible
echo "--------------------------------------------------------------------------------------"
echo "Installing Ansible..."
if [ -z "$1" ]; then
  echo "You must supply Ansible vault secret!"
  echo " ./ansible.sh 'SECRET'"
  exit
fi
sudo apt remove ansible
sudo apt --purge autoremove
sudo apt update
sudo apt upgrade
sudo apt -y install software-properties-common
sudo apt install software-properties-common
sudo apt install -y ansible
echo "Ansible Installed"
echo "Creating Vault Password File..."
sh -c "echo '$1' > $HOME/.vault_pass"
echo "Vault Password File Created"
echo "Setting Vault Password File in ansible.cfg..."
sudo sed -i '/vault_password_file$/a vault_password_file = $HOME/.vault_pass' /etc/ansible/ansible.cfg
echo "Vault Password File Set"
