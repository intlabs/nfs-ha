#!/bin/bash
set -ex
mkdir -p /run/dbus
dbus-daemon --system
rpcbind
exec keepalived --vrrp --dont-fork --log-console