#!/bin/sh
export PATH=/usr/bin:/usr/sbin:/bin:/sbin
umask 0077

set -e

if [ "$1" != "stop" ]; then
  # cleanup
  rm -rf /tmp/* /tmp/.[!.]* /tmp/..?*

  install -m0664 -o root -g utmp /dev/null /run/utmp

  # Configure random number generator
  seedrng

  # Configure network
  ip link set up dev lo

  # set up hostname
  [ -r /etc/hostname ] && { read -r HOSTNAME < /etc/hostname || :; }
  if [ -n "$HOSTNAME" ]; then
    printf "%s" "$HOSTNAME" > /proc/sys/kernel/hostname
  fi

  # sysctl: must use -e
  if [ -x /sbin/sysctl -o -x /bin/sysctl ]; then
    mkdir -p /run/vsysctl.d
    for i in /run/sysctl.d/*.conf \
        /etc/sysctl.d/*.conf \
        /usr/local/lib/sysctl.d/*.conf \
        /usr/lib/sysctl.d/*.conf; do

        if [ -e "$i" ] && [ ! -e "/run/vsysctl.d/${i##*/}" ]; then
            ln -s "$i" "/run/vsysctl.d/${i##*/}"
        fi
    done
    for i in /run/vsysctl.d/*.conf; do
      sysctl -e -p "$i"
    done
    rm -rf -- /run/vsysctl.d
    sysctl -p /etc/sysctl.conf
  fi

else

  # The system is being shut down
  seedrng

fi;
