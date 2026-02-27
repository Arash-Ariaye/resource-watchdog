#!/bin/sh

# ===== CONFIG =====
GITHUB_RAW="https://raw.githubusercontent.com/Arash-Ariaye/resource-watchdog/main/resource_watchdog.sh"
INSTALL_PATH="/usr/local/bin/resource_watchdog.sh"
LOG_FILE="/var/log/resource_watchdog.log"
CRON_JOB="*/5 * * * * $INSTALL_PATH"

echo "🔧 Installing Resource Watchdog..."

# Root check
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ Please run as root"
    exit 1
fi

# Download script
echo "⬇️  Downloading resource_watchdog.sh"
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$GITHUB_RAW" -o "$INSTALL_PATH"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$INSTALL_PATH" "$GITHUB_RAW"
else
    echo "❌ curl or wget is required"
    exit 1
fi

# Permission
chmod +x "$INSTALL_PATH"

# Create log file
touch "$LOG_FILE"
chmod 644 "$LOG_FILE"

# Setup cron (no duplicate)
( crontab -l 2>/dev/null | grep -v resource_watchdog.sh ; echo "$CRON_JOB" ) | crontab -

echo "✅ Installation completed"
echo "📌 Script : $INSTALL_PATH"
echo "⏱ Cron   : Every 5 minutes"
echo "🧾 Log   : $LOG_FILE"
