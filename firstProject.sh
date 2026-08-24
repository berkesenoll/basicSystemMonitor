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

function display_menu(){
    echo '
basic system tracking
0 exit
1 memory usage
2 disk usage
3 uptime
4 process amount
'
}

while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            echo "A simple system monitoring tool written in Bash. sudo is required in order to use. You can monitor memory and disk usage, uptime and process amount."
            exit 0
            ;;
    esac

    shift
done

if [[ $(id -u) -eq 0 ]]; then    
    display_menu
    read -p "Please choose one: " choiceOne

    if [[ $choiceOne -eq 0 ]]; then
        echo "Exiting the program."
        exit 0

    elif [[ $choiceOne -eq 1 ]]; then
        memory_usage

    elif [[ $choiceOne -eq 2 ]]; then
        disk_usage

    elif [[ $choiceOne -eq 3 ]]; then
        report_uptime

    elif [[ $choiceOne -eq 4 ]]; then
        process_amount
    else
        echo "invalid number. Exiting the program."
        exit 0
    fi

else
    echo "You must be superuser to execute this program!"
fi


