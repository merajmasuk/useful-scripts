#!/bin/bash

# Replace these values with the specific domain or IP you want to allow
allowed_host="example.com"  # Replace with the specific IP address
allowed_ip=$(dig +short $allowed_host)
dns="103.28.121.11"

# Define the whitelist
WHITELIST=(
    "192.168.0.0/16" # Local network subnet
    $allowed_ip
    $dns
)


if [ "$(id -u)" -ne 0 ]; then
	echo "Please run with sudo"
	exit 1
fi


# Flush existing rules
iptables -F

# Default policies
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT DROP

# Allow loopback and established connections
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow outgoing connections to whitelisted IPs
for ip in "${WHITELIST[@]}"; do
    iptables -A OUTPUT -d "$ip" -j ACCEPT
done

# Log dropped packets (optional)
iptables -A OUTPUT -m limit --limit 2/min -j LOG --log-prefix "Dropped by firewall: " --log-level 4
