#!/bin/sh

#set -x

tablename=$1
time=`date -d "now" +%Y%m%d%H%M%S`

logfile=$tablename"_"$time
locallogfile=~/testlogs/$logfile

cat ~/pass | sudo -S docluster "echo 3 > /proc/sys/vm/drop_caches"
doslave "nohup ~/measureload.sh $logfile"_cf" 5 >> ~/runtest.logs 2>&1 &"
echo "---------- scan cf0 without qualifier -----------" >> $locallogfile
~/hbase/bin/hbase org.apache.hadoop.hbase.PerformanceEvaluation2 --table=$tablename --cols="cf0" --type=mapred2 2>&1 | tee -a $locallogfile
sleep 5
doslave "sync; killall python; sync"

cat ~/pass | sudo -S docluster "echo 3 > /proc/sys/vm/drop_caches"
doslave "nohup ~/measureload.sh $logfile"_18c" 5 >> ~/runtest.logs 2>&1 &"
echo "---------- scan cf0 with 18 cols -----------" >> $locallogfile
~/hbase/bin/hbase org.apache.hadoop.hbase.PerformanceEvaluation2 --table=$tablename --cols="cf0:d.f0 cf0:d.f1 cf0:d.f2 cf0:d.f3 cf0:d.f4 cf0:d.f5 cf0:d.f6 cf0:d.f7 cf0:d.f8 cf0:d.f9 cf0:d.f10 cf0:d.f11 cf0:d.f12 cf0:d.f13 cf0:d.f14 cf0:d.f15 cf0:d.f16 cf0:d.f17" --type=mapred2 2>&1 | tee -a $locallogfile
sleep 5
doslave "sync; killall python; sync"

cat ~/pass | sudo -S docluster "echo 3 > /proc/sys/vm/drop_caches"
doslave "nohup ~/measureload.sh $logfile"_9c" 5 >> ~/runtest.logs 2>&1 &"
echo "---------- scan cf0 with 9 cols -----------" >> $locallogfile
~/hbase/bin/hbase org.apache.hadoop.hbase.PerformanceEvaluation2 --table=$tablename --cols="cf0:d.f0 cf0:d.f1 cf0:d.f2 cf0:d.f3 cf0:d.f4 cf0:d.f9 cf0:d.f10 cf0:d.f11 cf0:d.f12" --type=mapred2 2>&1 | tee -a $locallogfile
sleep 5
doslave "sync; killall python; sync"

cat ~/pass | sudo -S docluster "echo 3 > /proc/sys/vm/drop_caches"
doslave "nohup ~/measureload.sh $logfile"_3c" 5 >> ~/runtest.logs 2>&1 &"
echo "---------- scan cf0 with 3 cols -----------" >> $locallogfile
~/hbase/bin/hbase org.apache.hadoop.hbase.PerformanceEvaluation2 --table=$tablename --cols="cf0:d.f0 cf0:d.f1 cf0:d.f2" --type=mapred2 2>&1 | tee -a $locallogfile
sleep 5
doslave "sync; killall python; sync"

cat ~/pass | sudo -S docluster "echo 3 > /proc/sys/vm/drop_caches"
doslave "nohup ~/measureload.sh $logfile"_1c" 5 >> ~/runtest.logs 2>&1 &"
echo "---------- scan cf0 with 1 col -----------" >> $locallogfile
~/hbase/bin/hbase org.apache.hadoop.hbase.PerformanceEvaluation2 --table=$tablename --cols="cf0:d.f0" --type=mapred2 2>&1 | tee -a $locallogfile
sleep 5
doslave "sync; killall python; sync"

