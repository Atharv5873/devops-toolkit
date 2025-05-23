#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 23/05/2025

LOG_DIR="/home/neonshroom/Documents/devops-toolkit/logs"
LOG_FILE="$LOG_DIR/disk_usage.log"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
THRESHOLD=80

mkdir -p "$LOG_DIR"

disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//')

echo "$(date '+%y-%m-%d %H:%M:%S') Disk Usage: ${disk_usage}%" | tee -a "$LOG_FILE" > /dev/null
echo "Disk usage logged successfully"

if (( disk_usage > THRESHOLD )); then
    curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"⚠️ *High Disk Usage on $(hostname)*: ${disk_usage}% (Threshold: ${THRESHOLD}%)\"}" \
        "$SLACK_WEBHOOK_URL"
fi
