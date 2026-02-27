#!/bin/sh

CPU_LIMIT=88
RAM_LIMIT=88
MAIN_SERVICE="paqet.service"
LOG_FILE="/var/log/resource_watchdog.log"

# CPU usage %
CPU_USAGE=$(top -bn1 | awk -F',' '/Cpu/ {printf "%.0f", 100 - $4}')

# RAM usage %
TOTAL_RAM=$(free | awk '/Mem:/ {print $2}')
USED_RAM=$(free | awk '/Mem:/ {print $3}')
RAM_USAGE=$(awk "BEGIN {printf \"%.0f\", ($USED_RAM/$TOTAL_RAM)*100}")

if [ "$CPU_USAGE" -ge "$CPU_LIMIT" ] || [ "$RAM_USAGE" -ge "$RAM_LIMIT" ]; then

    REASON=""
    [ "$CPU_USAGE" -ge "$CPU_LIMIT" ] && REASON="CPU=${CPU_USAGE}%"
    [ "$RAM_USAGE" -ge "$RAM_LIMIT" ] && REASON="${REASON} RAM=${RAM_USAGE}%"

    systemctl is-enabled "$MAIN_SERVICE" >/dev/null 2>&1 && \
    systemctl restart "$MAIN_SERVICE"
    
    systemctl list-unit-files | awk '/^backhaul-/ {print $1}' | while read svc; do
        systemctl is-enabled "$svc" >/dev/null 2>&1 && \
        systemctl restart "$svc"
    done

    echo "$(date '+%Y-%m-%d %H:%M:%S') | Restarted due to $REASON" >> "$LOG_FILE"
fi
