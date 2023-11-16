#!/bin/bash
set -x
for x in $(seq 1 3); do
    echo "nfs-${x}"
    docker exec "nfs-${x}" cat /tmp/state
    docker top "nfs-${x}" | grep ganesha.nfsd
    # if [ $? -eq 0 ]; then
    #     echo "ganesha.nfsd is running"
    #      docker exec "nfs-${x}" tail -f /var/log/ganesha.log
    # else
    #     echo "ganesha.nfsd is not running"
    # fi
done

