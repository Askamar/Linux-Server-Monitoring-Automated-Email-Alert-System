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
