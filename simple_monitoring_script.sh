#!/bin/bash
echo "-------------------------------------------"
echo "Server_Name   CPU(%)   Memory(%)   Disk(%)"
echo "-------------------------------------------"
server=$(curl http://169.254.169.254/latest/meta-data/instance-id)
ramusage=$(free | awk '/Mem/{printf("RAM Usage: %.2f\n"), $3/$2*100}'| awk '{print $3}')
cpu=$(cat /proc/stat | awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' |  awk '{print $0}' | head -1)
disk=$(df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }')
echo -e  $"$server \ncpu: $cpu \nMem: $ramusage \ndisk: $disk" > /var/log/monitor.log