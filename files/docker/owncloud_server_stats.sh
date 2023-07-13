#!/bin/bash

stats=$(docker stats --no-stream owncloud_server | awk 'NR>1')

container_name=$(echo "$stats" | awk '{print $2}')
cpu_percent=$(echo "$stats" | awk '{print $3}' | tr -d '%')
mem_percent=$(echo "$stats" | awk '{print $7}' | tr -d '%')
pids=$(echo "$stats" | awk '{print $14}')

echo "container_name,cpu_percent,mem_percent,pids"
echo "$container_name,$cpu_percent,$mem_percent,$pids"
