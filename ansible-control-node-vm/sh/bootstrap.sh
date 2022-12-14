#!/bin/bash

# Update packages
sudo apt update

# Upgrade packages
sudo apt upgrade

echo "--------------------------------------------------------------------------------------"
echo "Provisioning..."

sh /vagrant/sh/core.sh
sh /vagrant/sh/ansible.sh "$1"
sh /vagrant/sh/firewall.sh
