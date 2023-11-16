#!/bin/bash
echo "$(date) master" >> /tmp/state

####################################################################################################
####################################################################################################
# Insert code that:
# 1. Takes a snapshot of the pure volume
# 2. Clears any iscsi reservations on the pure volume, as well as decalring a reservation for this instance
####################################################################################################
####################################################################################################


mount "/dev/loop0" /srv
ganesha.nfsd -f /etc/ganesha/ganesha.conf -L /var/log/ganesha.log -N NIV_DEBUG -p /var/run/ganesha/ganesha.pid