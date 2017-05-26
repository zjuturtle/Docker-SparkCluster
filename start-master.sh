#! /bin/bash

# start spark master
/app/local/spark/sbin/start-master.sh>/dev/null

# show log file
logFileList=($(find /app/local/spark/logs -name "*.out"))
if [ ${#logFileList[*]} -gt 1 ];then 
    echo '[WARN]logfile is not unique'
fi
if [ ${#logFileList[*]} -eq 0 ];then
    echo '[WARN]logfile not exits'
    exit 1
fi
logFile=${logFileList[0]}
tail -f ${logFile}


