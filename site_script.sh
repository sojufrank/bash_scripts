#!/bin/bash

#name
name=`hostname`

#date
date=`date`

#uptime
uptime=`uptime | tr -s ' ' | cut -d ' ' -f 4`

#kernel version
kernel=`uname -v | cut -c 5-55 | cut -c 1-15`

#ip address
ip=`hostname -I | awk '{print $1}'`

#memory variables
total_memory=`free -h | grep Mem | tr -s ' ' | cut -d ' ' -f 2`
used_memory=`free -h | grep Mem | tr -s ' ' | cut -d ' ' -f 3`
free_memory=`free -h | grep Mem | tr -s ' ' | cut -d ' ' -f 7`

#disk variables
total_hd=`df -h | grep sda1 | tr -s ' ' | cut -d ' ' -f 2`
used_hd=`df -h | grep sda1 | tr -s ' ' | cut -d ' ' -f 3`
free_hd=`df -h | grep sda1 | tr -s ' ' | cut -d ' ' -f 4`

#create data.js file
cd /root/website

echo "const data = {
    name:'$name',
    date:'$date',
    uptime:'$uptime days',
    kernel:'$kernel',
    ip:'$ip',
    totalMemory:'$total_memory',
    usedMemory:'$used_memory',
    freeMemory:'$free_memory',
    totalHarddisk:'$total_hd',
    usedHarddisk:'$used_hd',
    freeHarddisk:'$free_hd'
}" > data.js

cp * /var/www/html/

#logging
logCount=`cat /var/log/websiteData.log | grep log_count | cut -d ' ' -f2`
((logCount++))
sed -i "s/log_count.*/log_count $logCount/" /var/log/websiteData.log

echo "
log# $logCount
name: $name
date: $date
uptime: $uptime days
kernel: $kernel
ip: $ip
total memory: $total_memory
used memory: $used_memory
free memory: $free_memory
total harddisk: $total_hd
used harddisk: $used_hd
free harddisk: $free_hd" >> /var/log/websiteData.log
