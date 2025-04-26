#1/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 26/04/2025

#Description:
#This script installs  MySQL server on the system and Secures MySQL installation

#Usage:
#Run this Script to install and secure MySQL on your server

echo -e "Installing MariaDB...\n"
sudo apt update
sudo apt install mariadb-server -y
sudo systemctl start mariadb
echo -e "\nSecuring MariaDB installation...\n"
sudo mariadb-secure-installation
echo -e "\nMariaDB installation and security complete"