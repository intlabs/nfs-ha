FROM fedora:39

RUN dnf install -y nfs-ganesha keepalived procps-ng iproute iputils jq dbus-daemon nfs-ganesha-vfs e2fsprogs nfs-ganesha-utils

CMD /usr/local/bin/entrypoint.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY check_connectivity.sh /usr/local/bin/check_connectivity.sh
COPY notify_backup.sh /usr/local/bin/notify_backup.sh
COPY notify_fault.sh /usr/local/bin/notify_fault.sh
COPY notify_master.sh /usr/local/bin/notify_master.sh

COPY ganesha.conf /etc/ganesha/ganesha.conf
#BUILD docker build . -t soulard.azurecrio.io/nfs-ganesha-keepalived:latest