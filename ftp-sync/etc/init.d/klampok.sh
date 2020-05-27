#!/bin/sh

trap "" 2

case "$1" in
    start)
        ;;

    stop)
        killall vsftpd udhcpd udhcpc telnet
        ;;
esac

