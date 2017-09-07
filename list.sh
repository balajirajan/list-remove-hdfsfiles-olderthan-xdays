#!/bin/bash
usage="Usage: ./list-old-hdfs-files.sh [path] [days]"

if [ ! "$1" ]
then
  echo $usage;
  exit 1;
fi

if [ ! "$2" ]
then
  echo $usage;
  exit 1;
fi

now=$(date +%s);

# Loop through files
sudo -u hdfs hdfs dfs -ls $1 | while read f; do
  # Get File Date and File Name
  file_date=`echo $f | awk '{print $6}'`;
  file_name=`echo $f | awk '{print $8}'`;

  # Calculate Days Difference
  difference=$(( ($now - $(date -d "$file_date" +%s)) / (24 * 60 * 60) ));
  if [ $difference -gt $2 ]; then
    # List the older than $2 files
    echo "$file_name is dated $file_date.";
  fi
done
