#!/bin/bash

#need to be done by normal user.

docluster rm hadoop/conf -r
docluster cp -a hadoop/conf.ram.r1 hadoop/conf
