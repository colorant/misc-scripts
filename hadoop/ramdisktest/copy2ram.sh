#!/bin/bash

#need to be done by normal user.

echo "$1/hdfs"

time cp -a $1/hdfs /mnt/ramdisk1/ &
time ssh 10.0.0.73 cp -a $1/hdfs /mnt/ramdisk1/ &
time ssh 10.0.0.74 cp -a $1/hdfs /mnt/ramdisk1/ &
time ssh 10.0.0.75 cp -a $1/hdfs /mnt/ramdisk1/ &
time ssh 10.0.0.76 cp -a $1/hdfs /mnt/ramdisk1/ &

#docluster sync
