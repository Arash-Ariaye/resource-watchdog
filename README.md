## ✅ دستور نصب تک‌خطی (برای کاربر نهایی)

```bash
curl -fsSL -4 https://raw.githubusercontent.com/Arash-Ariaye/resource-watchdog/main/install.sh | sudo sh
```

## uninstall

```bash
crontab -l | grep -v resource_watchdog.sh | crontab -
rm -f /usr/local/bin/resource_watchdog.sh
rm -f /var/log/resource_watchdog.log
```
