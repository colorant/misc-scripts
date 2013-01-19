#!/bin/bash

#set -x

HFILES=`cat $1 | grep "Cached" | grep "$2" | awk '{print $8}' | sed 's/\./ /g' | awk '{print $2}'`

Table=$1

IP=`echo $2 | sed 's/sr1/10\.0\.0\./g'`
echo $IP

mydisks="/mnt/DP_disk1 /mnt/DP_disk2 /mnt/DP_disk3 /mnt/DP_disk4"
hdfspath="raymond/hdfs/data/current/"
tmpfile=averyimpossiblenotexistfile

hadoop=/home/raymond/hadoop/bin/hadoop

rm $tmpfile -rf
for disk in $mydisks
do
  ssh $IP "find $disk/$hdfspath -name '*meta'" >> $tmpfile
done

for f in $HFILES
do
  echo $f
  blocks=`$hadoop fsck /hbase/$Table/$f/cf0 -files -blocks -locations 2>/dev/null | grep "blk_" | awk '{print $2}'`

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
done
