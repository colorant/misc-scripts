#!/bin/bash

# This script is aim to do cmd on multi machine
# it's just a simple script replace the "mycluster with real ip"
# barely can be used, might be better to be redo in python
# might be better to be able to run on multiple machine at the same time instead of sequently

if [ x$1 == x ]
then
    echo "Usage: $0 your cmd with 'mycluster' to replace the real ip"
    echo "Example : 'ssh mycluster ls /' will be run as 'ssh real_ip ls /' on all the ips"
    echo ""
    echo "Before use the script, edit it to modify the MYCLUSTERS to contain your machines' ip"
fi

cmd=$*

# replace with your own ip !

# MYCLUSTERS=(10.0.0.171 10.0.0.173 10.0.0.174 10.0.0.175 10.0.0.176)

for i in "${MYCLUSTERS[@]}"; do

    realcmd=`echo $cmd | sed s/mycluster/$i/`

    echo "-- running : " $realcmd " --"
    echo ""
    $realcmd
    echo ""
    echo "-- done --"

done

