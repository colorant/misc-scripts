#!/bin/bash

#need to be done by root

mkdir /mnt/ramdisk1
chmod 777 /mnt/ramdisk1
umount /mnt/ramdisk1
mount -t tmpfs -o noatime,nodiratime,size=28g tmpfs /mnt/ramdisk1

mkdir /mnt/ramdisk1/hdfs
mkdir /mnt/ramdisk1/hdfs/data
mkdir /mnt/ramdisk1/hdfs/name
mkdir /mnt/ramdisk1/hdfs/mapred
mkdir /mnt/ramdisk1/hdfs/namesecondary

chown raymond:raymond /mnt/ramdisk1/hdfs -R
