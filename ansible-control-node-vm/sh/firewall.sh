#!/bin/bash

echo "--------------------------------------------------------------------------------------"
echo "Updating Firewall Rules..."
sudo ufw allow OpenSSH
sudo yes | sudo ufw enable
echo "Firewall Rules Updated"
