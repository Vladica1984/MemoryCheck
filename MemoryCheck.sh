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
  echo -e "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
  <html xmlns=\"http://www.w3.org/1999/xhtml\">
   <head>
     <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
       <title>Demystifying Email Design</title>
         <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>
	 </head><body><font color=\"red\">Warning, server memory running low! Free memory: $free MB</font></body></html>" | mail -a "Content-Type: text/html" -A "$file" -s "$Subject" vpopovic@tmns.com
  rm -rf "$file"
fi

exit 0
