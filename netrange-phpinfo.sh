#!/bin/bash

# Define variables for IP ranges
start_ip="52.0.0.0"
end_ip="52.79.255.255"

# Define a function to handle the download
download_file() {
    local ip="$1"
    wget -t 1 -T 5 "http://${ip}/phpinfo.php" -O "${ip}_phpinfo.php"
}

# Loop through IP addresses
IFS='.' read -r -a start_ip_parts <<< "$start_ip"
IFS='.' read -r -a end_ip_parts <<< "$end_ip"

for a in $(seq ${start_ip_parts[0]} ${end_ip_parts[0]}); do
    for b in $(seq ${start_ip_parts[1]} ${end_ip_parts[1]}); do
        for c in $(seq ${start_ip_parts[2]} ${end_ip_parts[2]}); do
            for d in $(seq ${start_ip_parts[3]} ${end_ip_parts[3]}); do
                current_ip="${a}.${b}.${c}.${d}"
                download_file "$current_ip"
            done
        done
    done
done
