#!/usr/bin/env bash 
#use bash shell if not using already.

function memory_usage(){
    local memTotal
    local memAvailable
    local memUse
    local memPerc
    memTotal=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    memAvailable=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    memUse=$((memTotal-memAvailable))
    memPerc=$((memUse*100/memTotal))

    echo "Memory usage: $memPerc%"
}

function disk_usage(){
    df -h
}

function process_amount(){
    ls /proc | grep "^[0-9]\+$" | wc -l
}

function report_uptime(){
    local uptimeSec
    uptimeSec=$(awk '{print $1}' /proc/uptime)
    echo "uptime: $uptimeSec Seconds"
}

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
    memory_usage

elif [[ $choiceOne -eq 2 ]]; then
    disk_usage

elif [[ $choiceOne -eq 3 ]]; then
    report_uptime

elif [[ $choiceOne -eq 4 ]]; then
    process_amount
fi

else
    echo "You must be superuser to execute this program!"
fi


