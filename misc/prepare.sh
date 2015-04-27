idx=0
batchnum=100
combinedline="hdfs dfs -rm -r"
while read line
do
if (( $idx < $batchnum ))
then
  combinedline=$combinedline" "$line
  let idx=$idx+1
else
  combinedline=$combinedline" "$line
  echo $combinedline
  echo
  let idx=0
  combinedline="hdfs dfs -rm -r"
fi

done < odssort.txt

echo
echo $combinedline
