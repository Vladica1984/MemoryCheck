#!/bin/bash -x

Subject=$(hostname)

file="/tmp/top_proccesses_consuming_memory.txt"
email="$1"
freeMemTrigger="$2"

free=$(free -mt | grep Mem | awk '{print $4}')

if [[ "$free" -le $freeMemTrigger ]]; then
	printf "From: Vladimir <vpopovic@tmns.com>
To: $email
Subject: Warning email
MIME-Version: 1.0
Content-Type: text/html
Content-Disposition: inline
<html>
<head><title>Warning email</title>
</head>
<body style=\"font: monospace;\">
<pre style=\"color: red\">Warning, server memory running low! Free memory: $free MB</pre>
<pre>
Checking the running listeners and free memory

With netstat -ltn we are checking running listeners:

$(netstat -ltn | grep 44)

Free memory is checked with free -mt command and bellow is current situation:

$(free -mt)

Current time: $(date '+%Y-%m-%d %H:%M:%S')
</pre>
</body>
</html>
	" | sendmail -t
else
	echo "OK"
fi

exit 0
