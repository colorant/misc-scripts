#!/bin/bash

#set -x

mydisks="/mnt/DP_disk1 /mnt/DP_disk2 /mnt/DP_disk3 /mnt/DP_disk4"
hdfspath="raymond/hdfs/data/current/"

hadoop=/home/raymond/hadoop/bin/hadoop
file=$2
host=$1

blocks=`$hadoop fsck $file -files -blocks -locations 2>/dev/null | grep "blk_" | awk '{print $2}'`

for block in $blocks
do
  for disk in $mydisks
  do
    result=`ssh $host "find $disk/$hdfspath -name '*$block*'"`
    if [ "a"$result != "a" ]
    then
      location=`echo $result | sed 's/\// /g' | awk '{print $2}'`
      echo $block ":" $location
      break
    fi
  done
done
