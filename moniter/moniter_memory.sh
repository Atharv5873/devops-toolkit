#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 23/05/2025

LOG_DIR="/home/neonshroom/Documents/devops-toolkit/logs"
LOG_FILE="$LOG_DIR/memory_usage.log"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
THRESHOLD=80

mkdir -p "$LOG_DIR"

memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
memory_usage_int=${memory_usage%.*}

echo "$(date '+%y-%m-%d %H:%M:%S') Memory Usage: ${memory_usage}%" | tee -a "$LOG_FILE" > /dev/null
echo "Memory usage logged successfully"

if (( memory_usage_int > THRESHOLD )); then
    curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"⚠️ *High Memory Usage on $(hostname)*: ${memory_usage}% (Threshold: ${THRESHOLD}%)\"}" \
        "$SLACK_WEBHOOK_URL"
fi
