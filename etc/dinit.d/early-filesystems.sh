#!/bin/sh

set -e

if [ "$1" = start ]; then

    PATH=/usr/bin:/usr/sbin:/bin:/sbin

    # todo: cgroup v2

    mountpoint -q /proc || mount -o nosuid,noexec,nodev -t proc proc /proc
    mountpoint -q /sys || mount -o nosuid,noexec,nodev -t sysfs sys /sys
    mountpoint -q /run || mount -o mode=0755,nosuid,nodev -t tmpfs run /run
    mountpoint -q /dev || mount -o mode=0755,nosuid -t devtmpfs dev /dev
    mountpoint -q /dev/pts || mount -o mode=0620,gid=5,nosuid,noexec -n -t devpts devpts /dev/pts
    mountpoint -q /dev/shm || mount -o mode=1777,nosuid,nodev -n -t tmpfs shm /dev/shm
    mountpoint -q /sys/kernel/security || mount -n -t securityfs securityfs /sys/kernel/security

fi
