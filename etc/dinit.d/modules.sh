#!/bin/sh

[ -e /proc/modules ] || exit 0

case "${1}" in
    start)
	modules-load -v | tr '\n' ' ' | sed 's:insmod [^ ]*/::g; s:\.ko\(\.gz\)\? ::g'
        ;;
    *)
        echo "Usage: ${0} {start}"
        exit 1
        ;;
esac
