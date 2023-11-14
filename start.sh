#!/bin/bash

# Build the Docker image
docker build . -t soulard.azurecrio.io/nfs-ganesha-keepalived:latest

# Create the Docker network with a defined subnet
docker network create --subnet=172.18.0.0/16 nfs-ha


docker rm -f nfs-1 nfs-2 nfs-3

# Start the first container with a fixed IP address
docker run -d --name nfs-1 --network nfs-ha --cap-add=NET_ADMIN --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH --sysctl net.ipv4.ip_nonlocal_bind=1 --ip 172.18.0.2 \
-v /srv/nfs-1:/srv:rw soulard.azurecrio.io/nfs-ganesha-keepalived:latest

# Start the second container with a fixed IP address
docker run -d --name nfs-2 --network nfs-ha --cap-add=NET_ADMIN --sysctl net.ipv4.ip_nonlocal_bind=1 --ip 172.18.0.3 -v /srv/nfs-2:/srv:rw soulard.azurecrio.io/nfs-ganesha-keepalived:latest

# Start the second container with a fixed IP address
docker run -d --name nfs-3 --network nfs-ha --cap-add=NET_ADMIN --sysctl net.ipv4.ip_nonlocal_bind=1 --ip 172.18.0.4 -v /srv/nfs-3:/srv:rw soulard.azurecrio.io/nfs-ganesha-keepalived:latest

exit 0
ganesha.nfsd -L /dev/stdout -f /etc/ganesha/ganesha.conf -F

