#!/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 26/04/2025

#Description:
#This script checks if a given service is active and logs the status.

#Usage:
#Run this Script and select a servie from the menu


LOG_DIR="/var/log/devops_toolkit"
LOG_FILE="$LOG_DIR/service_status.log"

sudo mkdir -p "$LOG_DIR"

SERVICES=("nginx" "mariadb" "docker" "ssh" "cron" "apache2")

PS3="Select a service to check: "
select SERVICE in "${SERVICES[@]}";do
    if [[ -n "$SERVICE" ]];then
        break
    else
        echo "Invalid Selection. Please Retry: "
    fi
done
    
if systemctl is-active --quiet "$SERVICE";then
    status="active"
else
    status="inactive"
fi

echo "$(date '+%y-%m-%d %H:%M:%S') Service '$SERVICE' is $status" | sudo tee -a "$LOG_FILE" > /dev/null
echo "Service '$SERVICE' status logged successfully"