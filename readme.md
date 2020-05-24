# Customize Firmware Fiberhome AN5506-04F 

	Modem Indihome Jadul

## Root Access via UART/Serial

- Colokin aja USB TTL di board ada tandanya kok `tx,rx,gnd`
- Pass ada tulisan 'CTR-C', pencet aja. nanti masuk root shell sblm system boot
- Modif script utk menjalankan telnetd:
	
	```
	mount -o remount,rw /fh/extend
	echo "telnetd -l /bin/sh >> userapps.sh"
	mount -o remount,ro /fh/extend
	reboot
	```
- sekarang bisa konek root via `telnet 192.168.1.1`

## Mounting JFFS2 Big-Endian

Convert JFFS2 big endian to little
```
jffs2dump -b -c -r -e mtd-little/rootfs mtd-ori/rootfs
jffs2dump -b -c -r -e mtd-little/app_extend mtd-ori/app_extend
jffs2dump -b -c -r -e mtd-little/data mtd-ori/data
```

Mount it:
```
sudo ./mount-mtd.sh mtd-little/rootfs
sudo ./mount-mtd.sh mtd-little/app_extend
sudo ./mount-mtd.sh mtd-little/data
```

## System Information

```
# cat /proc/cpuinfo 
system type		: AN5506-04FG
processor		: 0
cpu model		: Broadcom BMIPS4350 V8.0
BogoMIPS		: 598.01
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: no
hardware watchpoint	: no
ASEs implemented	:
shadow register sets	: 1
kscratch registers	: 0
core			: 0
VCED exceptions		: not available
VCEI exceptions		: not available

processor		: 1
cpu model		: Broadcom BMIPS4350 V8.0
BogoMIPS		: 606.20
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: no
hardware watchpoint	: no
ASEs implemented	:
shadow register sets	: 1
kscratch registers	: 0
core			: 0
VCED exceptions		: not available
VCEI exceptions		: not available
```

```
# cat /proc/mtd 
dev:    size   erasesize  name
mtd0: 01460000 00020000 "rootfs"
mtd1: 01460000 00020000 "rootfs_update"
mtd2: 01460000 00020000 "app_basic"
mtd3: 01460000 00020000 "app_basic_update"
mtd4: 01460000 00020000 "app_extend"
mtd5: 01460000 00020000 "app_extend_update"
mtd6: 004a0000 00020000 "data"
mtd7: 00020000 00020000 "nvram"
```

```
# mount
rootfs on / type rootfs (rw)
mtd:rootfs on / type jffs2 (ro,relatime)
proc on /proc type proc (rw,relatime)
tmpfs on /dev type tmpfs (rw,relatime)
tmpfs on /var type tmpfs (rw,relatime,size=420k)
tmpfs on /mnt type tmpfs (rw,relatime,size=16k)
sysfs on /sys type sysfs (rw,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
mtd:app_basic on /fh/bin type jffs2 (ro,relatime)
mtd:app_extend on /fh/extend type jffs2 (ro,relatime)
mtd:data on /fhcfg type jffs2 (rw,relatime)
devpts on /dev/pts type devpts (rw,relatime,mode=620,ptmxmode=000)
```
