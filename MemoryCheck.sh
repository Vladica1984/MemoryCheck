#!/bin/bash -x

Subject=$(hostname)
file="/tmp/top_proccesses_consuming_memory.html"
free=$(free -mt | grep Mem | awk '{print $4}')
low_memory_limit=$1

if [[ "$free" -le $low_memory_limit ]]; then
  echo "<p><font color="red">Checking the running listeners and free memory</font></p><p>" | head >"$file"
  netstat -ltn | head >>"$file"
  echo "</p><p>" >> "$file"
  free -mt >> "$file"
  echo "</p>" >> "$file"
  echo -e "<font color="red">Warning, server memory running low! Free memory: $free MB</font>" | mail -a 'Content-Type: text/html' -A "$file" -s "$Subject" vpopovic@tmns.com
  rm -rf "$file"
fi

exit 0
