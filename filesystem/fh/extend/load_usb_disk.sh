#!/bin/sh

# zhengming@FiberHome, 2014-11-07
# Loading USB Disk


mkdir -p /dev/shm/usb

USB_DISKS=`find /sys/devices/ -name '*sd[a-z][0-9]' | grep 'pci.*usb'`
USB_DEVS=`find /sys/devices/ -name '*sd[a-z]' | grep 'pci.*usb'`
 
for f in $USB_DISKS $USB_DEVS
do
    ACTION=add DEVPATH="$f" /bin/hotplug block
done

echo "/bin/hotplug" > /proc/sys/kernel/hotplug
