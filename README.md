# 🐧 Linux Server Monitoring & Automated Email Alert System

## 📌 Project Overview

The Linux Server Monitoring & Automated Email Alert System is a Linux automation project designed to monitor server CPU utilization in real time and notify the administrator whenever CPU usage crosses a predefined threshold.

This project automates server health monitoring using Bash scripting, Linux performance monitoring tools, Cron scheduling, and SMTP-based email notifications.

It simulates a real-world System Administrator / DevOps workflow where servers are continuously monitored and alerts are generated automatically to prevent downtime.

---

# 🚀 Features

- ✅ Real-time CPU usage monitoring
- ✅ Automated monitoring using Cron Jobs
- ✅ CPU statistics collection using mpstat
- ✅ Threshold-based alert system
- ✅ Automatic email notifications
- ✅ System activity logging
- ✅ Gmail SMTP integration
- ✅ Server load testing
- ✅ Background automation

---

# 🏗️ Project Architecture


                    Linux Server (RHEL 9)
                             |
                             |
                             ↓
                      Cron Scheduler
                     (Every Minute)
                             |
                             |
                             ↓
                    CPU Monitoring Script
                    (cpu_monitor.sh)
                             |
                             |
                             ↓
                         mpstat Tool
                   (Checks CPU Usage)
                             |
                             |
                  ---------------------
                  |                   |
                  ↓                   ↓
            Normal CPU          High CPU Usage
                  |                   |
                  ↓                   ↓
             Save Logs          Trigger Alert
                                      |
                                      ↓
                                  Postfix
                                      |
                                      ↓
                                Gmail SMTP
                                      |
                                      ↓
                            Email Notification 📩


---

# 🛠️ Technology Stack

| Technology | Usage |
|-----------|-------|
| RHEL 9 Linux | Server Operating System |
| VMware | Virtual Environment |
| Bash Script | Automation |
| mpstat | CPU Monitoring |
| sysstat | Performance Utilities |
| Cron | Task Scheduling |
| Postfix | Mail Transfer Agent |
| s-nail | Email Client |
| Gmail SMTP | Sending Alerts |
| stress-ng | CPU Load Testing |

---

# 📂 Project Structure


Linux-Server-Monitor/

│

├── cpu_monitor.sh

├── cpu_usage.log

├── README.md

└── screenshots/

      ├── cpu-monitor.png
      
      ├── email-alert.png
      
      ├── cron-job.png
      
      └── logs.png


---

# ⚙️ Installation Steps

## 1. Update Linux System

```bash
sudo dnf update -y
```

---

## 2. Install CPU Monitoring Tool

Install sysstat package:

```bash
sudo dnf install sysstat -y
```

Verify mpstat:

```bash
mpstat
```

---

## 3. Install Mail Required Packages

```bash
sudo dnf install postfix cyrus-sasl cyrus-sasl-plain s-nail -y
```

Start Postfix:

```bash
sudo systemctl start postfix
```

Enable Postfix:

```bash
sudo systemctl enable postfix
```

Check Status:

```bash
systemctl status postfix
```

---

# 📝 CPU Monitoring Script

Create project directory:

```bash
mkdir Linux-Server-Monitor

cd Linux-Server-Monitor
```

Create script:

```bash
vi cpu_monitor.sh
```

Script:

```bash
#!/bin/bash


LIMIT=80


EMAIL="yourmail@gmail.com"


LOGFILE="/root/Linux-Server-Monitor/cpu_usage.log"


CPU_IDLE=$(mpstat 1 1 | awk '/Average/ {print $NF}')


CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)


echo "$(date) CPU Usage: $CPU_USAGE%" >> $LOGFILE


CPU_INT=${CPU_USAGE%.*}


if [ $CPU_INT -gt $LIMIT ]

then


MESSAGE="WARNING!

High CPU Usage Detected

Server: $(hostname)

CPU Usage: $CPU_USAGE%

Time: $(date)"


echo "$MESSAGE" | mail -s "CPU ALERT High Usage" $EMAIL


echo "$(date) Alert Email Sent" >> $LOGFILE


fi
```

Give permission:

```bash
chmod +x cpu_monitor.sh
```

Run:

```bash
./cpu_monitor.sh
```

---

# 📧 Gmail SMTP Configuration

Open Postfix configuration:

```bash
vi /etc/postfix/main.cf
```

Add:

```text
relayhost = [smtp.gmail.com]:587

smtp_use_tls = yes

smtp_sasl_auth_enable = yes

smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd

smtp_sasl_security_options = noanonymous
```

---

Create Gmail authentication file:

```bash
vi /etc/postfix/sasl_passwd
```

Add:

```text
[smtp.gmail.com]:587 yourmail@gmail.com:app_password
```

Generate database:

```bash
postmap /etc/postfix/sasl_passwd
```

Secure file:

```bash
chmod 600 /etc/postfix/sasl_passwd
```

Restart Postfix:

```bash
systemctl restart postfix
```

---

# 🧪 Test Email

Send test mail:

```bash
echo "Linux Server Monitoring Test" | mail -s "Test Alert" yourmail@gmail.com
```

Expected Result:

```
Email received successfully
```

---

# ⏰ Cron Automation

Open cron:

```bash
crontab -e
```

Add:

```bash
* * * * * /root/Linux-Server-Monitor/cpu_monitor.sh
```

Verify:

```bash
crontab -l
```

Now monitoring runs automatically every minute.

---

# 🔥 CPU Load Testing

Install stress tool:

```bash
sudo dnf install stress-ng -y
```

Generate CPU load:

```bash
stress-ng --cpu 4 --timeout 120
```

Monitor CPU:

```bash
mpstat
```

When CPU usage crosses the threshold:

```
CPU Usage > 80%
```

Automatic alert email will be sent.

---

# 📊 Sample Log Output


cpu_usage.log

```text
Fri Jul 10 18:20 CPU Usage: 5.20%

Fri Jul 10 18:25 CPU Usage: 91.50%

Alert Email Sent
```

---

# 📩 Email Alert Example

Subject:

```
CPU ALERT High Usage
```

Message:

```
WARNING!

High CPU Usage Detected

Server: RHEL9

CPU Usage: 95%

Immediate action required
```

---

# 🎯 Learning Outcomes

This project helped me understand:

- Linux Server Administration
- Bash Scripting
- Process Monitoring
- Cron Job Automation
- SMTP Email Configuration
- Linux Troubleshooting
- Log Management
- DevOps Monitoring Concepts

---

# 📌 Future Enhancements

- Memory Monitoring
- Disk Monitoring
- Network Monitoring
- Telegram Alerts
- Dashboard Integration
- Docker Container Monitoring
- Cloud Deployment on AWS EC2

---

# 👨‍💻 Author

**Amar Sunil Khatal**

B.Tech Computer Science & Business Systems

Interests:

- Linux Administration
- Cloud Computing
- DevOps Automation

---

# ⭐ Conclusion

This project demonstrates an automated Linux server monitoring solution that helps administrators detect high CPU usage and receive instant email alerts to maintain server reliability.
