#!/bin/bash

#Author:        Atharv Sharma
#Date Created:  26/04/2025
#Date Modified: 26/04/2025

#Description:
#This script monitors memory usage and logs it in a file.

#Usage:
#Run this Script to monitor memory usage.


LOG_DIR="/var/log/devops_toolkit"
LOG_FILE="$LOG_DIR/memory_usage.log"

sudo mkdir -p "$LOG_DIR"

memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

echo "$(date '+%y-%m-%d %H:%M:%S') Memory Usage: $memory_usage%" | sudo tee -a "$LOG_FILE" > /dev/null
echo "Memory usage logged successfully"