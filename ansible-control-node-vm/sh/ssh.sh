#!/bin/bash

#
echo "--------------------------------------------------------------------------------------"
echo "Generating SSH Key Pair..."
sudo ssh-keygen -f ~/.ssh/web_id_rsa -t ecdsa -b 521
