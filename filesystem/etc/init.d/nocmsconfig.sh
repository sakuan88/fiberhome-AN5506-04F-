#!/bin/sh

case "$1" in
	start)
		echo "Assigning ip address to br0 "
		brctl addbr br0
		brctl stp br0 off
		brctl setfd br0 0
		sendarp -s br0 -d br0
		ifconfig br0 up
		ifconfig br0 192.168.1.1 netmask 255.255.255.0 broadcast 192.168.1.255 up
		brctl addif br0 eth0
		ifconfig eth0 up
		ifconfig eth0 0.0.0.0
		sendarp -s br0 -d br0
		sendarp -s br0 -d eth0
		
		exit 0
		;;

	stop)
		echo "No stop for nocmsconfig"
		exit 1
		;;

	*)
		echo "$0: unrecognized option $1"
		exit 1
		;;

esac

