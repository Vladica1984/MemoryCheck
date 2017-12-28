#!/bin/bash -x

Subject=$(hostname)

free=$(free -mt | grep Mem | awk '{print $4}')

if [[ "$free" -le 1000 ]]; then

echo "Checking the running listeners and free memory" | head >./top_proccesses_consuming_memory.txt

echo " " >>./top_proccesses_consuming_memory.txt

netstat -ltn | head >>./top_proccesses_consuming_memory.txt

free -mt >> ./top_proccesses_consuming_memory.txt

echo -e "Warning, server memory running low! Free memory: $free MB" | mail -A ./top_proccesses_consuming_memory.txt -s "$Subject" vpopovic@tmns.com

rm -rf ./top_proccesses_consuming_memory.txt

fi

exit 0
