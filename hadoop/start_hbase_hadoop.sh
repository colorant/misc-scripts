#!/bin/bash

set -x
echo "startup hbase and hadoop"
~/hadoop/bin/start-dfs.sh
~/hadoop/bin/start-mapred.sh
~/hbase/bin/start-hbase.sh
sleep 1
echo "----------------"
jps
echo "done"
