#!/bin/bash -x

if [ "$#" -ne 2 ]; then
        echo "USAGE: $0 <EMAIL> <FREE MEMORY TRIGGER>"
        exit 1
fi


subject="Low memory at $(hostname)"

email="$1"
freeMemTrigger="$2"

free=$(free -mt | grep Mem | awk '{print $4}')

if [[ "$free" -le $freeMemTrigger ]]; then
	printf "From: Vladimir <vpopovic@tmns.com>\nTo: $email\nSubject: $subject\nMIME-Version: 1.0\nContent-Type: text/html\nContent-Disposition: inline\n
<html>
<head><title>$subject</title>
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
