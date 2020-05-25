# Customize Firmware Fiberhome AN5506-04F 

    Modem Indihome Jadul

## Root Access via UART/Serial (First Oprek)

- Colokin aja USB TTL di board ada tandanya kok `tx,rx,gnd`
- Pass ada tulisan 'CTR-C', pencet aja. nanti masuk root shell sblm system boot
- jalankan: `telnetd -l /bin/sh`
- lalu `initialize.sh` biar proses boot berlanjut
- sekarang bisa konek root via `telnet 192.168.1.1` (autologin root tanpa password)

## Script Oprek

Sebelum jalanin script oprek, pastikan partisi sudah di **remount rw**

``` bash
# remount rw fh_extend
mount -o remount,rw /fh/extend
mount -o remount,rw /

# Change root password
sed -i 's/"root:.\+\?"/"root:B7AIKYar5C1XQ:0:0:root:\/:bin\/sh"/' /fs/extend/mount-fs.sh

# Root Shell on UART
sed -i 's/\/fh\/extend\/load_cli$/#&/' /fh/extend/initialize.sh

# Root Shell via telnetd
echo "telnetd -l /bin/sh >> /fh/extend/userapp.sh"

# Custom init from USB
cat <<EOF > /fh/extend/userapp.sh
#!/bin/sh
telnetd -l /bin/sh
if \$(cat /proc/diskstats | grep sda &>/dev/null); then
    echo "Found USB Storage, mount to /mnt"
    mount /dev/sda1 /mnt
    if [ -x /mnt/initialize.sh ]; then
        exec /mnt/initialize.sh
    else
        echo "Not found initialize.sh in USB Storage!"
        umount /mnt
    fi
else
    echo "initialize.sh=="
    #/fh/extend/initialize.sh
fi
EOF

```

## JIKA BRICKED

Jika mengalami salah edit filesystem sehingga linux/busybox init tidak mau booting, 
maka masih ada cara mudah untuk menanganinya. yaitu dengan boot menggunakan partisi backup/previous.
Caranya:

- Colokan USB TTL
- Nyalakan Router, pas ada promp "Press Enter" tekan enter 1 kali
- Anda akan masuk ke U-Boot CVE promp. ketikan `help` untuk list command
- ketikan `c` (Change booline parameters)
- untuk nilai yg tidak diubah, cukup tekan `enter`
- ubah pada bagian Boot image/App basic/App extend tergantung partisi mana yg filenya problem.
- reboot

## ftp-sync

Use sublime-text with SFTP Plugin
```
sed 's/^local_root\=.*/local_root=\//' /fhcfg/vsftpd.conf
killall vsftpd
vsftpd
```

## Mounting JFFS2 Big-Endian

    Cek di folder `filesystem/*` sebelum mounting jffs2 di pc anda, mungkin file yg anda cari sudah ada disitu.

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
system type     : AN5506-04FG
processor       : 0
cpu model       : Broadcom BMIPS4350 V8.0
BogoMIPS        : 598.01
wait instruction    : yes
microsecond timers  : yes
tlb_entries     : 32
extra interrupt vector  : no
hardware watchpoint : no
ASEs implemented    :
shadow register sets    : 1
kscratch registers  : 0
core            : 0
VCED exceptions     : not available
VCEI exceptions     : not available

processor       : 1
cpu model       : Broadcom BMIPS4350 V8.0
BogoMIPS        : 606.20
wait instruction    : yes
microsecond timers  : yes
tlb_entries     : 32
extra interrupt vector  : no
hardware watchpoint : no
ASEs implemented    :
shadow register sets    : 1
kscratch registers  : 0
core            : 0
VCED exceptions     : not available
VCEI exceptions     : not available
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

## MTD INFO
Boot with latest partition
```
Creating 8 MTD partitions on "brcmnand.0":
0x000000020000-0x000001480000 : "rootfs"
0x000001480000-0x0000028e0000 : "rootfs_update"
0x0000028e0000-0x000003d40000 : "app_basic"
0x000003d40000-0x0000051a0000 : "app_basic_update"
0x0000051a0000-0x000006600000 : "app_extend"
0x000006600000-0x000007a60000 : "app_extend_update"
0x000007a60000-0x000007f00000 : "data"
0x000000000000-0x000000020000 : "nvram"
```

Boot with backup previous partition
```
0x000001480000-0x0000028e0000 : "rootfs"
0x000000020000-0x000001480000 : "rootfs_update"
0x000003d40000-0x0000051a0000 : "app_basic"
0x0000028e0000-0x000003d40000 : "app_basic_update"
0x000006600000-0x000007a60000 : "app_extend"
0x0000051a0000-0x000006600000 : "app_extend_update"
0x000007a60000-0x000007f00000 : "data"
0x000000000000-0x000000020000 : "nvram"
```