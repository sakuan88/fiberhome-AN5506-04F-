#!/bin/sh
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
MEM_SIZE=`grep '^MemTotal:' /proc/meminfo | awk '{ print $2 }'`

if [ $MEM_SIZE -gt 131072 ]
then
    echo 32000 > /proc/sys/net/ipv4/netfilter/ip_conntrack_max
else
    echo 17000 > /proc/sys/net/ipv4/netfilter/ip_conntrack_max
fi

echo 1 > /proc/sys/net/ipv4/ip_forward

#--------
# DRIVERS
#--------
echo "Starting drivers"

insmod /lib/modules/3.4.11-rt19/extra/wlcsm.ko 
# RDPA
insmod /lib/modules/3.4.11-rt19/extra/bdmf.ko bdmf_chrdev_major=215
insmod /lib/modules/3.4.11-rt19/extra/rdpa_gpl.ko 
insmod /lib/modules/3.4.11-rt19/extra/rdpa.ko 
 
insmod /lib/modules/3.4.11-rt19/extra/rdpa_mw.ko 
insmod /lib/modules/3.4.11-rt19/extra/bcmbrfp.ko 
# General
insmod /lib/modules/3.4.11-rt19/extra/chipinfo.ko 
insmod /lib/modules/3.4.11-rt19/extra/pktflow.ko 
# enet depends on moca depends on i2c
insmod /lib/modules/3.4.11-rt19/extra/i2c_bcm6xxx.ko 
#insmod /lib/modules/3.4.11-rt19/extra/bcm3450.ko 
insmod /lib/modules/3.4.11-rt19/extra/gpon_i2c.ko && echo gpon_i2c 0x50 > /sys/bus/i2c/devices/i2c-0/new_device && echo gpon_i2c 0x51 > /sys/bus/i2c/devices/i2c-0/new_device && echo gpon_i2c 0x52 > /sys/bus/i2c/devices/i2c-0/new_device
# Fiber home driver
#  Must load if use custom bcm_enet driver
insmod /lib/modules/3.4.11-rt19/extra/bcmgpon.ko skip_drv_init=1
insmod rdpa_upper.ko
insmod gpon_l2_init.ko
insmod gpon_l2_omci_drv.ko 

# Default driver

# Ok without this
# insmod /lib/modules/3.4.11-rt19/extra/laser_i2c.ko 

# Must load
insmod iomsg_drv.ko gmp_iomsg_dev_major=111 gmp_iomsg_dev_minor=1

# Fiberhome Custom bcm_enet
insmod bcm_enet.ko 

# Default bcm_enet driver, but wl0 DHCP will fltered
# insmod /lib/modules/3.4.11-rt19/extra/bcm_enet.ko 

# moving pktrunner after bcm_enet to get better FlowCache ICache performance
insmod /lib/modules/3.4.11-rt19/extra/pktrunner.ko 

# WLAN accelerator module
insmod /lib/modules/3.4.11-rt19/extra/wfd.ko 
 
#WLAN Module
insmod /lib/modules/3.4.11-rt19/extra/wlemf.ko 
insmod /lib/modules/3.4.11-rt19/extra/wl.ko 
insmod /lib/modules/3.4.11-rt19/extra/pcmshim.ko 
insmod /lib/modules/3.4.11-rt19/extra/endpointdd.ko 
 
#load usb modules
 
# other modules
 
#insmod /lib/modules/3.4.11-rt19/extra/bcmvlan.ko 
#insmod /lib/modules/3.4.11-rt19/extra/pwrmngtd.ko 
 
# insmod /lib/modules/3.4.11-rt19/extra/laser_dev.ko 
 
# presecure fullsecure modules
#insmod /lib/modules/3.4.11-rt19/extra/otp.ko 
#insmod /lib/modules/3.4.11-rt19/extra/pmd.ko 
 
# RDPA Command Drivers
insmod /lib/modules/3.4.11-rt19/extra/rdpa_cmd.ko 

#test -e /etc/rdpa_init.sh && /etc/rdpa_init.sh

#------------
# Network
#------------
echo -e "$YELLOW*** Setup Network (by Klampok Child) ***$NC"
delay=2
echo "CTRL+C to cancel. $delay second delay.."
echo "************************************************"
sleep $delay

# WAN
ifconfig eth0 up
udhcpc -s /etc/dhcp.wan -i eth0 &> /dev/null &


# LAN
brctl addbr br0
brctl addif br0 eth1
brctl addif br0 eth2
brctl addif br0 eth3
ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up
ifconfig br0 192.168.1.1 up
udhcpd /fhcfg/udhcpd.conf &


# WLAN
wl ssid testdev
wl up
ifconfig wl0 192.168.0.1 up
udhcpd /fhcfg/udhcpd-wlan.conf &
#dhcprelay wl0 br0 192.168.1.1 &


# Apps
vsftpd & 
#insmod $PWD/misc_drv.ko
# ./wifictl & 

# TODO packet routing from client still not work
iptables -A FORWARD -i eth0 -o wl0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i wl0 -o eth0 -j ACCEPT
iptables -A FORWARD -i br0 -o eth0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE