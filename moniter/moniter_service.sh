#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 23/05/2025

LOG_DIR="/home/neonshroom/Documents/devops-toolkit/logs"
LOG_FILE="$LOG_DIR/service_status.log"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
SERVICES=("nginx" "mariadb" "docker" "ssh" "cron" "apache2")

mkdir -p "$LOG_DIR"

for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        status="active"
    else
        status="inactive"
        curl -s -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"❌ *Service Alert on $(hostname)*: '$SERVICE' is $status\"}" \
            "$SLACK_WEBHOOK_URL"
    fi
    echo "$(date '+%Y-%m-%d %H:%M:%S') Service '$SERVICE' is $status" | tee -a "$LOG_FILE" > /dev/null
done

echo "Service status logged successfully"
