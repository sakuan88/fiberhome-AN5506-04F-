
# zhengming@FiberHome, 2011-11-15.
# mkdir for Config Files.


if [ ! -f /fhcfg/ppp/chap-secrets ]
then 
        cp -f /fh/extend/chap-secrets /fhcfg/ppp
fi

if [ ! -f /fhcfg/ppp/chap-secrets-bak ]
then
        cp -f /fh/extend/chap-secrets-bak /fhcfg/ppp
fi

if [ ! -f /fhcfg/ppp/ip-down ]
then
        cp -f /fh/extend/ip-down /fhcfg/ppp
fi

if [ ! -f /fhcfg/ppp/ip-up ]
then
        cp -f /fh/extend/ip-up /fhcfg/ppp
fi


if [ ! -f /fhcfg/ppp/options ]
then
        cp -f /fh/extend/options /fhcfg/ppp
fi

if [ ! -f /fhcfg/ppp/pap-secrets ]
then
        cp -f /fh/extend/pap-secrets /fhcfg/ppp
fi

if [ ! -f /fhcfg/pppoe.conf ]
then 
        cp -f /fh/extend/pppoe.conf /fhcfg
fi

if [ ! -f /fhcfg/pppoe1.conf ]
then 
        cp -f /fh/extend/pppoe1.conf /fhcfg
fi

if [ ! -f /fhcfg/pppoe2.conf ]
then 
        cp -f /fh/extend/pppoe2.conf /fhcfg
fi

if [ ! -f /fhcfg/pppoe3.conf ]
then 
        cp -f /fh/extend/pppoe3.conf /fhcfg
fi

if [ ! -f /fhcfg/pppoe4.conf ]
then 
        cp -f /fh/extend/pppoe4.conf /fhcfg
fi

if [ ! -f /fhcfg/pppoe5.conf ]
then 
        cp -f /fh/extend/pppoe5.conf /fhcfg
fi

if [ ! -f /fhcfg/pppoe6.conf ]
then 
        cp -f /fh/extend/pppoe6.conf /fhcfg
        
fi

if [ ! -f /fhcfg/pppoesim.conf ]
then 
        cp -f /fh/extend/pppoesim.conf /fhcfg/
fi

#add for xiaobp, liantong version
if [ -f /fh/extend/omci.conf ]
then
        cp -f /fh/extend/omci.conf /fhcfg
fi

if [ ! -f /fhcfg/voip.conf ]
then 
echo "copy voip.conf ====="
        cp -f /fh/extend/voip.conf /fhcfg
fi

if [ ! -f /fhcfg/dhcpc.script ]
then 
        cp -f /fh/extend/dhcpc.script /fhcfg/
fi



if [ ! -f /fhcfg/l3_def/udhcpd.conf ]
then 
echo "copy udhcpd.conf ====="
        cp -f /fh/extend/udhcpd.conf /fhcfg/l3_def/
fi

if [ ! -f /fhcfg/fh_wifi/regdomain ]
then 
	cp -f /fh/extend/regdomain /fhcfg/fh_wifi/
fi

if [ -f /fhcfg/hgu.conf ]
then 
	rm -f /fhcfg/hgu.conf
	echo "sfu">/fhcfg/sfu.conf
		
	rm -f /fhcfg/mas_cfg.xml
	rm -f /fhcfg/mas_cfg2.xml
	rm -f /fhcfg/wan_service_omci.cfg
	rm -f /fhcfg/wan_service_tr069.cfg
	rm -f /fhcfg/tr069_config_version	
	rm -f /fhcfg/wan_service_tr069.dat
fi

if [ ! -f /fhcfg/sfu.conf ]
then 
	echo "sfu">/fhcfg/sfu.conf
fi
