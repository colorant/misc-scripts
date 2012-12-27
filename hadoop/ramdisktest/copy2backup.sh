#!/bin/bash

#need to be done by normal user.

if [ -e $1 ]
then
  echo $1 "already exist"
  exit
fi

docluster mkdir $1

time cp -a /mnt/ramdisk1/hdfs $1 &
time ssh 10.0.0.73 cp -a /mnt/ramdisk1/hdfs $1 &
time ssh 10.0.0.74 cp -a /mnt/ramdisk1/hdfs $1 &
time ssh 10.0.0.75 cp -a /mnt/ramdisk1/hdfs $1 &
time ssh 10.0.0.76 cp -a /mnt/ramdisk1/hdfs $1 &

#docluster sync
