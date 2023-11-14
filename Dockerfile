FROM fedora:39

RUN dnf install -y nfs-ganesha keepalived procps-ng iproute iputils jq dbus-daemon nfs-ganesha-vfs

CMD /usr/local/bin/entrypoint.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY check_connectivity.sh /usr/local/bin/check_connectivity.sh


COPY ganesha.conf /etc/ganesha/ganesha.conf
#BUILD docker build . -t soulard.azurecrio.io/nfs-ganesha-keepalived:latest