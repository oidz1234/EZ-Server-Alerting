#!/bin/bash
source settings.conf #import thresholds

df -P | grep -vE "Filesystem|tmpfs|cdrom|/dev/loop" | awk '{ print $5 " " $1 " " $6}' | while read output;
do
   usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
   partition=$(echo $output | awk '{ print $2 }' )
   folder=$(echo $output | awk '{ print $3 }' )
   if [ $usep -ge $DISKALERT ]; then
ntfy send "$(
      echo ":floppy_disk: Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)"
topfiles=`sudo du -Sh $folder  --exclude=/proc --exclude=/mnt | sort -rh | head -5`
      echo -e "Top files \n$topfiles"

)"
   fi
done
