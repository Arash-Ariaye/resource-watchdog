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

## 📄 توضیح پیشنهادی

 اسکریپت **Resource Watchdog** سبک برای سرورهای لینوکس است که به صورت خودکار مصرف **CPU** و **RAM** را مانیتور می‌کند و در صورت رسیدن مصرف به حد بالا، سرویس‌های اصلی تانل‌های **Backhaul، Hotfix و Packet** را ری‌استارت می‌کند.

> این سرویس‌ها در استفاده طولانی مدت می‌توانند **رم و سی‌پی‌یو بالایی مصرف کنند** که باعث کاهش پهنای باند و کند شدن سرور می‌شود.
> اسکریپت با اجرای **خودکار هر ۵ دقیقه** از طریق cron، از این مشکل جلوگیری می‌کند و عملکرد سرور را **پایدار و بهینه** نگه می‌دارد.

> 🔹 **ویژگی‌ها:**

> * مانیتورینگ CPU و RAM
> * ری‌استارت خودکار `paqet.service` و تمام سرویس‌های `backhaul-*`
> * لاگ ساده و قابل بررسی
> * نصب آسان با یک دستور از GitHub



