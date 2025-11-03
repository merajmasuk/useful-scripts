#!/bin/bash

# List of PC IP addresses
pc_ips=(
    "192.168.20.16"
    "192.168.20.17"
)

# Network interface
interface="eno1"
dir="/home/user/contest"

# Capture traffic for each PC
for ip in "${pc_ips[@]}"; do
    tshark -i $interface -f "host $ip" -w "$dir/$ip.pcap" &
done

# Wait for the captures to complete
wait
