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

       ├── rhel-server.png  
       ├── mpstat-output.png
       ├── script-execution.png
       ├── log-output.png
       ├── cron-job.png
       ├── postfix-status.png
       ├── stress-test.png
       └── email-alert.png

---
# Output From the Project
1.RHEL-Server.png
<img width="1522" height="840" alt="image" src="https://github.com/user-attachments/assets/3da78248-088f-4dfe-b280-3a1923ee0cb8" />
2.mpstat-output.png
<img width="1522" height="840" alt="image" src="https://github.com/user-attachments/assets/6ef0426c-f093-43c2-86be-e6e2ee24576b" />
3.Script-execution.png
<img width="1388" height="772" alt="image" src="https://github.com/user-attachments/assets/d419c227-5a2b-4e8c-b532-dc6bf11a5911" />
4.log-output.png
<img width="1290" height="698" alt="image" src="https://github.com/user-attachments/assets/2ab6e347-841f-4974-9c51-5d4923a630de" />
5.cron-job.png
<img width="1300" height="714" alt="image" src="https://github.com/user-attachments/assets/6d09ca5c-c613-4224-bc22-c3f1b4806cd5" />
6.psotfix-status.png
<img width="1572" height="868" alt="image" src="https://github.com/user-attachments/assets/c2f3f9c6-ec75-4e7f-944f-621b31828df6" />
7.stress-test.png
<img width="1514" height="830" alt="image" src="https://github.com/user-attachments/assets/04ec0cf3-047a-4393-bccb-b17bcc7f1281" />
8.email-alert.png
<img width="1462" height="645" alt="Screenshot 2026-07-10 233153" src="https://github.com/user-attachments/assets/5a41b2e4-5067-461a-9a4e-f23ea181701e" />










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

# 📊 Log Output


cpu_usage.log

<img width="1292" height="704" alt="WhatsApp Image 2026-07-10 at 11 46 34 PM" src="https://github.com/user-attachments/assets/5b412b14-bfa9-484f-902b-f6239f680290" />

---

# 📩 Email Alert Output

<img width="731" height="323" alt="image" src="https://github.com/user-attachments/assets/873681b9-eed1-4a1b-8038-92bf6d209207" />

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
