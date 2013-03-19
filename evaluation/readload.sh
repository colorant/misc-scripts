#!/bin/bash

file=$1
tmpfile=tmp.log

sed "s/|/ /g" $file | sed "s/:/ /g" > $tmpfile
python avgload.py $tmpfile 10 5

