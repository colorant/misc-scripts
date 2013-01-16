#!/bin/sh

# perform dd test on mydisks/testfile, total size is blockcount*block.
# output result with total data and speed.

mydisks="/mnt/DP_disk1 /mnt/DP_disk2 /mnt/DP_disk3 /mnt/DP_disk4"
testfile=notpossiblefile
blockcount=100
block=10M

for x in $mydisks
do
  rm -f $x/$testfile
  echo 3 > /proc/sys/vm/drop_caches
  sync
  echo  "write:" $x `dd bs=$block count=$blockcount if=/dev/zero of=$x/$testfile conv=fdatasync 2>&1 | grep "B" | awk '{print $3 $4 " : "  $8 $9}'`
  echo 3 > /proc/sys/vm/drop_caches
  sync
  echo  "read:" $x `dd bs=$block count=$blockcount of=/dev/null if=$x/$testfile conv=fdatasync 2>&1 | grep "B" | awk '{print $3 $4 " : "  $8 $9}'`
  rm -f $x/$testfile
done


