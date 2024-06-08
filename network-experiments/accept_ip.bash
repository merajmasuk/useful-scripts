#!/bin/bash

# Replace these values with the specific domain or IP you want to allow

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run with sudo"
	exit 1
fi

iptables -F
iptables -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
