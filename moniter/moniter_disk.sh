#!/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 26/04/2025

#Description:
#This script monitors disk usage and logs it in a file.

#Usage:
#Run this Script to monitor disk usage.


LOG_DIR="/var/log/devops_toolkit"
LOG_FILE="$LOG_DIR/disk_usage.log"

sudo mkdir -p "$LOG_DIR"

disk_usage=$(df / | grep / | awk '{print $5}')

echo "$(date '+%y-%m-%d %H:%M:%S') Disk Usage: $disk_usage%" | sudo tee -a "$LOG_FILE" > /dev/null
echo "Disk usage logged successfully"