#1/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 26/04/2025

#Description:
#This script installs and configures Apache2 on the server, ensung Apache2 starts upon system boot

#Usage:
#Run this Script to install and start Apache2 on your system

echo -e "Installing Apache2...\n"
sudo apt update
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
echo -e "\nApache2 installation and configuration complete"