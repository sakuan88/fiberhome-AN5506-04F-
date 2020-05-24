#!/bin/sh
module="misc_drv"
device="misc_dev"
mode="664"

cdd=$PWD
# Group: since distributions do it differently, look for wheel or use staff
if grep '^staff:' /etc/group > /dev/null; then
   group="staff"
else
   group="wheel"
fi

# invoke insmod with all arguments we got
# and use a pathname, as newer modutils don't look in . by default
/sbin/insmod /fh/extend/$module.ko $* || exit 1

# remove stale nodes
rm -f /dev/$device

major=`cat /proc/devices | awk "\\$2==\"$module\" {print \\$1}"`

mknod /dev/$device c $major 0

# give appropriate group/permissions
#chgrp $group /dev/${device}
chmod $mode  /dev/${device}
