#!/bin/bash

# This script shoud live here : /usr/lib/systemd/system-sleep/


# Will target all CPUs exept the cpu0 (needed for boot,resume)

switch_cpu () {
    for cpu in $(ls /sys/devices/system/cpu | grep -E -i 'cpu[1-9][0-9]?'); do
      echo $1 > /sys/devices/system/cpu/$cpu/online;
    done
}

echo "fix macbook wakeup"
case "$1/$2" in
  pre/*)
    echo "going to $2..."       
    switch_cpu 0        
    ;;
  post/*)
    echo "waking up from $2..."
    switch_cpu 1
   ;;
esac

# Thanks to theses 2 posts for the answer !!
# https://discussion.fedoraproject.org/t/wake-up-from-suspend-takes-4-minutes/82194/7
# https://discussion.fedoraproject.org/t/disabling-cpu-before-suspend-and-enabling-it-after-wake-up/81890/10
