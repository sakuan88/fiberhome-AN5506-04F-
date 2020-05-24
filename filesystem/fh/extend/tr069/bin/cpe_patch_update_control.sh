#   check if existed     patch process script ,if has ,then do it 
if [ -f  /fhcfg/cpepatch/cpe_patch_update_process.sh ];then
	chmod 700 	/fhcfg/cpepatch/cpe_patch_update_process.sh
      /fhcfg/cpepatch/cpe_patch_update_process.sh  $1   $2 
      rm -rf /fhcfg/cpepatch/cpe_patch_update_process.sh 
fi
