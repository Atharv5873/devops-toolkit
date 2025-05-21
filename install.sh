#!/bin/bash

#Author:        Atharv Sharma
#Date Created:  21/05/2025
#Date Modified: 21/05/2025

#Description:
#This script sets up server, users, monitoring, cron jobs, and create required folders

#Usage:
#curl -s https://raw.githubusercontent.com/Atharv5873/devops-toolkit/main/install.sh | bash

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

if [ ! -d "moniter" ]||[ ! -d "setup" ];then
    echo "Cloning GitHub repo..."
    git clone https://github.com/Atharv5873/devops-toolkit.git
    cd devops-toolkit ||{ echo "Failed to enter repo. Exiting.";
    exit 1;}
    else echo "Running inside the repo folder."
fi