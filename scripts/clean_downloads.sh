#!/bin/bash
compareDate=$(date -d "30 days ago" '+%Y%m%d')

log_file="$HOME/Downloads/cleanup_log"
rm -f $log_file
touch $log_file

for f in $HOME/Downloads/*;
do
    fileDate=$(date -r "$f" -u "+%Y%m%d")
    if [ ! "$fileDate" -gt "$compareDate" ];then
        echo Deleting - "$f" >> $log_file
        rm -rf  "$f"
    else 
        echo Keeping - "$f" >> $log_file
    fi
done

