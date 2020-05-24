#!/bin/sh

# 2011-09-08, zhengming@FiberHome, create it.
# The script do two things
# 1 mkdir /dev/shm/fh_ver_tmp/, the dir is used for file lock.
# 2 Get Version of Kernel Modules and output to File: /dev/shm/fh_version_ko
# NOTE: the Directory /dev/shm/ is mount tmpfs.

KOLIST=$(ls /sys/module/)

if [ ! -d /dev/shm/fh_ver_tmp ]
then
	rm -rf /dev/shm/fh_ver_tmp
	mkdir /dev/shm/fh_ver_tmp
fi


rm -rf /dev/shm/fh_version_ko

for ko in $KOLIST
do
	if [ -f /sys/module/$ko/parameters/fh_moduler_version ]
	then
		cat /sys/module/$ko/parameters/fh_moduler_version >> /dev/shm/fh_version_ko
	fi
done
