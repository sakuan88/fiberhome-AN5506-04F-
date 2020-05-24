DEVICE_NAME=$1
echo ${DEVICE_NAME}
ISP_USER=$2
echo ${ISP_USER}

#   comment by fxd 2014-7-31 : because of file-system read-only modify ( unless /fhcfg )
#   we can not  support  add a new User  throuth  patch  ......  

#WAREHOUSE_DEVICE=/fhcfg/tr069/fhcfg/${DEVICE_NAME}
#WAREHOUSE_DIR=/fhcfg/tr069/fhcfg/${DEVICE_NAME}/${ISP_USER}
#RUNTIME_DIR=/fhcfg/tr069/fhcfg
#    check  if  WAREHOUSE_DEVICE_DIR  existed , if no , then  create it 
#echo  $WAREHOUSE_DEVICE
#if  [ ! -d  ${WAREHOUSE_DEVICE} ];then
#	mkdir $WAREHOUSE_DEVICE 
#fi
#    check  if  WAREHOUSE_DIR  existed , if no , then  create it 
#if  [ ! -d  ${WAREHOUSE_DIR}    ] ; then
#	mkdir   ${WAREHOUSE_DIR}
#fi
#  copy   tr069 config file from patch path  to  WAREHOUSE_DIR
#if [ -f /fhcfg/cpepatch/param.xml ]  ;then
#	cp  /fhcfg/cpepatch/param.xml  ${WAREHOUSE_DIR}
#	cp  /fhcfg/cpepatch/param.xml  ${RUNTIME_DIR}
#	rm  /fhcfg/cpepatch/param.xml
#fi
#if [ -f /fhcfg/cpepatch/cpe_mib.xml ]  ;then
#	cp  /fhcfg/cpepatch/cpe_mib.xml  ${WAREHOUSE_DIR}
#	cp  /fhcfg/cpepatch/cpe_mib.xml  ${RUNTIME_DIR}
#	rm   /fhcfg/cpepatch/cpe_mib.xml
#fi
#if [ -f /fhcfg/cpepatch/tr069_version_control ]  ;then
#	cp  /fhcfg/cpepatch/tr069_version_control  ${WAREHOUSE_DIR}
#	cp  /fhcfg/cpepatch/tr069_version_control  ${RUNTIME_DIR}
#	rm  /fhcfg/cpepatch/tr069_version_control
#fi