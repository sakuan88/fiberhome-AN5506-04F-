#!/bin/sh

trap "" 2
PIDFILE="/data/dhcp-wan.pid"
case "$1" in
	start)
        echo "Setup Network (by Klampok Child)"
		echo "Starting DHCPC Wan"
        udhcpc -s /etc/dhcp.wan -i eth0 -p $PIDFILE
		exit 0
		;;

	stop)
		echo "Stoping DHCP-WAN"
        if [ -e $PIDFILE ]; then
            kill $(cat $PIDFILE)
        fi
		exit 0
		;;
esac

