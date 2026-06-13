#!/bin/sh

set -e

if [ "$1" = start ]; then

    PATH=/usr/bin:/usr/sbin:/bin:/sbin

    # /run is already mounted by the initramfs
    #mount -n -t tmpfs -o mode=775 tmpfs /run
    ##mountpoint -q /run || mount -o mode=0755,nosuid,nodev -t tmpfs run /run
    ##mkdir /run/lock /run/udev
    # "hidepid=1" not sure
    # mount -n -t proc -o remount,hidepid=1 proc /proc

fi
