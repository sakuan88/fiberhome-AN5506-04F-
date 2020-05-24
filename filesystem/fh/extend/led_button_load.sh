#!/bin/sh
module="reset_led_button_drv"
device="reset_led_button_dev"
mode="664"

# invoke insmod with all arguments we got
# and use a pathname, as newer modutils don't look in . by default
/sbin/insmod /fh/extend/$module.ko $* || exit 1

# remove stale nodes
rm -f /dev/$device
major=`cat /proc/devices | awk "\\$2==\"$module\" {print \\$1}"`
mknod /dev/$device c $major 0
chmod $mode /dev/${device}


/fh/extend/buttonMonitor &
/fh/extend/load_usb_disk.sh
