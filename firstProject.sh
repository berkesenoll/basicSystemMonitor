#!/usr/bin/env bash 
#use bash shell if not using already.

if [[ $(id -u) -eq 0 ]]; then
echo '
basic system tracking
1 memory usage
2 disk usage
3 uptime
4 process amount
'

read -p "Please choose one: " choiceOne

if [[ $choiceOne -eq 1 ]]; then
    memTotal=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    memAvailable=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    memUse=$((memTotal-memAvailable))
    memPerc=$((memUse*100/memTotal))
    echo "Memory usage: $memPerc%"

elif [[ $choiceOne -eq 2 ]]; then #3 disk usage
    df -h

elif [[ $choiceOne -eq 3 ]]; then
    uptimeSec=$(awk '{print $1}' /proc/uptime)
    echo "uptime: $uptimeSec Seconds"

elif [[ $choiceOne -eq 4 ]]; then
    ls /proc | grep "^[0-9]\+$" | wc -l
fi

else
    echo "You must be superuser to execute this program!"
fi


