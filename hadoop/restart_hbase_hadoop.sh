#!/bin/bash

set -x
echo "shutdown hbase and hadoop"
~/hbase/bin/stop-hbase.sh
~/hadoop/bin/stop-mapred.sh
~/hadoop/bin/stop-dfs.sh
sleep 1
echo "startup hbase and hadoop"
~/hadoop/bin/start-dfs.sh
~/hadoop/bin/start-mapred.sh
~/hbase/bin/start-hbase.sh
echo "done"
