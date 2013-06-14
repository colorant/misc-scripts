#!/bin/bash

#need to be done by normal user.

confdir=$1
echo "switch to" $confdir

docluster rm ~/hadoop/conf -r
docluster cp -a ~/hadoop/$confdir ~/hadoop/conf
