#!/bin/bash

disks="total,sda3,sdb1,sdc1,sdd1"
prefix="hdd"

filename=$prefix_$1
interval=$2

echo "log filename: $filename"
cd ~/testlogs
dstat -cdnm --disk-util -D $disks -Nlo,total $interval 2>&1 >$filename
