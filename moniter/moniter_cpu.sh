#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 23/05/2025

# Description:
# This script monitors CPU usage and logs it in a file. Sends Slack alert if usage > 80%.

LOG_DIR="/home/neonshroom/Documents/devops-toolkit/logs"
LOG_FILE="$LOG_DIR/cpu_usage.log"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
THRESHOLD=80

mkdir -p "$LOG_DIR"

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage_int=${cpu_usage%.*}  # Integer part only

echo "$(date '+%y-%m-%d %H:%M:%S') CPU Usage: $cpu_usage%" | tee -a "$LOG_FILE" > /dev/null
echo "CPU usage logged successfully"

if (( cpu_usage_int > THRESHOLD )); then
    curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"⚠️ *High CPU Usage on $(hostname)*: ${cpu_usage}% (Threshold: ${THRESHOLD}%)\"}" \
        "$SLACK_WEBHOOK_URL"
fi
