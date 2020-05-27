#!/bin/sh

echo "Setup Network (by Klampok Child)"
brctl addbr br0 
sleep 1
echo 1 > /proc/sys/net/ipv4/ip_forward

#brctl addif br0 eth0
brctl addif br0 eth1
brctl addif br0 eth2
brctl addif br0 eth3
brctl addif br0 wl0
#ifconfig eth0 up
ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up
ifconfig wl0 up
ifconfig br0 up
ifconfig br0 192.168.1.1
udhcpd /fhcfg/udhcpd.conf &

#WAN
brctl addbr wan
brctl addif wan eth0
ifconfig eth0 up
ifconfig wan up
echo "Starting DHCPC Wan"
udhcpc -s /etc/dhcp.wan -i wan &

#insmod $PWD/misc_drv.ko
# ./wifictl & 

# Wlan
# ifconfig wl0 192.168.0.1 up
# udhcpd /fhcfg/udhcpd-wlan.conf &

wlctl ssid "MYWIFI"
#wlctl up

# telnet root (danger)
telnetd -l /bin/sh
vsftpd &
# Wifi

# Web Management
# [ -d /fhcfg/web_log  ] || mkdir /fhcfg/web_log
# webs -L 3 -M 1 -S 100 -m all &

