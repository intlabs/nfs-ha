#!/bin/bash

# Build the Docker image
docker build ./server -t soulard.azurecrio.io/nfs-ganesha-keepalived:latest

# Create the Docker network with a defined subnet
docker network create --subnet=172.18.0.0/16 nfs-ha

docker rm -f nfs-1 nfs-2 nfs-3

sudo mknod "/dev/loop0" b 7 0 || true
sudo losetup -d "/dev/loop0" || true
dd if=/dev/zero of=/tmp/nfs-disk bs=1M count=100
sudo losetup "/dev/loop0" /tmp/nfs-disk 
sudo mkfs.ext4 "/dev/loop0" 

# Start the first container with a fixed IP address
docker run -d --name nfs-1 --hostname nfs-1 --network nfs-ha --privileged=true --cap-add=NET_ADMIN --sysctl net.ipv4.ip_nonlocal_bind=1 -v /dev:/dev:rw --ip 172.18.0.2 soulard.azurecrio.io/nfs-ganesha-keepalived:latest

# Start the second container with a fixed IP address
docker run -d --name nfs-2 --hostname nfs-2 --network nfs-ha --privileged=true --cap-add=NET_ADMIN --sysctl net.ipv4.ip_nonlocal_bind=1 -v /dev:/dev:rw --ip 172.18.0.3 soulard.azurecrio.io/nfs-ganesha-keepalived:latest

# Start the second container with a fixed IP address
docker run -d --name nfs-3 --hostname nfs-3 --network nfs-ha --privileged=true --cap-add=NET_ADMIN --sysctl net.ipv4.ip_nonlocal_bind=1 -v /dev:/dev:rw --ip 172.18.0.4 soulard.azurecrio.io/nfs-ganesha-keepalived:latest

exit 0


docker build ./client -t soulard.azurecrio.io/nfs-client:latest

docker run -it --rm --name nfs-client --hostname nfs-client --network nfs-ha --ip 172.18.0.64 --privileged=true soulard.azurecrio.io/nfs-client:latest

ganesha.nfsd -L /dev/stdout -f /etc/ganesha/ganesha.conf -F


for x in $(seq 1 3); do
    echo "nfs-${x}"
    docker top "nfs-${x}" | grep ganesha.nfsd
    docker exec "nfs-${x}" cat /tmp/state
done

