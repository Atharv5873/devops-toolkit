#!/bin/bash

#Author:        Atharv Sharma
#Date Created:  21/05/2025
#Date Modified: 21/05/2025

#Description:
#This script sets up server, users, monitoring, cron jobs, and create required folders

#Usage:
# Interactive installer script for setting up server, users, monitoring, cron jobs, and required folders.
# Assumes user has already cloned the repo and is running from inside the repo directory.


echo "______                            _____           _ _    _ _   
|  _  \                          |_   _|         | | |  (_) |  
| | | |_____   _____  _ __  ___    | | ___   ___ | | | ___| |_ 
| | | / _ \ \ / / _ \| '_ \/ __|   | |/ _ \ / _ \| | |/ / | __|
| |/ /  __/\ V / (_) | |_) \__ \   | | (_) | (_) | |   <| | |_ 
|___/ \___| \_/ \___/| .__/|___/   \_/\___/ \___/|_|_|\_\_|\__|
                     | |                                       
                     |_|                                       "

echo -e "\nAutomated Installer Script"
echo "=========================================================================================================================================================================="
echo ""
echo "Which web server do you want to setup?"
echo "1) Apache"
echo "2) NGINX"
read -rp "Enter 1 or 2: " web_choice
if [ "$web_choice" == "1" ]; then
    bash ./setup/install_apache.sh
elif [ "$web_choice" == "2" ]; then
    bash setup/install_nginx.sh
else
    echo "[!] Invalid Choice. Skipipng web server setup."
fi

echo -e "\n[*] Setting up users..."
bash setup/create_users.sh || { echo "Failed to setup users. Exiting."; exit 1; }
echo -e "\n[*] Setting up MariaDB..."
bash setup/install_mariadb.sh || { echo "Failed to setup MariaDB. Exiting."; exit 1; }
echo -e "\n[*] Setup completed successfully!"

