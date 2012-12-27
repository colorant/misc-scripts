#!/bin/bash

set -x
echo "shutdown hbase and hadoop"
~/hbase/bin/stop-hbase.sh
~/hadoop/bin/stop-mapred.sh
~/hadoop/bin/stop-dfs.sh
echo "done"
