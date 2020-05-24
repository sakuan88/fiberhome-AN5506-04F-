#!/bin/sh

# init web_log  directory 
if [ ! -d /fhcfg/web_log  ];then 
echo " no /fhcfg/web_log " 
mkdir /fhcfg/web_log 
fi

echo "run web server"
chmod 700 webs
./webs -L 3 -M 1 -S 100 -m all &

