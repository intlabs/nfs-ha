#!/bin/bash

# Get the current server's IP address
CURRENT_IP=$(ip -j addr show eth0 | jq -r '.[0].addr_info[] | select(.family=="inet") | .local' | grep -v "172.18.0.100")

# Define the IP addresses of all servers
SERVER_IPS=("172.18.0.2" "172.18.0.3" "172.18.0.4")

# Initialize a count of reachable servers
REACHABLE_COUNT=0

# Check connectivity to each server
for IP in "${SERVER_IPS[@]}"; do
    if [ "$IP" != "$CURRENT_IP" ]; then
        # Ping the other server
        ping -c 1 -w 1 $IP > /dev/null
        if [ $? -eq 0 ]; then
            # Increment the reachable count if the ping is successful
            ((REACHABLE_COUNT++))
        fi
    fi
done

# Check if at least one other server is reachable
if [ $REACHABLE_COUNT -ge 1 ]; then
    exit 0
else
    exit 1
fi
