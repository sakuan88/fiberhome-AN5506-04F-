#!/bin/sh
# if device first install software  :may be 
# /fhcfg/tr069_config_version  , param.xml ,cpe_mib.xml  do not exist
# or /fhcfg/tr069_config_version   is not the same as in  /fh/extend/tr069/fhcfg   


# no matter "/fhcfg/tr069_config_version"  exist or not , if /fh/extend/tr069/fhcfpg/param.xml 
# is not the same  as /fhcfg/param.xml  ,we  update it .

RUNTIME_DIR=/fhcfg/tr069/fhcfg

if [  -f ${RUNTIME_DIR}/param.xml ];then
   if [ -f /fhcfg/param.xml  ];then
       cmp  -s /fhcfg/param.xml  ${RUNTIME_DIR}/param.xml 
       if [   $?  -ne 0 ];then
          echo  "  /fhcfg/param.xml  is different  from  /fhcfg/tr069/fhcfg/param.xml ,so cp"
          cp  ${RUNTIME_DIR}/param.xml  /fhcfg/param.xml
       fi
   else
   	   echo  "/fhcfg/param.xml not existed, so we get default xml to /fhcfg" 
   	   cp ${RUNTIME_DIR}/param.xml /fhcfg/param.xml
   fi
fi


# if "/fhcfg/tr069_config_version"  do not existed , then : cp  3 file from  /fh/extend/tr069/fhcfg 
if [ ! -f "/fhcfg/tr069_config_version" ];then
   echo  "/fhcfg/tr069_config_version  not existed ,so we udpate to  /fhcfg" 
   if [ ! -f ${RUNTIME_DIR}/tr069_config_version ];then
        echo "  /fhcfg/tr069/fhcfg/tr069_config_version  do not existed "
   else
        cp  ${RUNTIME_DIR}/tr069_config_version  /fhcfg/
   fi

   if [ ! -f ${RUNTIME_DIR}/cpe_mib.xml ];then
        echo "  /fhcfg/tr069/fhcfg/cpe_mib.xml  do not existed "
   else
        cp  ${RUNTIME_DIR}/cpe_mib.xml    /fhcfg/
   fi

   if [ ! -f ${RUNTIME_DIR}/param.xml ];then
        echo "  /fhcfg/tr069/fhcfg/param.xml  do not existed "
   else
      cp  ${RUNTIME_DIR}/param.xml    /fhcfg/
   fi
else
	echo "/fhcfg/tr069_config_version file existed "   

	if [ ! -f "/fhcfg/cpe_mib.xml" ];then
		echo "/fhcfg/cpe_mib.xml do not existed, get default cpe_mib.xml to /fhcfg"
#		cp ${RUNTIME_DIR}/cpe_mib.xml /fhcfg/
	else
		echo "/fhcfg/cpe_mib.xml exists, we need compare tr069_config_version"
	fi

#  can't update cpe_mib.xml	
	if [  $1  -eq 1 ] ; then
		echo " Absolutely,specify can't update cpe_mib.xml ! "
		exit
	fi
	
   cmp  -s /fhcfg/tr069_config_version   ${RUNTIME_DIR}/tr069_config_version
   if [  $?  -eq 0 ] ; then
     echo "  both tr069_config_version  file is the same ,need not update  "   
     exit
   else
     echo " both tr069_config_version  file is not the same ,so  udpate  "
   fi
   echo  " begin  update  tr069_config_version  "
#sync  tr069_config_version
  cp  ${RUNTIME_DIR}/tr069_config_version  /fhcfg/
   echo  " end   update  tr069_config_version  "


#backup  /fhcfg/cpe_mib.xml 
  if [ -f /fhcfg/cpe_mib.xml ] ; then
          echo  " begin backup cpe_mib.xml "
         cp  /fhcfg/cpe_mib.xml   /fhcfg/backup_cpe_mib.xml
          echo  " end backup cpe_mib.xml "
  fi
  cp  ${RUNTIME_DIR}/cpe_mib.xml    /fhcfg/
  echo   " finish  update   cpe_mib.xml "
# backup  /fhcfg/param.xml
  if [ -f /fhcfg/param.xml ] ; then
	echo  " backup  param.xml "
         cp  /fhcfg/param.xml   /fhcfg/backup_param.xml
  fi
  echo  "  begin  update  param.xml "
  cp  ${RUNTIME_DIR}/param.xml    /fhcfg/
  echo  "  end   update  param.xml "
  
fi
