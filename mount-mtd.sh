#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 mtd-file-name"
    exit 1
fi

if [ "$(whoami)" != "root" ]; then
    exec sudo "$*"
    exit 1
fi

if [ ! -e $1 ]; then
    echo "$1 does not exist"
    exit 1
fi
MOUNT="$2"
if [ -z $MOUNT ]; then
    MOUNT="$PWD/mount"
fi
if [ ! -d $MOUNT ]; then
    echo "Creating dir $MOUNT"
    mkdir -m 0777 $MOUNT
fi

let "ERASE_SIZE=131072/1024"
let "TOTAL_SIZE=21364736/1024"

# mtd0: 01460000 (21364736) 00020000 (131072) "rootfs"
# mtd1: 01460000 (21364736) 00020000 (131072) "rootfs_update"
# mtd2: 01460000 (21364736) 00020000 (131072) "app_basic"
# mtd3: 01460000 (21364736) 00020000 (131072) "app_basic_update"
# mtd4: 01460000 (21364736) 00020000 (131072) "app_extend"
# mtd5: 01460000 (21364736) 00020000 (131072) "app_extend_update"
# mtd6: 004a0000 (4849664 ) 00020000 (131072) "data"
# mtd7: 00020000 (131072)   00020000 (131072) "nvram"

# cleanup
umount /dev/mtdblock0 &>/dev/null
modprobe -r mtdram
modprobe -r mtdblock

modprobe mtdram total_size=$TOTAL_SIZE erase_size=$ERASE_SIZE || exit 1
modprobe mtdblock || exit 1
dd if="$1" of=/dev/mtdblock0 || exit 1
mount -t jffs2 /dev/mtdblock0 $MOUNT || exit 1
echo "Mounted $1 on $2"
