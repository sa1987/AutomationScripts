#!/bin/bash

LOG_LOCATION=/tmp/logs
log_file=$(date +"%H-%d-%m-%Y")
exec >> $LOG_LOCATION/$log_file.log 2>&1

echo "**************************************************************************************"
echo
echo
echo "Current Time"
date
echo
echo
echo
echo "Memory Details"
free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }"\n""\n""\n""\n"'
echo
echo "============================================================================================"
echo
echo "TOP output"
top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}"\n""\n""\n""\n"'
echo
echo "============================================================================================"
echo
echo "Disk status"
df -h | awk '$NF=="/"{printf "%s\t\t", $5}"\n""\n""\n""\n"'
echo
echo "============================================================================================"
echo
echo "process details"
#ps  -eaxo "uname,ppid,pid,etime,%cpu,%mem,args""\n"
ps -ef

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"