#!/bin/bash

passwd=$1
echo "passwd="$passwd

hosts="
qihe6031
qihe6032
qihe6033
qihe6034
qihe6035
qihe6036
qihe6037
qihe6038
qihe6039
qihe6040
qihe6029
qihe6030
mofa4024
mofa4025
mofa4026
mofa4027
mofa2082
mofa2083
mofa2084
mofa2085
mofa2086
mofa2087
mofa2088
mofa2089
mofa2090
mofa2091
mofa2092
mofa2093
mofa5155
mofa5156
mofa5157
mofa5158
mofa5159
mofa5160
mofa5161
mofa5162
"

disks="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi /dev/sdj /dev/sdk /dev/sdl"


for h in $hosts
do

  for disk in $disks
  do
    exp.sh $passwd ssh -p10022 $h -t "echo $passwd | sudo -S tune2fs -m 1 $disk"
  done

done

