#!/bin/bash

# --- CONFIGURATION ---
WEBHOOK_URL="https://discord.com/api/webhooks/1463109474762883198/NTdOL3m9S_9KuBWdJIg4kypGxoFiCtPzdw55QGvMwIocNBkDxzXg6qYG6vziBsjLimT8"
THRESHOLD=80
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
HOSTNAME=$(hostname)

# --- CHECK DISK SPACE ---
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    MESSAGE="⚠️ **ALERT: Low Disk Space on $HOSTNAME**\nCurrent usage is at **$DISK_USAGE%**. Please clean up files!"
    
    # Send to Discord using curl
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"$MESSAGE\"}" \
         $WEBHOOK_URL
fi

# --- OPTIONAL: SEND DAILY STATUS ---
# You can also send a daily "All Clear" message
if [ "$DISK_USAGE" -le "$THRESHOLD" ]; then
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"✅ Daily Health Check: $HOSTNAME is running smoothly at $DISK_USAGE% disk usage.\"}" \
         $WEBHOOK_URL
fi
