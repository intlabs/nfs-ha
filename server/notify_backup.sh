#!/bin/bash
echo "$(date) backup" >> /tmp/state

kill $(cat /run/ganesha/ganesha.pid) || true

umount /srv