#!/bin/bash

source settings.conf #import thresholds

availRAM=$(awk '/^Mem/ {printf("%u", 100*$7/$2);}' <(free -m))
   if [ $availRAM -le $RAMALERT ]; then
ntfy send "$(

      echo ":ram: Running out of RAM $availRAM% on $(hostname) as on $(date)"
	echo -e "Top RAM apps: \n"
ps axo pmem,args,pid --sort -pmem,-rss,-vsz | head -n 5
#OLD ONEps axo pid,args,pmem,rss,vsz --sort -pmem,-rss,-vsz | head -n 5
)"
   fi
