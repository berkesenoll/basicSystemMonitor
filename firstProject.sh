echo 'basic system tracking'

echo '
1 memory usage
2 disk usage
3 uptime
4 process amount
'

read -p "Please choose one: " choiceOne

if [[ $(id -u) -eq 0 ]]; then

if [[ $choiceOne -eq 2 ]]; then #3 disk usage
    df -h
fi

if [[ $choiceOne -eq 3 ]]; then
    uptimeSec=$(awk '{print $1}' /proc/uptime)
    uptimeHour=$((uptimeSec/3600))
    echo "uptime: $uptimeSec Seconds / $uptimeHour Hours" 
fi

if [[ $choiceOne -eq 1 ]]; then
    memTotal=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    memAvailable=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    memUse=$((memTotal-memAvailable))
    memPerc=$((memUse*100/memTotal))
    echo "Memory usage: $memPerc%"
fi

if [[ $choiceOne -eq 4 ]]; then
    ls /proc | grep "^[0-9]\+$" | wc -l
fi

fi


