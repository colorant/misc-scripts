#!/bin/bash

#set -x

mydisks="/mnt/DP_disk1 /mnt/DP_disk2 /mnt/DP_disk3 /mnt/DP_disk4"
hdfspath="raymond/hdfs/data/current/"
tmpfile=averyimpossiblenotexistfile


hadoop=/home/raymond/hadoop/bin/hadoop
file=$2
host=$1
found=0

rm $tmpfile -rf
for disk in $mydisks
do
  ssh $host "find $disk/$hdfspath -name '*meta'" >> $tmpfile
done

blocks=`$hadoop fsck $file -files -blocks -locations 2>/dev/null | grep "blk_" | awk '{print $2}'`

for block in $blocks
do
    result=`grep "$block*" $tmpfile | sed 's/\// /g' | awk '{print $2}'`
    if [ "a"$result != "a" ]
    then
      echo $block ":" $result
    else
      echo $block ": Not Found"
    fi
done
