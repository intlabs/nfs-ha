FROM fedora:39

RUN dnf install -y  nfs-utils iproute iputils procps-ng

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

CMD /usr/local/bin/entrypoint.sh