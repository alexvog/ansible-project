#!/bin/bash

output=$(top -b -n 1 | head -5)

line1=$(echo "$output" | sed -n '1p')
line2=$(echo "$output" | sed -n '2p')
line3=$(echo "$output" | sed -n '3p')
line4=$(echo "$output" | sed -n '4p')
line5=$(echo "$output" | sed -n '5p')


# Extract the desired information and assign it to variables

active_users=$(echo "$line1" | awk '{if ($7 ~ /user(s)?,/) print $6; else print $7}')
cpu_utilization=$(echo "$line3" | awk -F '[ ,:]+' '{print 100.0-$8}')
memory_utilization=$(echo "$line4" | awk '{print $8/$4 * 100.0}')

cpu_load_average_1min=$(echo "$line1" | awk '{print $(NF-2)}' | tr -d ',')
cpu_load_average_5min=$(echo "$line1" | awk '{print $(NF-1)}' | tr -d ',')
cpu_load_average_15min=$(echo "$line1" | awk '{print $(NF)}')

total_tasks=$(echo "$line2" | awk '{print $2}')
running_tasks=$(echo "$line2" | awk '{print $4}')
sleeping_tasks=$(echo "$line2" | awk '{print $6}')
stopped_tasks=$(echo "$line2" | awk '{print $8}')
zombie_tasks=$(echo "$line2" | awk '{print $10}')


echo "active_users,cpu_utilization,memory_utilization,cpu_load_average_1min,cpu_load_average_5min,cpu_load_average_15min,total_tasks,running_tasks,sleeping_tasks,stopped_tasks,zombie_tasks"
echo "$active_users,$cpu_utilization,$memory_utilization,$cpu_load_average_1min,$cpu_load_average_5min,$cpu_load_average_15min,$total_tasks,$running_tasks,$sleeping_tasks,$stopped_tasks,$zombie_tasks"
