#!/bin/bash

# Path to the Bash script you want to execute remotely
script_path="/home/meraj/demo.bash"


# Function to execute script on hosts in a subnet
execute_on_subnet() {
    local subnet="$1"
    echo "Scanning subnet $subnet..."
    nmap_scan=$(nmap -sn "$subnet" | grep "Nmap scan report" | awk '{print $5}')
    if [ -z "$nmap_scan" ]; then
        echo "No hosts found on subnet $subnet."
    else
        for host in $nmap_scan; do
            echo "Executing script on $host..."
            ssh "$host" bash "$script_path"
            echo "Script execution on $host completed."
        done
    fi
}

# Define the subnets to scan
subnets=(
    "192.168.0.0/24"
)

# Iterate over the subnets and execute the script on hosts in each subnet
for subnet in "${subnets[@]}"; do
    execute_on_subnet "$subnet"
done
