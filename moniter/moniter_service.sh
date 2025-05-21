#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 21/05/2025

# Description:
# This script checks if a list of services are active and logs the status.

LOG_DIR="/home/neonshroom/Documents/devops-toolkit/logs"
LOG_FILE="$LOG_DIR/service_status.log"
SERVICES=("nginx" "mariadb" "docker" "ssh" "cron" "apache2")

mkdir -p "$LOG_DIR"

for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        status="active"
    else
        status="inactive"
    fi
    echo "$(date '+%Y-%m-%d %H:%M:%S') Service '$SERVICE' is $status" |  tee -a "$LOG_FILE" > /dev/null
done
echo "Service status logged successfully"