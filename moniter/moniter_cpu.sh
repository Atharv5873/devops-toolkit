#1/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 26/04/2025

#Description:
#This script monitors CPU usage and logs it in a file.

#Usage:
#Run this Script to monitor CPU usage.


LOG_DIR="/var/log/devops_toolkit"
LOG_FILE="$LOG_DIR/cpu_usage.log"

sudo mkdir -p "$LOG_DIR"

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo "$(date '+%y-%m-%d %H:%M:%S') CPU Usage: $cpu_usage%" | sudo tee -a "$LOG_FILE" > /dev/null
echo "CPU usage logged successfully"