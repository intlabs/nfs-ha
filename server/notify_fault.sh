#!/bin/bash
echo "$(date) fault" >> /tmp/state

kill $(cat /run/ganesha/ganesha.pid) || true

umount /srv