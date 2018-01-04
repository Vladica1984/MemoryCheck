#!/bin/bash -x

Subject=$(hostname)


free=$(free -mt | grep Mem | awk '{print $4}')

if [[ "$free" -le 2000 ]]; then

printf "Warning, server memory running low! Free memory: $free MB\n" > ./top_proccesses_consuming_memory.txt

echo " " >>./top_proccesses_consuming_memory.txt

printf "Checking the running listeners and free memory\n"  >> ./top_proccesses_consuming_memory.txt

echo " " >>./top_proccesses_consuming_memory.txt

printf "With netstat -ltn we are checking running listeners:\n"  >> ./top_proccesses_consuming_memory.txt

echo " " >>./top_proccesses_consuming_memory.txt

netstat -ltn | grep 631 >>./top_proccesses_consuming_memory.txt

echo " " >>./top_proccesses_consuming_memory.txt

printf "Free memory is checked with free -mt command and bellow is current situation:\n"  >> ./top_proccesses_consuming_memory.txt

echo " " >>./top_proccesses_consuming_memory.txt

free -mt >> ./top_proccesses_consuming_memory.txt

cat ./top_proccesses_consuming_memory.txt | mail -s "$Subject" vpopovic@tmns.com

rm -rf ./top_proccesses_consuming_memory.txt

fi

exit 0
