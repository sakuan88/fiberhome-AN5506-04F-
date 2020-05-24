cd /fh/extend

rm -f /fhcfg/ptys_name

./fh_printf_redirect
sleep 1
echo "./fh_printf_redirect"

if [ "$?" -eq "0" ]
then
        #std out
        FH_STD_OUT_PTYS=`cat /fhcfg/ptys_name | grep stdout | awk '{print $2}'`
        echo "$FH_STD_OUT_PTYS"
        stty -F $FH_STD_OUT_PTYS  > /dev/null 2>&1
        if [ "$?" -eq "0" ]
        then
                exec > $FH_STD_OUT_PTYS
        fi
        #std err
        FH_STD_ERR_PTYS=`cat /fhcfg/ptys_name | grep stderr | awk '{print $2}'`
        echo "$FH_STD_ERR_PTYS"
        stty -F $FH_STD_ERR_PTYS  > /dev/null 2>&1
        if [ "$?" -eq "0" ]
        then
                exec 2> $FH_STD_ERR_PTYS
        fi
fi
