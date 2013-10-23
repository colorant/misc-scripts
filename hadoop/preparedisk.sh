#!/bin/bash

#need to be done by root
#prepare disk dir for hadoop

mydisks="/mnt/DP_disk1 /mnt/DP_disk2 /mnt/DP_disk3 /mnt/DP_disk4"
mydir=raymond

for x in $mydisks
do
dirpath=$x/$mydir
mkdir $dirpath
mkdir $dirpath/hdfs
mkdir $dirpath/hdfs/data
mkdir $dirpath/hdfs/name
mkdir $dirpath/hdfs/namesecondary
mkdir $dirpath/yarn/mapred
mkdir $dirpath/yarn/nmlocal
chown raymond:raymond $dirpath -R
done

