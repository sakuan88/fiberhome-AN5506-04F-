#!/bin/sh

# zhengming@FiberHome, 2011-11-15.
# mkdir for Config Files.

if [ ! -d /fhcfg ]
then
        rm -rf /fhcfg
        mkdir /fhcfg
fi

if [ ! -d /fhcfg/fh_wifi ]
then
        rm -rf /fhcfg/fh_wifi
        mkdir /fhcfg/fh_wifi
fi

if [ ! -d /fhcfg/fh_pon ]
then
        rm -rf /fhcfg/fh_pon
        mkdir /fhcfg/fh_pon
fi

#xiaoj add
if [ ! -d /fhcfg/cpepatch ]
then
        rm -rf /fhcfg/cpepatch
        mkdir /fhcfg/cpepatch
fi

if [ ! -d /fhcfg/l3_def ]
then
        rm -rf /fhcfg/l3_def
        mkdir /fhcfg/l3_def
fi

if [ ! -d /fhcfg/ppp/ ]
then
        rm -rf /fhcfg/ppp
	mkdir -p /fhcfg/ppp
fi

if [ ! -d  /fhcfg/extend/dhcpforwan ]
then
	rm -rf /fhcfg/extend/dhcpforwan
	mkdir -p /fhcfg/extend/dhcpforwan
fi