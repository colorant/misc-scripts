#!/bin/bash

mydisks="/mnt/DP_disk1 /mnt/DP_disk2 /mnt/DP_disk3 /mnt/DP_disk4"
#mydisks="/mnt/DP_disk13 /mnt/DP_disk14 /mnt/DP_disk15 /mnt/DP_disk16"

type=$1
testFileNum=$2
testFilePrefix=testfile

blockcounts=1000
blocks=1M

if [ $# -lt 2 ]; then
echo $0 "[read|write|clean] numberOfFiles"
exit
fi

echo 3 > /proc/sys/vm/drop_caches
sync
sleep 1

if [ "x"$type == "xwrite" ]
then
echo "Writing files"
for x in $mydisks
do
  for ((y = 0; y < $testFileNum; y++))
  do
    rm -f $x/$testFilePrefix$y
  done

  for ((y = 0; y < $testFileNum; y++))
  do
    echo  "write:" $x `dd bs=$blocks count=$blockcounts if=/dev/zero of=$x/$testFilePrefix$y conv=fdatasync 2>&1 | grep "B" | awk '{print $3 $4 " : "  $8 $9}'` &
  done
done
exit
fi

if [ "x"$type == "xclean" ]
then
echo "Clean files"
for x in $mydisks
do
  for ((y = 0; y < $testFileNum; y++))
  do
    rm -f $x/$testFilePrefix$y
  done
done
exit
fi

if [ "x"$1 == "xread" ]
then
echo "Reading files"
for x in $mydisks
do
  for ((y = 0; y < $testFileNum; y++))
  do
    echo  "read:" $x `dd bs=$blocks count=$blockcounts of=/dev/null if=$x/$testFilePrefix$y 2>&1 | grep "B" | awk '{print $3 $4 " : "  $8 $9}'` &
  done
done
exit
fi

echo $0 "[read|write|clean] numberOfFiles"

