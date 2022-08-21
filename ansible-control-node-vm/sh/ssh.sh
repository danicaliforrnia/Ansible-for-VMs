#!/bin/bash

#
echo "--------------------------------------------------------------------------------------"
echo "Generating SSH Key Pair..."
ssh-keygen -f ~/.ssh/web_id_rsa -t ecdsa -b 521 -q -N "" || echo "FAILED"
echo "SSH Key Pair Created in ~/.ssh"
