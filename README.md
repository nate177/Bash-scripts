# 🛠️ DKMS Maintenance Script

A robust and flexible Bash script to maintain your DKMS (Dynamic Kernel Module Support) modules on Arch, Debian, Ubuntu, and other Linux distributions. This script automatically detects, repairs, reinstalls, or removes broken/orphaned DKMS modules across all installed kernels, with full logging and optional systemd integration.

---

## 🔍 Features

- 🔁 **Reinstalls** modules for all detected kernels (even if already present)
- 🧹 **Removes** broken or orphaned modules with missing kernel versions or source directories
- 📝 **Logs** everything to `/var/log/dkms-repair.log`
- 🔧 **Optional systemd timer** for automatic weekly maintenance

---

## 📦 Installation

1. Save the script as `/usr/local/bin/dkms-maintenance.sh`:

```bash
sudo curl -o /usr/local/bin/dkms-maintenance.sh https://raw.githubusercontent.com/nate177/Bash-scripts/main/dkms-maintenance.sh
sudo chmod +x /usr/local/bin/dkms-maintenance.sh
dkms-maintenance.service

[Unit]
Description=Advanced DKMS Maintenance Script

[Service]
ExecStart=/usr/local/bin/dkms-maintenance.sh

dkms-maintenance.timer

[Unit]
Description=Run DKMS Maintenance Weekly

[Timer]
OnBootSec=10min
OnUnitActiveSec=1w
Persistent=true

[Install]
WantedBy=timers.target

sudo systemctl daemon-reexec
sudo systemctl enable --now dkms-maintenance.timer
📁 Log Output

Logs are saved at:

/var/log/dkms-repair.log

Each run appends a new timestamped section so you can trace actions historically.
✅ Example Use

Run manually at any time:

sudo /usr/local/bin/dkms-maintenance.sh

Use systemctl to check scheduled status:

systemctl list-timers --all | grep dkms

📬 Optional: Email Notifications

Want the script to email logs when something breaks or fails to install? Open an issue or submit a PR — contributions are welcome!
📄 License

MIT License. Use freely, modify widely, attribute kindly.
🙌 Contributing

Have an idea to improve this script? Found an issue?
Feel free to open an issue or pull request.
Let me know if you'd like to auto-fill your GitHub username and repo name into the placeholders or if you'd like badges (build status, license, etc.) added at the top!
