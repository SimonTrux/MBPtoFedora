#!/bin/sh

# This script shoud live here : /usr/lib/systemd/system-sleep/

echo "fix macbook wakeup"
case "$1/$2" in
  pre/*)
    echo "going to $2..."       

    echo 0 > /sys/devices/system/cpu/cpu1/online
    echo 0 > /sys/devices/system/cpu/cpu2/online
    echo 0 > /sys/devices/system/cpu/cpu3/online
    echo 0 > /sys/devices/system/cpu/cpu4/online
    echo 0 > /sys/devices/system/cpu/cpu5/online
    echo 0 > /sys/devices/system/cpu/cpu6/online
    echo 0 > /sys/devices/system/cpu/cpu7/online
    ;;
  post/*)
    echo "waking up from $2..."
    echo 1 > /sys/devices/system/cpu/cpu1/online
    echo 1 > /sys/devices/system/cpu/cpu2/online
    echo 1 > /sys/devices/system/cpu/cpu3/online
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo 1 > /sys/devices/system/cpu/cpu5/online
    echo 1 > /sys/devices/system/cpu/cpu6/online
    echo 1 > /sys/devices/system/cpu/cpu7/online
    ;;
esac
