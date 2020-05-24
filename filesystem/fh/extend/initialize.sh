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

if  [ $PONTYPE == "epon" ] 
then 
     /sbin/insmod /lib/modules/3.4.11-rt19/extra/epon_stack.ko epon_usr_init=1 epon_read_pers=1
fi

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
insmod /lib/modules/3.4.11-rt19/extra/gpon_i2c.ko && echo gpon_i2c 0x50 > /sys/bus/i2c/devices/i2c-0/new_device && echo gpon_i2c 0x51 > /sys/bus/i2c/devices/i2c-0/new_device
#insmod /lib/modules/3.4.11-rt19/extra/pmd.ko 
insmod /lib/modules/3.4.11-rt19/extra/bcmgpon.ko skip_drv_init=1

cd /fh/extend
insmod rdpa_upper.ko
insmod gpon_l2_init.ko
insmod gpon_l2_omci_drv.ko 
insmod /lib/modules/3.4.11-rt19/extra/laser_i2c.ko 
insmod iomsg_drv.ko gmp_iomsg_dev_major=111 gmp_iomsg_dev_minor=1
insmod bcm_enet.ko 
# moving pktrunner after bcm_enet to get better FlowCache ICache performance
insmod /lib/modules/3.4.11-rt19/extra/pktrunner.ko 

brctl addbr br0 

insmod pon_l2_driver.ko
insmod pon_l2_config.ko
 
#load SATA/AHCI modules
 
# pcie configuration save/restore
# WLAN accelerator module
insmod /lib/modules/3.4.11-rt19/extra/wfd.ko 
 
#WLAN Module
insmod /lib/modules/3.4.11-rt19/extra/wlemf.ko 
insmod /lib/modules/3.4.11-rt19/extra/dhd.ko firmware_path=/etc/wlan/dhd mfg_firmware_path=/etc/wlan/dhd/mfg
insmod /lib/modules/3.4.11-rt19/extra/wl.ko 
insmod /lib/modules/3.4.11-rt19/extra/pcmshim.ko 
insmod /lib/modules/3.4.11-rt19/extra/endpointdd.ko 
#load usb modules
 
# other modules
 
#insmod /lib/modules/3.4.11-rt19/extra/bcmvlan.ko 
#insmod /lib/modules/3.4.11-rt19/extra/pwrmngtd.ko 

#insmod /lib/modules/3.4.11-rt19/extra/laser_dev.ko 
 
# presecure fullsecure modules
#insmod /lib/modules/3.4.11-rt19/extra/otp.ko 

#insmod /lib/modules/3.4.11-rt19/extra/pmd.ko 
 
# RDPA Command Drivers
insmod /lib/modules/3.4.11-rt19/extra/rdpa_cmd.ko 
 
# OCF and PKA modules

#LTE PCIE driver module
# test -e /etc/rdpa_init.sh && /etc/rdpa_init.sh


# Enable the PKA driver.
# test -e /sys/devices/platform/bcm_pka/enable && echo 1 > /sys/devices/platform/bcm_pka/enable



######################################
#       start app
######################################
bdmf_shell -c init | while read a b ; do echo $b ; done > /var/bdmf_sh_id
/fh/extend/misc_load.sh
/fh/extend/led_button_load.sh
bs /bdmf/hist/init 0x20000 on

cd /fh/extend
mknod /dev/fh_omci c 254 0
mknod /dev/iomsg c 111 1

cd /fh/extend
#insmod /fh/extend/opt_driver.ko
insmod /fh/extend/i2cdev.ko

ifconfig eth0 down


# ---------------------------
# Network driver
# ---------------------------
brctl addif br0 eth0
brctl addif br0 eth1
brctl addif br0 eth2
brctl addif br0 eth3
ifconfig eth0 up
ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up

brctl addif br0 wan

ifconfig wan up
ifconfig br0 up
ifconfig tel0 up
ifconfig voip0 up
ifconfig voip2 up
ifconfig wan0 up
ifconfig wan1 up
ifconfig wan2 up
ifconfig wan3 up
ifconfig tr0 up

fc config --gre 2

#add for clear after software upgrade
if [ -f /fhcfg/extend/delete_flag_after_update ]
then
        echo "/fhcfg/cpepatch/use_flag_after_update existed"
        if [ -f /fhcfg/cpepatch/use_edit_boot ]
        then
                rm -f /fhcfg/cpepatch/use_edit_boot
                echo " clear use_edit_boot ...\n"
        fi
        if [ -d /fhcfg/extend/dhcpforwan ]
        then 
                rm -rf /fhcfg/extend/dhcpforwan/*
                echo "clear /fhcfg/extend/dhcpforwan/* ..."
        fi
        rm -f /fhcfg/extend/delete_flag_after_update
        echo " /fhcfg/extend/delete_flag_after_update clear "
fi

if [ -f /fh/extend/boot_version_control ]
then
        if [ ! -f /fhcfg/cpepatch/use_edit_boot ]
        then
                echo "not use_edit_boot existed ...\n"
                cp -f /fh/extend/boot_version_control /fhcfg/cpepatch
        else
                echo "use_edit_boot exited ...\n"
        fi
fi

./wifictl &                                                                                        
sleep 1   

./l3mng &

./dhcpl2 &

./onu_igmpv3 & 

echo "Start SIP"
./sip voip0 voip0:0 - voip2 &

/fh/bin/fh_ver_export.sh

cd /fh/extend
./rm_init.exe



#./dmz-init 
./pppoeManage &

sleep 2


echo "./fh_printf_redirect.sh"
source fh_printf_redirect.sh


if [ $PONTYPE == "epon" ]
then 
        echo "epon"
        /fh/extend/epon_oam
elif [ $PONTYPE == "gpon" ]
then
        echo "gpon"
        ./load_omci &
else 
        echo "default, gpon"
#20140217, xiaoj add
        ./load_omci &
fi


/fh/extend/tr069/bin/runTr069

./runWeb.sh

#./l3getip &

#add upnp startup,2012.09.10
cd /fh/extend/upnp
./upnp-init &
cd /fh/extend
./ntpclient &


echo 1 > /proc/sys/net/net_debug/net_debug  


echo 1 > /proc/sys/kernel/printk_with_interrupt_enabled 

cd /fh/extend
/fh/extend/watchdog -c /fh/extend/watchdog.conf &
/fh/extend/load_cli
