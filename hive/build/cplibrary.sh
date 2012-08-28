#!/bin/bash

# This script is used to copy necessary files before running hive testcase

HBASEDIR=~/cloud/built/hbase-0.94.0

cp $HBASEDIR/lib/protobuf-java-2.4.0a.jar build/hadoopcore/hadoop-0.20.1/lib
cp $HBASEDIR/lib/protobuf-java-2.4.0a.jar build/hadoopcore/hadoop-1.0.3/lib

cp $HBASEDIR/lib/protobuf-java-2.4.0a.jar build/ivy/lib/default
cp ~/.m2/repository/com/yammer/metrics/metrics-core/2.1.2/metrics-core-2.1.2.jar build/ivy/lib/default/
