#!/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 21/05/2025

#Description:
#This script installs and configures NGINX on the server, ensung NGINX starts upon system boot

#Usage:
#Run this Script to install and start NGINX on your system

echo -e "Installing NGINX...\n"
sudo apt update
sudo apt install nginx -y
if systemctl is-active --quiet apache2; then
    echo "Apache2 is running. Stopping and disabling it to free port 80..."
    sudo systemctl stop apache2
fi
sudo systemctl enable nginx
sudo systemctl start nginx
echo -e "\nNGINX installation and configuration complete"