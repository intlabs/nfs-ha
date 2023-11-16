#!/bin/bash
set -ex

# Ensure the dbus directory exists and remove any existing pid file
mkdir -p /run/dbus
rm -f /run/dbus/pid || true

# Start the D-Bus System Message Bus
dbus-daemon --system

# Start the RPC Bind service
rpcbind

# Extract the instance number from the hostname
# Assumes hostname ends with a hyphen followed by a number
instance="$(awk -F '-' '{ print $NF }' /etc/hostname)"

# Adjust the priority in the Keepalived configuration based on the instance number
# This assumes the original priority is set to '100' in the configuration file
sed -i "s/priority 100/priority 10${instance}/" /etc/keepalived/keepalived.conf

# Execute Keepalived with specified options
exec keepalived --vrrp --dont-fork --log-console