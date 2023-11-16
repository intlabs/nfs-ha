#!/bin/bash
set -ex
docker build ./client -t soulard.azurecrio.io/nfs-client:latest
docker run -it --rm --name nfs-client --hostname nfs-client --network nfs-ha --ip 172.18.0.64 --privileged=true soulard.azurecrio.io/nfs-client:latest

exit 0

ganesha.nfsd -L /dev/stdout -f /etc/ganesha/ganesha.conf -F


for x in $(seq 1 3); do
    echo "nfs-${x}"
    docker top "nfs-${x}" | grep ganesha.nfsd
    docker exec "nfs-${x}" cat /tmp/state
done

