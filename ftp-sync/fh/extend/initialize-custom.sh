#This is the startup file of Fiberhome.

###############################
#       Parameters
###############################
APP_TYPE="RGW"
SECOND_PORT_TYPE="smii"
IS_GPON="1"
WAN_IF_PORT="0"
WAN_IF_NAME="wan"
KERNELVER=3.4.11-rt19
###############################
#test -e /lib/modules/3.4.11-rt19/extra/i2c_bcm6xxx.ko && insmod /lib/modules/3.4.11-rt19/extra/i2c_bcm6xxx.ko


export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/fh/extend/upnp

echo
echo "Press Ctrl + C to stop auto setup"
delay=1
while [ $delay -ge 0 ]
do
echo -ne "\r$delay"
sleep 1
delay=$(($delay-1))
done
echo

cd /fh/extend


source mk_cfg_dir.sh

source cp_cfg.sh

#F2=0x52(4GE+2POTS+WIFI) A3G=0x53(4GE) B3G=0x54(4GE+2POTS) B5=0x57

DEV=`cat /proc/driver/fh_hw_cfg | awk '{print $3}'`
echo "DEV=$DEV"

MEM_SIZE=`grep '^MemTotal:' /proc/meminfo | awk '{ print $2 }'`

if [ $MEM_SIZE -gt 131072 ]
then
    echo 32000 > /proc/sys/net/ipv4/netfilter/ip_conntrack_max
else
    echo 17000 > /proc/sys/net/ipv4/netfilter/ip_conntrack_max
fi

if [ ! -f /fhcfg/fh_pon/pon_type ]
then 
         echo "gpon">/fhcfg/fh_pon/pon_type 
fi

PONTYPE=`cat /fhcfg/fh_pon/pon_type | awk '{print $1}'`

echo "PONTYPE=$PONTYPE"

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
insmod /lib/modules/3.4.11-rt19/extra/bcm3450.ko 
#insmod /lib/modules/3.4.11-rt19/extra/gpon_i2c.ko && echo gpon_i2c 0x50 > /sys/bus/i2c/devices/i2c-0/new_device && echo gpon_i2c 0x51 > /sys/bus/i2c/devices/i2c-0/new_device
#insmod /lib/modules/3.4.11-rt19/extra/pmd.ko 
insmod /lib/modules/3.4.11-rt19/extra/bcmgpon.ko # skip_drv_init=1

insmod rdpa_upper.ko
insmod gpon_l2_init.ko
insmod gpon_l2_omci_drv.ko 
#insmod /lib/modules/3.4.11-rt19/extra/laser_i2c.ko 
insmod iomsg_drv.ko gmp_iomsg_dev_major=111 gmp_iomsg_dev_minor=1
insmod bcm_enet.ko 

# ---------------------------
# Network driver
# ---------------------------
brctl addbr br0 
#brctl addif br0 eth0
brctl addif br0 eth1
brctl addif br0 eth2
brctl addif br0 eth3
ifconfig eth0 up
ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up

ifconfig br0 up

#ip a add 192.168.2.222/24 dev eth0
# todo: auto add route
udhcpcforwan -i eth0 &
sleep 2
ip route add default via 192.168.2.1

/fh/extend/tr069/bin/runTr069

./runWeb.sh

#WLAN Module
insmod /lib/modules/3.4.11-rt19/extra/wfd.ko 
insmod /lib/modules/3.4.11-rt19/extra/wlemf.ko 
insmod /lib/modules/3.4.11-rt19/extra/dhd.ko firmware_path=/etc/wlan/dhd mfg_firmware_path=/etc/wlan/dhd/mfg
insmod /lib/modules/3.4.11-rt19/extra/wl.ko 
insmod /lib/modules/3.4.11-rt19/extra/pcmshim.ko 
insmod /lib/modules/3.4.11-rt19/extra/endpointdd.ko 
# todo: start wifi
#./wifictl &   