#!/bin/bash
set -ex
rpc.statd &
rpcbind -f &
mount -t "nfs" -o "nfsvers=3" "172.18.0.100:/srv" "/srv"
mount | grep "/srv"
#bash -c "while true; do date >> /srv/date; sleep 1 ; done" &
exec bash
#dd bs=1 count=10000000 oflag=dsync if=/dev/random of=/srv/hey4 status=progress
#dd bs=1 count=10000000 iflag=dsync if=/srv/hey4 of=/dev/null status=progress