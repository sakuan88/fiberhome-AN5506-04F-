DEVICE_NAME=$1
ISP_USER=$2
RUNTIME_DIR=/fhcfg/tr069/fhcfg
WAREHOUSE_DIR=/fh/extend/tr069/fhcfg/${DEVICE_NAME}/${ISP_USER}
#  if  /fh/extend/tr069/fhcfg  no tr069_config_version  ,then  ,we think  this is the first time 
#  ONU start , so need  copy  config file from warehouse to   runtime  default config path 
if [ ! -f ${RUNTIME_DIR}/tr069_config_version ] ; then
    echo "  /fhcfg/tr069/fhfcfg/tr069_config_version  do not existed ,copy from warehouse "
    cp  ${WAREHOUSE_DIR}/param.xml  ${RUNTIME_DIR}
    cp  ${WAREHOUSE_DIR}/cpe_mib.xml  ${RUNTIME_DIR}
    cp  ${WAREHOUSE_DIR}/tr069_config_version  ${RUNTIME_DIR}
fi

#  if  tr069_config_version existed in  RUNTIME_DIR ,but  is not the same as 
#  boot_version_control  --> device_class/isp_user/tr069_config_version 
#  so  we need copy  tr069_config_version  from WAREHOUSE_DIR to RUNTIME_DIR


if [  -f ${RUNTIME_DIR}/tr069_config_version ] ; then
       cmp  -s  ${RUNTIME_DIR}/tr069_config_version  ${WAREHOUSE_DIR}/tr069_config_version
       if [   $?  -ne 0 ];then
          echo  "  tr069_config_version is different between  RUNTIME_DIR and WAREHOUSE_DIR,so  copy WAREHOUSE to RUNTIME_DIR"
          cp  ${WAREHOUSE_DIR}/tr069_config_version  ${RUNTIME_DIR}/tr069_config_version
          cp  ${WAREHOUSE_DIR}/param.xml  ${RUNTIME_DIR}
          cp  ${WAREHOUSE_DIR}/cpe_mib.xml  ${RUNTIME_DIR}
       else
		  cmp  -s ${WAREHOUSE_DIR}/param.xml  ${RUNTIME_DIR}/param.xml 
          if [   $?  -ne 0 ];then
             echo  "  ${WAREHOUSE_DIR}/param.xml  is different  from  ${RUNTIME_DIR}param.xml ,so cp"
             cp  ${WAREHOUSE_DIR}/param.xml  ${RUNTIME_DIR}/param.xml
          fi
       fi
fi

# add by yanchl for AIS SSL Certificate 
if [ ${ISP_USER} == "X_AIS" ] ; then
   if [ -f ${WAREHOUSE_DIR}/rootca.pem ] ; then
		if [ ! -d "/fhcfg/ssl" ] ; then
            mkdir /fhcfg/ssl
		fi
        cp ${WAREHOUSE_DIR}/rootca.pem /fhcfg/ssl/
		rm ${WAREHOUSE_DIR}/rootca.pem
   fi
fi

# add by yanchl for TR069 pre config patch ugrade
if [ ! -f ${RUNTIME_DIR}/tr069_pre_config_sp_version ] ; then
    echo "  /fhcfg/tr069/fhfcfg/tr069_pre_config_sp_version  do not existed ,copy from warehouse "
    cp  ${WAREHOUSE_DIR}/tr069_pre_config_sp.xml  ${RUNTIME_DIR}
    cp  ${WAREHOUSE_DIR}/tr069_pre_config_sp_version  ${RUNTIME_DIR}
    cp  ${WAREHOUSE_DIR}/cpe_mib.xml  ${RUNTIME_DIR}/cpe_mib.xml
fi

if [  -f ${RUNTIME_DIR}/tr069_pre_config_sp_version ] ; then
       cmp  -s  ${RUNTIME_DIR}/tr069_pre_config_sp_version  ${WAREHOUSE_DIR}/tr069_pre_config_sp_version
       if [   $?  -ne 0 ];then
          echo  "  tr069_pre_config_sp_version is different between  RUNTIME_DIR and WAREHOUSE_DIR,so  copy WAREHOUSE to RUNTIME_DIR"
          mv  ${RUNTIME_DIR}/tr069_pre_config_sp_version  ${RUNTIME_DIR}/tr069_pre_config_sp_version_old
          cp  ${WAREHOUSE_DIR}/tr069_pre_config_sp_version  ${RUNTIME_DIR}/tr069_pre_config_sp_version
          cp  ${WAREHOUSE_DIR}/tr069_pre_config_sp.xml  ${RUNTIME_DIR}
          cp  ${WAREHOUSE_DIR}/cpe_mib.xml  ${RUNTIME_DIR}/cpe_mib.xml
       fi
fi
