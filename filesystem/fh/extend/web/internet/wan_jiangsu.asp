<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>WAN</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var GetWANsizeSync = '<% GetWANsizeTr069Sync(); %>';	
var pf_ruleSum = '<% getCfgGeneral(1, "wan_size"); %>';
var WifiFlag = '<% getCfgGeneral(1, "WifiFlag"); %>'; 
var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num"); %>'; 

var curWANmode;
var curWANtype;
var wan_enable_all = '<% getCfgGeneral(1, "wan_enable_all"); %>';
var wan_pp_n ='<% getCfgGeneral(1, "pppoe_name"); %>';
var feData = "<% getCfgGeneral(1, 'wan_fe_bind'); %>";
var ssidData = "<% getCfgGeneral(1, 'wan_ssid_bind'); %>";
var wanmodeDate = "<% getCfgGeneral(1, 'wan_service_type_all'); %>";
var wanTypeDate = "<% getCfgGeneral(1, 'wan_wan_type_all'); %>";
var wanVIDDate = "<% getCfgGeneral(1, 'wan_vid_all'); %>";
var wanPriorityDate = "<% getCfgGeneral(1, 'wan_priority_all'); %>";
var wan_pp_p ='<% getCfgGeneral(1, "pppoe_pwd"); %>';
var wanaddress_modeDate = "<% getCfgGeneral(1, 'wan_address_mode_all'); %>";
var wanNatDate = "<% getCfgGeneral(1, 'wan_nat_all'); %>";
var wanRelayDate = "<% getCfgGeneral(1, 'wan_relay_all'); %>";
var ipv6_enable_s = '<% getCfgGeneral(1, "ipv6_enable"); %>';
var dslite_enable = '<% getCfgGeneral(1, "dslite_enable"); %>';
var aftr_mode = '<% getCfgGeneral(1, "aftr_mode"); %>';

var wan_staticip = '<% getCfgGeneral(1, "wan_static_ip"); %>';
var wan_staticmask = '<% getCfgGeneral(1, "wan_static_mask"); %>';
var wan_staticgw = '<% getCfgGeneral(1, "wan_static_gw"); %>';
var wan_staticdns1 = '<% getCfgGeneral(1, "wan_static_dns1"); %>';
var wan_staticdns2 = '<% getCfgGeneral(1, "wan_static_dns2"); %>';

var wan_pppoe_mode ='<% getCfgGeneral(1, "pppoe_mode"); %>';
var wan_pppoe_interval ='<% getCfgGeneral(1, "pppoe_interval"); %>';
var wan_pppoe_state ='<% getCfgGeneral(1, "pppoe_state"); %>';
var wan_Index ='<% getCfgGeneral(1, "wan_index_all"); %>';
var ipv6_state = '<% getCfgGeneral(1, "ipv6_state"); %>';
var all_option43_en = '<% getCfgGeneral(1, "all_option43_str"); %>';
var all_option60_en = '<% getCfgGeneral(1, "all_option60_str"); %>';
var all_option60_value = '<% getCfgGeneral(1, "all_option60_value_str"); %>';
var route_brige_all = '<% getCfgGeneral(1, "route_brige_all"); %>';
var wan_line = '<% getCfgGeneral(1, "wan_line"); %>';
var brige_wan_only = '<% getCfgGeneral(1, "brige_wan_only"); %>'; /*01A9G只支持internet 桥接wan*/

var route_brige_arr = route_brige_all.split("|");
var route_brige_0Array, route_brige_1Array, route_brige_2Array, route_brige_3Array, route_brige_4Array;

var option43_arr = all_option43_en.split("|");
var option430Array, option431Array, option432Array, option433Array, option434Array;

var option60_arr = all_option60_en.split("|");
var option600Array, option601Array, option602Array, option603Array, option604Array;

var wan_enable_arr = wan_enable_all.split("|");
var wan_enable0Array, wan_enable1Array, wan_enable2Array, wan_enable3Array, wan_enable4Array;

var option60_value_arr = all_option60_value.split("|");
var option60_value0Array, option60_value1Array, option60_value2Array, option60_value3Array,option60_value4Array;

var wanIndex = wan_Index.split("|");
var Wanindex0Array, Wanindex1Array, Wanindex2Array, Wanindex3Array,Wanindex4Array;
var curWANIndex;

var feArray = feData.split("|");
var feWan0Array, feWan1Array, feWan2Array, feWan3Array, feWan4Array;

var ssidArray = ssidData.split("|");
var ssidWan0Array, ssidWan1Array, ssidWan2Array, ssidWan3Array, ssidWan4Array;

var modeArray = wanmodeDate.split("|");
var modeWan0Array, modeWan1Array, modeWan2Array, modeWan3Array, modeWan4Array;

var typeArray = wanTypeDate.split("|");
var typeWan0Array, typeWan1Array, typeWan2Array, typeWan3Array, typeWan4Array;

var VIDArray = wanVIDDate.split("|");
var VIDWan0Array, VIDWan1Array, VIDWan2Array, VIDWan3Array, VIDWan4Array;

var PriorityArray = wanPriorityDate.split("|");
var PriorityWan0Array, PriorityWan1Array, PriorityWan2Array, PriorityWan3Array, PriorityWan4Array;

var addressArray = wanaddress_modeDate.split("|");
var addressWan0Array, addressWan1Array, addressWan2Array, addressWan3Array, addressWan4Array;

var NatArray = wanNatDate.split("|");
var NatWan0Array, NatWan1Array, NatWan2Array, NatWan3Array, NatWan4Array;

var RelayArray = wanRelayDate.split("|");
var RelayWan0Array, RelayWan1Array, RelayWan2Array, RelayWan3Array, RelayWan4Array;

var WanStaticIp = wan_staticip.split("|");
var Wan0StaticIp,Wan1StaticIp,Wan2StaticIp,Wan3StaticIp, Wan4StaticIp ;

var WanStaticMask = wan_staticmask.split("|");
var Wan0StaticMask,Wan1StaticMask,Wan2StaticMask,Wan3StaticMask, Wan4StaticMask;

var WanStaticGW = wan_staticgw.split("|");
var Wan0StaticGW,Wan1StaticGW,Wan2StaticGW,Wan3StaticGW, Wan4StaticGW;

var WanStaticDNS1 = wan_staticdns1.split("|");
var Wan0StaticDNS1,Wan1StaticDNS1,Wan2StaticDNS1,Wan3StaticDNS1, Wan4StaticDNS1;

var WanStaticDNS2 = wan_staticdns2.split("|");
var Wan0StaticDNS2,Wan1StaticDNS2,Wan2StaticDNS2,Wan3StaticDNS2, Wan4StaticDNS2;

var WanpppoeName = wan_pp_n.split("|");
var Wan0pppoeName,Wan1pppoeName,Wan2pppoeName,Wan3pppoeName, Wan4pppoeName;
var WanpppoePwd = wan_pp_p.split("|");
var Wan0pppoePwd,Wan1pppoePwd,Wan2pppoePwd,Wan3pppoePwd, Wan4pppoePwd;
var WanpppoeMode = wan_pppoe_mode.split("|");
var Wan0pppoeMode,Wan1pppoeMode,Wan2pppoeMode,Wan3pppoeMode, Wan4pppoeMode;
var WanpppoeInterval = wan_pppoe_interval.split("|");
var Wan0pppoeInterval,Wan1pppoeInterval,Wan2pppoeInterval,Wan3pppoeInterval, Wan4pppoeInterval;
var WanpppoeState = wan_pppoe_state.split("|");
var Wan0pppoeState,Wan1pppoeState,Wan2pppoeState,Wan3pppoeState, Wan4pppoeState;

var currentline;


function splitDate()
{
    var wan_num = pf_ruleSum;
	switch(parseInt(wan_num))
	{
		case 5:
			wan_enable4Array = wan_enable_arr[4];
			Wanindex4Array = wanIndex[4];
			modeWan4Array = modeArray[4];
			typeWan4Array = typeArray[4];
		    VIDWan4Array = VIDArray[4];
			PriorityWan4Array = PriorityArray[4];
			addressWan4Array = addressArray[4];
			RelayWan4Array = RelayArray[4];
			NatWan4Array = NatArray[4];
			feWan4Array = feArray[4].split(",");
			ssidWan4Array = ssidArray[4].split(",");
			Wan4StaticIp = WanStaticIp[4];
			Wan4StaticMask = WanStaticMask[4];
			Wan4StaticGW = WanStaticGW[4];
			Wan4StaticDNS1 = WanStaticDNS1[4];
			Wan4StaticDNS2 = WanStaticDNS2[4];
			Wan4pppoeName = WanpppoeName[4];
			Wan4pppoePwd = WanpppoePwd[4];
			Wan4pppoeMode = WanpppoeMode[4];
			Wan4pppoeInterval = WanpppoeInterval[4];
			Wan4pppoeState = WanpppoeState[4];
			option434Array = option43_arr[4];
			option604Array = option60_arr[4];
			option60_value4Array = option60_value_arr[4];
			route_brige_4Array = route_brige_arr[4];
		case 4:
			wan_enable3Array = wan_enable_arr[3];
			Wanindex3Array = wanIndex[3];
			modeWan3Array = modeArray[3];
			typeWan3Array = typeArray[3];
		    VIDWan3Array = VIDArray[3];
			PriorityWan3Array = PriorityArray[3];
			addressWan3Array = addressArray[3];
			RelayWan3Array = RelayArray[3];
			NatWan3Array = NatArray[3];
			feWan3Array = feArray[3].split(",");
			ssidWan3Array = ssidArray[3].split(",");
			Wan3StaticIp = WanStaticIp[3];
			Wan3StaticMask = WanStaticMask[3];
			Wan3StaticGW = WanStaticGW[3];
			Wan3StaticDNS1 = WanStaticDNS1[3];
			Wan3StaticDNS2 = WanStaticDNS2[3];
			Wan3pppoeName = WanpppoeName[3];
			Wan3pppoePwd = WanpppoePwd[3];
			Wan3pppoeMode = WanpppoeMode[3];
			Wan3pppoeInterval = WanpppoeInterval[3];
			Wan3pppoeState = WanpppoeState[3];
			option433Array = option43_arr[3];
			option603Array = option60_arr[3];
			option60_value3Array = option60_value_arr[3];
			route_brige_3Array = route_brige_arr[3];
        case 3:
			wan_enable2Array = wan_enable_arr[2];
			Wanindex2Array = wanIndex[2];
			modeWan2Array = modeArray[2];
			typeWan2Array = typeArray[2];
			VIDWan2Array = VIDArray[2];
			PriorityWan2Array = PriorityArray[2];
			addressWan2Array = addressArray[2];
			NatWan2Array = NatArray[2];
			RelayWan2Array = RelayArray[2];
			feWan2Array = feArray[2].split(",");
			ssidWan2Array = ssidArray[2].split(",");
			Wan2StaticIp = WanStaticIp[2];
			Wan2StaticMask = WanStaticMask[2];
			Wan2StaticGW = WanStaticGW[2];
			Wan2StaticDNS1 = WanStaticDNS1[2];
			Wan2StaticDNS2 = WanStaticDNS2[2];
			Wan2pppoeName = WanpppoeName[2];
			Wan2pppoePwd = WanpppoePwd[2];
			Wan2pppoeMode = WanpppoeMode[2];
			Wan2pppoeInterval = WanpppoeInterval[2];
			Wan2pppoeState = WanpppoeState[2];
			option432Array = option43_arr[2];
			option602Array = option60_arr[2];
			option60_value2Array = option60_value_arr[2];
			route_brige_2Array = route_brige_arr[2];
       case 2:
	   		wan_enable1Array = wan_enable_arr[1];
			Wanindex1Array = wanIndex[1];
			modeWan1Array = modeArray[1];
			typeWan1Array = typeArray[1];
			VIDWan1Array = VIDArray[1];
			PriorityWan1Array = PriorityArray[1];
			addressWan1Array = addressArray[1];
			NatWan1Array = NatArray[1];
			RelayWan1Array = RelayArray[1];
			feWan1Array = feArray[1].split(",");
			ssidWan1Array = ssidArray[1].split(",");
			Wan1StaticIp = WanStaticIp[1];
			Wan1StaticMask = WanStaticMask[1];
			Wan1StaticGW = WanStaticGW[1];
			Wan1StaticDNS1 = WanStaticDNS1[1];
			Wan1StaticDNS2 = WanStaticDNS2[1];
			Wan1pppoeName = WanpppoeName[1];
			Wan1pppoePwd = WanpppoePwd[1];
			Wan1pppoeMode = WanpppoeMode[1];
			Wan1pppoeInterval = WanpppoeInterval[1];
			Wan1pppoeState = WanpppoeState[1];
			option431Array = option43_arr[1];
			option601Array = option60_arr[1];
			option60_value1Array = option60_value_arr[1];
			route_brige_1Array = route_brige_arr[1];
        case 1:		
			wan_enable0Array = wan_enable_arr[0];
			Wanindex0Array = wanIndex[0];
			modeWan0Array = modeArray[0];
			typeWan0Array = typeArray[0];
			VIDWan0Array = VIDArray[0];
			PriorityWan0Array = PriorityArray[0];
			addressWan0Array = addressArray[0];
			NatWan0Array = NatArray[0];
			RelayWan0Array = RelayArray[0];
			feWan0Array = feArray[0].split(",");
			ssidWan0Array = ssidArray[0].split(",");	
			Wan0StaticIp = WanStaticIp[0];
			Wan0StaticMask = WanStaticMask[0];
			Wan0StaticGW = WanStaticGW[0];
			Wan0StaticDNS1 = WanStaticDNS1[0];
			Wan0StaticDNS2 = WanStaticDNS2[0];
			Wan0pppoeName = WanpppoeName[0];
			Wan0pppoePwd = WanpppoePwd[0];
			Wan0pppoeMode = WanpppoeMode[0];
			Wan0pppoeInterval = WanpppoeInterval[0];
			Wan0pppoeState = WanpppoeState[0];
			option430Array = option43_arr[0];
			option600Array = option60_arr[0];
			option60_value0Array = option60_value_arr[0];
			route_brige_0Array = route_brige_arr[0];
			break;
		default:
			break;
}
}

function showFESSID(wanIndex)
{
	var curFEArr;
	var curSSIDArr;
	
	var i;
	switch(parseInt(wanIndex))
	{
		case 0:
			curFEArr = feWan0Array;
			curSSIDArr = ssidWan0Array;
			break;
		case 1:
			curFEArr = feWan1Array;			
			curSSIDArr = ssidWan1Array;
			break;
		case 2:
			curFEArr = feWan2Array;
			curSSIDArr = ssidWan2Array;
			break;
		case 3 :
			curFEArr = feWan3Array;
			curSSIDArr = ssidWan3Array;
			break;
		case 4 :
			curFEArr = feWan4Array;
			curSSIDArr = ssidWan4Array;
			break;
		default:
			break;
	}
			
	var wanFEBoxNode = getElement("wan_feBox");
	//var wanSsidBoxNode = getElement("wan_ssidBox");
	
	/*lan band 勾选*/
	if(curFEArr[0] == 1)
	{
		wanFEBoxNode[0].checked = true;			
	}
	else
	{
        wanFEBoxNode[0].checked =  false;	
	}

    if( curFEArr[1] == 2 )
    {
		wanFEBoxNode[1].checked = true;
    }
    else 
	{
	     wanFEBoxNode[1].checked = false;
	}
	if(curFEArr[2] == 4)
	{
		wanFEBoxNode[2].checked = true;			
	}
	else
	{
        wanFEBoxNode[2].checked =  false;	
	}

    if( curFEArr[3] == 8 )
    {
		wanFEBoxNode[3].checked = true;
    }
    else 
	{
	     wanFEBoxNode[3].checked = false;
	}
	/*ssid band 勾选
	if(curSSIDArr[0] == 1)
	{
		wanSsidBoxNode[0].checked = true;			
	}
	else
	{
        wanSsidBoxNode[0].checked =  false;	
	}

    if( curSSIDArr[1] == 2 )
    {
		wanSsidBoxNode[1].checked = true;
    }
    else 
	{
	     wanSsidBoxNode[1].checked = false;
	}
	if(curSSIDArr[2] == 4)
	{
		wanSsidBoxNode[2].checked = true;			
	}
	else
	{
        wanSsidBoxNode[2].checked =  false;	
	}

    if( curSSIDArr[3] == 8 )
    {
		wanSsidBoxNode[3].checked = true;
    }
    else 
	{
	     wanSsidBoxNode[3].checked = false;
	}*/


	
	/*端口绑定暂时只读
	for(i = 0; i < 4; i++)
	{
		wanFEBoxNode[i].disabled = 1;
		wanSsidBoxNode[i].disabled = 1;	
	}*/
	
}




function showDate(wanIndex)
{
	var curWANenable;
	var curWANvid;
	var curWANpriority;
	var curWANnat;
	var curWANRelay;
	var curWANaddress;
	var curWANstaticIP;
	var curWANstaticMask;
	var curWANstaticGW;
	var curWANstaticDns1;
	var curWANstaticDns2;
	var curWANpppoename;
	var curWANpppoepwd;
	var curWANpppoemode;
	var curWANpppoeinterval;
	var curWANpppoestate;
	var curoption60_value;
	var curoption60;
	var curoption43;
	var curroute_brige;
	var i;
	
	switch(parseInt(wanIndex))
	{
		case 0:
			curWANenable = wan_enable0Array;
			curWANIndex = Wanindex0Array
			curWANmode = modeWan0Array;
			curWANtype = typeWan0Array;
			curWANvid = VIDWan0Array;
			curWANpriority = PriorityWan0Array;
			curWANnat = NatWan0Array;
			curWANRelay = RelayWan0Array;
			curWANaddress = addressWan0Array;	
			curWANstaticIP = Wan0StaticIp;
			curWANstaticMask = Wan0StaticMask;
			curWANstaticGW = Wan0StaticGW;
			curWANstaticDns1 = Wan0StaticDNS1;
			curWANstaticDns2 = Wan0StaticDNS2;
			curWANpppoename = Wan0pppoeName;
			curWANpppoepwd = Wan0pppoePwd;
			curWANpppoemode = Wan0pppoeMode;
			curWANpppoeinterval = Wan0pppoeInterval;
			curWANpppoestate = Wan0pppoeState;
			curoption43 = option430Array;
			curoption60 = option600Array;
			curoption60_value = option60_value0Array;
			curroute_brige = route_brige_0Array;
			break;
		case 1:
			curWANenable = wan_enable1Array;
			curWANIndex = Wanindex1Array
			curWANmode = modeWan1Array;
			curWANtype = typeWan1Array;
			curWANvid = VIDWan1Array;
			curWANpriority = PriorityWan1Array;
			curWANnat = NatWan1Array;
			curWANRelay = RelayWan1Array;
			curWANaddress = addressWan1Array;	
			curWANstaticIP = Wan1StaticIp;
			curWANstaticMask = Wan1StaticMask;
			curWANstaticGW = Wan1StaticGW;
			curWANstaticDns1 = Wan1StaticDNS1;
			curWANstaticDns2 = Wan1StaticDNS2;
			curWANpppoename = Wan1pppoeName;
			curWANpppoepwd = Wan1pppoePwd;
			curWANpppoemode = Wan1pppoeMode;
			curWANpppoeinterval = Wan1pppoeInterval;
			curWANpppoestate = Wan1pppoeState;
			curoption43 = option431Array;
			curoption60 = option601Array;
			curoption60_value = option60_value1Array;
			curroute_brige = route_brige_1Array;
			break;
		case 2:
			curWANenable = wan_enable2Array;
			curWANIndex = Wanindex2Array
			curWANmode = modeWan2Array;
			curWANtype = typeWan2Array;
			curWANvid = VIDWan2Array;
			curWANpriority = PriorityWan2Array;
			curWANnat = NatWan2Array;
			curWANRelay = RelayWan2Array;
			curWANaddress = addressWan2Array;
			curWANstaticIP = Wan2StaticIp;
			curWANstaticMask = Wan2StaticMask;
			curWANstaticGW = Wan2StaticGW;
			curWANstaticDns1 = Wan2StaticDNS1;
			curWANstaticDns2 = Wan2StaticDNS2;
			curWANpppoename = Wan2pppoeName;
			curWANpppoepwd = Wan2pppoePwd;
			curWANpppoemode = Wan2pppoeMode;
			curWANpppoeinterval = Wan2pppoeInterval;
			curWANpppoestate = Wan2pppoeState;
			curoption43 = option432Array;
			curoption60 = option602Array;
			curoption60_value = option60_value2Array;
			curroute_brige = route_brige_2Array;
			break;
		case 3 :
			curWANenable = wan_enable3Array;
			curWANIndex = Wanindex3Array
			curWANmode = modeWan3Array;
			curWANtype = typeWan3Array;
			curWANvid = VIDWan3Array;
			curWANpriority = PriorityWan3Array;
			curWANnat = NatWan3Array;
			curWANRelay = RelayWan3Array;
			curWANaddress = addressWan3Array;
			curWANstaticIP = Wan3StaticIp;
			curWANstaticMask = Wan3StaticMask;
			curWANstaticGW = Wan3StaticGW;
			curWANstaticDns1 = Wan3StaticDNS1;
			curWANstaticDns2 = Wan3StaticDNS2;
			curWANpppoename = Wan3pppoeName;
			curWANpppoepwd = Wan3pppoePwd;
			curWANpppoemode = Wan3pppoeMode;
			curWANpppoeinterval = Wan3pppoeInterval;
			curWANpppoestate = Wan3pppoeState;
			curoption43 = option433Array;
			curoption60 = option603Array;
			curoption60_value = option60_value3Array;
			curroute_brige = route_brige_3Array;
			break;
		case 4 :
			curWANenable = wan_enable4Array;
			curWANIndex = Wanindex4Array
			curWANmode = modeWan4Array;
			curWANtype = typeWan4Array;
			curWANvid = VIDWan4Array;
			curWANpriority = PriorityWan4Array;
			curWANnat = NatWan4Array;
			curWANRelay = RelayWan4Array;
			curWANaddress = addressWan4Array;
			curWANstaticIP = Wan4StaticIp;
			curWANstaticMask = Wan4StaticMask;
			curWANstaticGW = Wan4StaticGW;
			curWANstaticDns1 = Wan4StaticDNS1;
			curWANstaticDns2 = Wan4StaticDNS2;
			curWANpppoename = Wan4pppoeName;
			curWANpppoepwd = Wan4pppoePwd;
			curWANpppoemode = Wan4pppoeMode;
			curWANpppoeinterval = Wan4pppoeInterval;
			curWANpppoestate = Wan4pppoeState;
			curoption43 = option434Array;
			curoption60 = option604Array;
			curoption60_value = option60_value4Array;
			curroute_brige = route_brige_4Array;
			break;
		default:
			break;	
	}

	document.getElementById("wan_enable").value = curWANenable;
	document.getElementById("wan_connectionType").value = curWANtype;
	document.getElementById("wan_connectionmode").value = curWANmode;
	document.getElementById("wan_vid").value = curWANvid;
	document.getElementById("wan_priority").value = curWANpriority;
	document.getElementById("nat_enable").value = curWANnat;
	document.getElementById("dns_enable").value = curWANRelay;
	document.getElementById("ipModel").value = curWANaddress;
	

	
	if(curWANaddress == 1) /* 静态*/
	{
		document.getElementById("staticIp").value = curWANstaticIP;
		document.getElementById("staticNetmask").value = curWANstaticMask;
		document.getElementById("staticGateway").value = curWANstaticGW;
		document.getElementById("staticPriDns").value = curWANstaticDns1;
		document.getElementById("staticSecDns").value = curWANstaticDns2;
	}
	else if(curWANaddress == 2)/*pppoe*/
	{
		document.getElementById("pppoeUser").value = curWANpppoename;
		document.getElementById("pppoePass").value = curWANpppoepwd;
		document.getElementById("pppoeOPMode").value = curWANpppoemode;
	
		if(curWANpppoestate == 1)
		{
			document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_connect")
		}
		else
		{
			document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_disconnect")
		}
			
		if(curWANaddress = 2)
		{
			pppoeOPModeSwitch();
			if((curWANpppoemode == 0) || (curWANpppoemode == 1))
			{
				document.getElementById("pppoeRetryPeriod").value = curWANpppoeinterval;
			}
		}
		document.getElementById("wPppoeCon_ip").value = curWANstaticIP;
		document.getElementById("wPppoeCon_mask").value = curWANstaticMask;
		document.getElementById("wPppoeCon_gateway").value = curWANstaticGW;
		document.getElementById("wPppoeCon_priDNS").value = curWANstaticDns1;
		document.getElementById("wPppoeCon_secDNS").value = curWANstaticDns2;
	}

	else  /*dhcp*/
	{
		document.getElementById("wDhcpCon_ip").value = curWANstaticIP;
		document.getElementById("wDhcpCon_mask").value = curWANstaticMask;
		document.getElementById("wDhcpCon_gateway").value = curWANstaticGW;
		document.getElementById("wDhcpCon_priDNS").value = curWANstaticDns1;
		document.getElementById("wDhcpCon_secDNS").value = curWANstaticDns2;
		//var option43_tip = document.getElementsByName("option43_enable");
		//var option60_tip = document.getElementsByName("option60_enable");
		//document.getElementById("option60_value").value = curoption60_value;
		
		/*	for(var i = 0;i<option43_tip.length;i++)
			{
				if(option43_tip[i].value == curoption43)
				{
					option43_tip[i].checked = true;
					break;
				}
			}
			
			for(var i = 0;i<option60_tip.length;i++)
			{
				if(option60_tip[i].value == curoption60)
				{
					option60_tip[i].checked = true;
					break;
				}
			}*/
	}
	WanIndexSwitch(curWANmode);
	//alert("curWANtype = "+ curWANtype);
	ConnectTypeSwitch(curWANtype);
	//alert("curWANmode  = "+curWANmode );

	if ((curWANmode  == 0) || (curWANmode == 3) || (curWANmode  == 4) ||(curWANmode  == 2) ||(curWANmode  == 5))
	{
		document.getElementById("wan_connectionType").disabled = 1;
		setDisplay("nat_dns", "");
		if((curWANmode  == 0) || (curWANmode == 3) || (curWANmode  == 4))
		{
			setDisplay("wan_ipv6enable", "none");
			ipv6_enableSwitch()
		}
		else
		{	
			setDisplay("wan_ipv6enable", "");
			ipv6_enableSwitch()
		}
		setDisplay("tb_wanIPModel", "");	
		connectionTypeSwitch();
		if(curWANmode  == 3) /*组播为桥接模式*/
		{
			setDisplay("nat_dns", "none");
			setDisplay("tb_wanIPModel", "none");	   
			setDisplay("pppoe", "none");
			setDisplay("dhcp", "none");
			setDisplay("static", "none");
		}
	}
	else /*internet*/
	{
		if(parseInt(brige_wan_only) == 1)	/*01A9G只支持internet 桥接wan*/
		{
			document.getElementById("wan_connectionType").disabled = 1;
		}
		else
		{
			document.getElementById("wan_connectionType").disabled = 0;
		}
		setDisplay("nat_dns", "");
	
		setDisplay("wan_ipv6enable", "");
		ipv6_enableSwitch()
	
		setDisplay("tb_wanIPModel", "");	
		connectionTypeSwitch();
		
	}

	/*只有internet相关 可以配置ipv6*/
	if((curWANmode  == 1) || (curWANmode == 2) || (curWANmode  == 5))
	{
		var ipv6_enable_s  = document.getElementById("ipv6_enable");

		var dslite_enable_s  = document.getElementById("DS_Lite_enable");
		var aftr_mode_s  = document.getElementById("AFTR_enable");
		
		setDisplay("wan_ipv6enable", "");	
		ipv6_enable_s.value = ipv6_state;
		dslite_enable_s.value = dslite_enable;
		aftr_mode_s.value = aftr_mode;
		
		ipv6_enableSwitch();
	}
	else
	{
		setDisplay("wan_ipv6enable", "none");
		setDisplay("static_ipv6", "none");
		setDisplay("dhcp_ipv6", "none");
		setDisplay("pppoe_ipv6", "none");
	}

	ConnectTypeSwitch(curWANtype);

	if(curWANmode == 0)  /*江苏电信tr069  wan 参数不能修改*/
	{
		setDisplay("apply_table", "none");
	}
	else
	{
		setDisplay("apply_table", "");
	}

	//混合路由桥模式
  /*	var route_brige_value = '<% getCfgGeneral(1, "route_brige_en"); %>';  
	var route_brige_enable = getElement("route_brige_enable");

	if(curroute_brige == 1)
	{
		route_brige_enable.checked = true;			
	}
	else
	{
        route_brige_enable.checked =  false;	
	}*/

	/*桥接IPV6_V4模式*/
	var wan_ipv6enable_node = document.getElementById("ipv6_enable1");
	var ipv6_v4_brige_value = '<% getCfgGeneral(1, "tr069_v6_v4_mode"); %>';
	wan_ipv6enable_node.value = ipv6_v4_brige_value;
	
}

function ipv6_enableSwitch()
{
    var connectionType =  document.getElementById("ipModel");
	var wan_ipv6enable = document.getElementById("ipv6_enable");
	var wan_conmode = document.getElementById("wan_connectionmode");
	
	if ((wan_ipv6enable.options.selectedIndex == 0) )
	{
		if((wan_conmode.options.selectedIndex == 1) || (wan_conmode.options.selectedIndex == 2) || (wan_conmode.options.selectedIndex == 5))
		{

			if(connectionType.options.selectedIndex == 1)
			{
				setDisplay("static_ipv6", "");
				setDisplay("dhcp_ipv6", "none");
				setDisplay("pppoe_ipv6", "none");
				setDisplay("static_ipv4_table", "");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "none");
				setDisplay("static", "");
				setDisplay("dhcp", "none");
				setDisplay("pppoe", "none");
			}
			else if(connectionType.options.selectedIndex == 0)
			{
				setDisplay("dhcp_ipv6", "");
				setDisplay("pppoe_ipv6", "none");
				setDisplay("static_ipv6", "none");
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "");
				setDisplay("pppoe_ipv4_table", "none");
				setDisplay("static", "none");
				setDisplay("dhcp", "");
				setDisplay("pppoe", "none");
			}
			else if(connectionType.options.selectedIndex == 2)
			{
				setDisplay("pppoe_ipv6", "");
				setDisplay("dhcp_ipv6", "none");
				setDisplay("static_ipv6", "none");
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "");
				setDisplay("static", "none");
				setDisplay("dhcp", "none");
				setDisplay("pppoe", "");
			}

		}
		else
		{
			setDisplay("static_ipv6", "none");
			setDisplay("dhcp_ipv6", "none");
			setDisplay("pppoe_ipv6", "none");
		}
		setDisplay("dsline_ipv6_table", "none");
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
		
	}
	else if ((wan_ipv6enable.options.selectedIndex == 2) )
	{
		if((wan_conmode.options.selectedIndex == 1) || (wan_conmode.options.selectedIndex == 2) || (wan_conmode.options.selectedIndex == 5))
		{
			setDisplay("dsline_ipv6_table", "");
			DsliteSwitch();
			if(connectionType.options.selectedIndex == 1)
			{
				setDisplay("static", "");
				setDisplay("dhcp", "none");
				setDisplay("pppoe", "none");
				setDisplay("static_ipv6", "");
				setDisplay("dhcp_ipv6", "none");
				setDisplay("pppoe_ipv6", "none");
			}
			else if(connectionType.options.selectedIndex == 0)
			{
				setDisplay("dhcp", "");
				setDisplay("pppoe", "none");
				setDisplay("static", "none");
				setDisplay("static_ipv6", "none");
				setDisplay("dhcp_ipv6", "");
				setDisplay("pppoe_ipv6", "none");
			}
			else if(connectionType.options.selectedIndex == 2)
			{
				setDisplay("pppoe", "");
				setDisplay("dhcp", "none");
				setDisplay("static", "none");
				setDisplay("static_ipv6", "none");
				setDisplay("dhcp_ipv6", "none");
				setDisplay("pppoe_ipv6", "");
				
			}
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "none");
		}
		else
		{
			if(connectionType.options.selectedIndex == 1)
			{
				setDisplay("static", "");
				setDisplay("dhcp", "none");
				setDisplay("pppoe", "none");
				setDisplay("static_ipv4_table", "");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "none");
			}
			else if(connectionType.options.selectedIndex == 0)
			{
				setDisplay("dhcp", "");
				setDisplay("pppoe", "none");
				setDisplay("static", "none");
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "");
				setDisplay("pppoe_ipv4_table", "none");
			}
			else if(connectionType.options.selectedIndex == 2)
			{
				setDisplay("pppoe", "");
				setDisplay("dhcp", "none");
				setDisplay("static", "none");
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "");
				
			}
			setDisplay("static_ipv6", "none");
			setDisplay("dhcp_ipv6", "none");
			setDisplay("pppoe_ipv6", "none");
			setDisplay("dsline_ipv6_table", "none");
			setDisplay("AFTR_ipv6_table", "none");
			setDisplay("AFTR_value_table", "none");
		}

	}
	else
	{
		if(connectionType.options.selectedIndex == 1)
		{
			setDisplay("static", "");
			setDisplay("dhcp", "none");
			setDisplay("pppoe", "none");
			setDisplay("static_ipv4_table", "");
			setDisplay("dhcp_ipv4_table", "none");
			setDisplay("pppoe_ipv4_table", "none");
		}
		else if(connectionType.options.selectedIndex == 0)
		{
			setDisplay("dhcp", "");
			setDisplay("pppoe", "none");
			setDisplay("static", "none");
			setDisplay("static_ipv4_table", "none");
			setDisplay("dhcp_ipv4_table", "");
			setDisplay("pppoe_ipv4_table", "none");
		}
		else if(connectionType.options.selectedIndex == 2)
		{
			setDisplay("pppoe", "");
			setDisplay("dhcp", "none");
			setDisplay("static", "none");
			setDisplay("static_ipv4_table", "none");
			setDisplay("dhcp_ipv4_table", "none");
			setDisplay("pppoe_ipv4_table", "");
			
		}
		setDisplay("static_ipv6", "none");
		setDisplay("dhcp_ipv6", "none");
		setDisplay("pppoe_ipv6", "none");
		setDisplay("dsline_ipv6_table", "none");
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
	}
}
function connectionTypeSwitch()
{
	var connectionType =  document.getElementById("ipModel");
	var Prefix_dhcp_node =  document.getElementById("Address/Prefix_dhcp");
	var Prefix_pppoe_node =  document.getElementById("Address/Prefix_pppoe");
	var prefix_v6_dhcp = '<% getCfgGeneral(1, "prefix_v6_dhcp"); %>';
	var prefix_v6_pppoe = '<% getCfgGeneral(1, "prefix_v6_pppoe"); %>';
	
	if (connectionType.options.selectedIndex == 1) {
		setDisplay("static", "");
		setDisplay("dhcp", "none");
		setDisplay("pppoe", "none");
        ipv6_enableSwitch();
	}
	else if (connectionType.options.selectedIndex == 0) {
		setDisplay("dhcp", "");
		setDisplay("static", "none");
		setDisplay("pppoe", "none");
		ipv6_enableSwitch();
		Prefix_dhcp_node.options.selectedIndex = prefix_v6_dhcp;
	}
	else if (connectionType.options.selectedIndex == 2) {
		setDisplay("pppoe", "");
		setDisplay("dhcp", "none");
		setDisplay("static", "none");
		ipv6_enableSwitch();
		pppoeOPModeSwitch();
		Prefix_pppoe_node.options.selectedIndex = prefix_v6_pppoe;
	}
	
	else 
	{		
	}
}

function pppoeOPModeSwitch()
{
	var PppoeMode =  document.getElementById("pppoeOPMode");
	if ((PppoeMode.options.selectedIndex == 0) || (PppoeMode.options.selectedIndex == 1))
		setDisplay("wPppoeCon_retryPeriod_td", "");
	else
		setDisplay("wPppoeCon_retryPeriod_td", "none");			
}


function ConnectTypeSwitch(chooseConnType)
{
	var ipv6_enable_s  = document.getElementById("ipv6_enable");
	var wan_conmode = document.getElementById("wan_connectionmode");
	if (chooseConnType == 1) 	/* route */
	{
		setDisplay("tb_wanIPModel", "");
		connectionTypeSwitch();

		//internet相关
		if((wan_conmode.options.selectedIndex == 1) || (wan_conmode.options.selectedIndex == 2) || (wan_conmode.options.selectedIndex == 5))
		{
			setDisplay("wan_ipv6enable", "");
			ipv6_enableSwitch();
			setDisplay("nat_dns", "");
		} 
		else
		{
			setDisplay("nat_dns", "none");
		}
		setDisplay("wan_ipv6mode", "none");
	}
	else /*briage*/
	{
		setDisplay("nat_dns", "none");
		setDisplay("tb_wanIPModel", "none");	
		setDisplay("static_ipv4_table", "none");
		setDisplay("pppoe_ipv4_table", "none");
		setDisplay("dhcp_ipv4_table", "none");
		setDisplay("pppoe", "none");
		setDisplay("static", "none");
		setDisplay("dhcp", "none");

				
		ipv6_enable_s.options.selectedIndex = 1;
		setDisplay("static_ipv6", "none");
		setDisplay("dhcp_ipv6", "none");
		setDisplay("pppoe_ipv6", "none");
		setDisplay("wan_ipv6enable", "none");
		setDisplay("wan_ipv6mode", "");
		setDisplay("dsline_ipv6_table", "none");
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
	}
}
function WanIndexSwitch(chooseWanIndex)
{	
	var select_WANtype = document.getElementById("wan_connectionType");
	if ((chooseWanIndex == 0) ||	(chooseWanIndex == 1) ||	(chooseWanIndex == 2) || (chooseWanIndex == 4) || (chooseWanIndex == 5))   /* tr069 */
	{
		if(chooseWanIndex == 0 || (chooseWanIndex == 4) || (chooseWanIndex == 2) || (chooseWanIndex == 5) )  /*tr069, voip相关*/
		{				
				//var ipv6_enable_s  = document.getElementById("ipv6_enable");
				//ipv6_enable_s.options.selectedIndex = 1;
				setDisplay("port_bang", "");
				document.getElementById("wan_connectionType").disabled = 1;
				document.getElementById("wan_connectionType").value = 1;//route
				
				if(chooseWanIndex == 0 || (chooseWanIndex == 4))//tr069
				{
					setDisplay("port_bang", "none");
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("wan_ipv6enable", "none");
				}
	
				Tr069Wan_style(chooseWanIndex);
				ConnectTypeSwitch(1);
				
		}
		else 
		{		
			document.getElementById("wan_connectionType").disabled = 0;
			setDisplay("port_bang", "");
			ConnectTypeSwitch(select_WANtype.options.selectedIndex);
		}

		if((chooseWanIndex == 1) || (chooseWanIndex == 2) || (chooseWanIndex == 5))//internet相关
		{
			if(chooseWanIndex == 1)
			{
				if(parseInt(brige_wan_only) == 1)	/*01A9G只支持internet 桥接wan*/
				{
					document.getElementById("wan_connectionType").disabled = 0;
					document.getElementById("wan_connectionType").options.selectedIndex = 0;
					ConnectTypeSwitch(0);//bridge
					document.getElementById("wan_connectionType").disabled = 1;
				}
			}
			
		    if(select_WANtype.options.selectedIndex == 1)//route
		    {
				var ipv6_enable_s  = document.getElementById("ipv6_enable");
				ipv6_enable_s.options.selectedIndex = 1;
				setDisplay("wan_ipv6enable", "");
				ipv6_enableSwitch();
		    }
		}

	}
	else if(chooseWanIndex == 3)  /*muticast 只能 桥接*/
	{
		ConnectTypeSwitch(0);
		document.getElementById("wan_connectionType").options.selectedIndex = 0;
		document.getElementById("wan_connectionType").disabled = 1;
		setDisplay("port_bang", "");
	}
	else/*other*/
	{	
		document.getElementById("wan_connectionType").disabled = 0;
		setDisplay("tb_wanIPModel", "");
		setDisplay("port_bang", "");
		connectionTypeSwitch(0);
	}

}

function Tr069Wan_style(chooseWanIndex)
{
	if(chooseWanIndex == 0)
	{
		document.getElementById("wan_enable").disabled = 1;
		document.getElementById("wan_connectionmode").disabled = 1;
		document.getElementById("wan_vid").disabled = 1;
		//document.getElementById("nat_enable").disabled = 1;
		document.getElementById("wan_priority").disabled = 1;
		//document.getElementById("dns_enable").disabled = 1;
		document.getElementById("ipModel").disabled = 1;
		//document.getElementById("option60_value").disabled = 1;
		//document.getElementById("option60_enable").disabled = 1;
		setDisplay("nat_enable", "none");
		setDisplay("dns_enable", "none");
		
		
	}
	else
	{
		document.getElementById("wan_enable").disabled = 0;
		document.getElementById("wan_connectionmode").disabled = 0;
		document.getElementById("wan_vid").disabled = 0;
		document.getElementById("nat_enable").disabled = 0;
		document.getElementById("wan_priority").disabled = 0;
		document.getElementById("dns_enable").disabled = 0;
		document.getElementById("ipModel").disabled = 0;
		//document.getElementById("option60_value").disabled = 0;
		//document.getElementById("option60_enable").disabled = 0;
		setDisplay("nat_enable", "");
		setDisplay("dns_enable", "");
	}


}

function DsliteSwitch()
{
    if(document.getElementById("DS_Lite_enable").options.selectedIndex == 1)
    {
		setDisplay("AFTR_ipv6_table", "");
		AFTRSwitch();
	}
	else
	{
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
	}

}

function AFTRSwitch()
{
	if(document.getElementById("AFTR_enable").options.selectedIndex == 1)
    {
		setDisplay("AFTR_value_table", "");
	}
	else
	{
		setDisplay("AFTR_value_table", "none");
		
	}

}

function initTranslation()
{
	var e = document.getElementById("wan_prompt");
	e.innerHTML = _("wan_prompt");

	e = document.getElementById("WANListHead");
	e.innerHTML = _("WANListHead");

	e = document.getElementById("WAN_nameTitle");
	e.innerHTML = _("WAN_nameTitle");
	e = document.getElementById("WAN_VIDtitle");
	e.innerHTML = _("WAN_VIDtitle");
	e = document.getElementById("WAN_ipmode");
	e.innerHTML = _("WAN_ipmode");

	e = document.getElementById("wan_servicetypeTitle");
	e.innerHTML = _("wan_servicetypeTitle");
		e = document.getElementById("wConnType_bridge");
	e.innerHTML = _("wConnType_bridge");
			e = document.getElementById("wConnType_route");
	e.innerHTML = _("wConnType_route");
			e = document.getElementById("nat_enabletitle");
	e.innerHTML = _("wan_enabletitle");
			e = document.getElementById("nat_disabletitle");
	e.innerHTML = _("wan_disabletitle");
				e = document.getElementById("dns_enabletitle");
	e.innerHTML = _("wan_enabletitle");
			e = document.getElementById("dns_disabletitle");
	e.innerHTML = _("wan_disabletitle")
			e = document.getElementById("wan_enable_tip");
	e.innerHTML = _("wan_enabletitle");
			e = document.getElementById("wan_disable_tip");
	e.innerHTML = _("wan_disabletitle")
			e = document.getElementById("wan_enableTitle");
	e.innerHTML = _("WAN Enable")

	
	
	e = document.getElementById("wan_connectionTypeTitle");
	e.innerHTML = _("wan_connectionTypeTitle");
	e = document.getElementById("wan_priorityTitle");
	e.innerHTML = _("wan_priorityTitle");
		e = document.getElementById("lan_dns_relay");
	e.innerHTML = _("lan_dns_relay");
	e = document.getElementById("wan_FE_title");
	e.innerHTML = _("wan_FE_title");
	/*e = document.getElementById("wan_SSID_title");
	e.innerHTML = _("wan_SSID_title");*/
	
	e = document.getElementById("wConnectionType");
	e.innerHTML = _("wan connection type");
	e = document.getElementById("wConnTypeStatic");
	e.innerHTML = _("wan connection type static");
	e = document.getElementById("wConnTypeDhcp");
	e.innerHTML = _("wan connection type dhcp");
	e = document.getElementById("wConnTypePppoe");
	e.innerHTML = _("wan connection type pppoe");
	
	e = document.getElementById("wStaticMode");
	e.innerHTML = _("wan static mode");
	e = document.getElementById("wStaticIp");
	e.innerHTML = _("inet ip");
	e = document.getElementById("wStaticNetmask");
	e.innerHTML = _("inet netmask");
	e = document.getElementById("wStaticGateway");
	e.innerHTML = _("inet gateway");
	e = document.getElementById("wStaticPriDns");
	e.innerHTML = _("inet pri dns");
	e = document.getElementById("wStaticSecDns");
	e.innerHTML = _("inet sec dns");

	e = document.getElementById("wDhcpMode");
	e.innerHTML = _("wan dhcp mode");
	//e = document.getElementById("wDhcpHost");
	//e.innerHTML = _("inet hostname");

	e = document.getElementById("wPppoeMode");
	e.innerHTML = _("wan pppoe mode");
	e = document.getElementById("wPppoeUser");
	e.innerHTML = _("inet user");
	e = document.getElementById("wPppoePassword");
	e.innerHTML = _("inet password");

	e = document.getElementById("wPppoeOPMode");
	e.innerHTML = _("wan protocol opmode");
	e = document.getElementById("wPppoeKeepAlive");
	e.innerHTML = _("wan protocol opmode keepalive");
//	e = document.getElementById("wPppoeOnDemand");
//	e.innerHTML = _("wan protocol opmode ondemand");
	e = document.getElementById("wPppoeManual");
	e.innerHTML = _("wan protocol opmode manual");
	
	/* add begin by 吴小娟, 20110601, 原因: 增加DHCP连接IP、DNS等*/
	e = document.getElementById("wDhcpCon_ip_title");
	e.innerHTML = _("wDhcpCon_ip_title");
	e = document.getElementById("wDhcpCon_mask_title");
	e.innerHTML = _("wDhcpCon_mask_title");
	e = document.getElementById("wDhcpCon_gateway_title");
	e.innerHTML = _("wDhcpCon_gateway_title");
	e = document.getElementById("wDhcpCon_priDNS_title");
	e.innerHTML = _("wDhcpCon_priDNS_title");
	e = document.getElementById("wDhcpCon_secDNS_title");
	e.innerHTML = _("wDhcpCon_secDNS_title");
	//e = document.getElementById("Option60value_title");
	//e.innerHTML = _("Option60value_title");
	
	/* add end by 吴小娟, 20110601 */

	/* add begin by 吴小娟, 20110510, 原因: 增加PPPOE连接状态及IP、DNS等*/
	e = document.getElementById("wPppoeCon_status_title");
	e.innerHTML = _("wPppoeCon_status_title");
	e = document.getElementById("wPppoeCon_ip_title");
	e.innerHTML = _("wPppoeCon_ip_title");
	e = document.getElementById("wPppoeCon_mask_title");
	e.innerHTML = _("wPppoeCon_mask_title");
	e = document.getElementById("wPppoeCon_gateway_title");
	e.innerHTML = _("wPppoeCon_gateway_title");
	e = document.getElementById("wPppoeCon_priDNS_title");
	e.innerHTML = _("wPppoeCon_priDNS_title");
	e = document.getElementById("wPppoeCon_secDNS_title");
	e.innerHTML = _("wPppoeCon_secDNS_title");
	e = document.getElementById("wPppoeCon_retryPeriod_title");
	e.innerHTML = _("wPppoeCon_retryPeriod_title");
		
	e = document.getElementById("wPppoeCon_userTips");
	e.innerHTML = _("wPppoeCon_userTips");
	e = document.getElementById("wPppoeCon_pwdTips");
	e.innerHTML = _("wPppoeCon_pwdTips");
	e = document.getElementById("wPppoeCon_retryPeriod_tips");
	e.innerHTML = _("wPppoeCon_retryPeriod_tips");
		
	/* add end by 吴小娟, 20110510 */

	/* add begin by 吕轶超, 20130220, 原因:ipv6相关参数 */
	e = document.getElementById("wStaticIpv6");
	e.innerHTML = _("wStaticIpv6");
	e = document.getElementById("Prefix_Length_title");
	e.innerHTML = _("Prefix_Length_title");
	e = document.getElementById("wStaticGateway_ipv6");
	e.innerHTML = _("wStaticGateway_ipv6");
	e = document.getElementById("wStaticSecDns_ipv6");
	e.innerHTML = _("wStaticSecDns_ipv6");
	e = document.getElementById("wStaticPriDns_ipv6");
	e.innerHTML = _("wStaticPriDns_ipv6");
    e = document.getElementById("Address/Prefix_title");
	e.innerHTML = _("Address/Prefix_title");
	    e = document.getElementById("Address/Prefix_title1");
	e.innerHTML = _("Address/Prefix_title");
	    e = document.getElementById("Address/Prefix_title_pppoe");
	e.innerHTML = _("Address/Prefix_title_pppoe");
	/* add end by 吕轶超, 20130220 */
	
	
	e = document.getElementById("wApply");
	e.value = _("inet apply");
	e = document.getElementById("wCancel");
	e.value = _("inet cancel");
}


function LoadFrame()
{ 
	initTranslation();
	var fw_ruletable = getElement("fw_ruletable");

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	
	else
	{	
		var row0 = getElement("fw_ruletable").rows[0];

		//alert("wan_line = " + wan_line);
		/*修改哪条数据显示哪条数据*/

		if(parseInt(wan_line) == 1)
		{
			selectLine("record_1");
		}
		else if (parseInt(wan_line) == 0)
		{
			selectLine("record_0");
		}
		else if(parseInt(wan_line) == 2)
		{
		    selectLine("record_2");
		}
		else if(parseInt(wan_line) == 3)
		{
		    selectLine("record_3");
		}
		else
		{
			wan_line = 0;
			selectLine("record_0");
		}

		if(parseInt(wan_line) >= pf_ruleSum)
		{
			wan_line = 0;
			selectLine("record_0");
		}
	
		setDisplay("ConfigForm1", "");
	}
    //alert("wan_line = " + wan_line);
	showDate(wan_line);
	if(pf_ruleSum == 0)
	{	
		setDisplay("static", "none");
		setDisplay("dhcp", "none");
		setDisplay("pppoe", "none");
	}
	
	document.getElementById("wan_feBox2").disabled = 1;
	document.getElementById("wan_feBox3").disabled = 1;
	document.getElementById("wan_feBox4").disabled = 1;
	if(parseInt(lan_port_num) >= 1)
	{
		document.getElementById("wan_feBox1").disabled = 0;
	}
	if(parseInt(lan_port_num) >= 2)
	{
		document.getElementById("wan_feBox2").disabled = 0;
	}
	if(parseInt(lan_port_num) >= 3)
	{
		document.getElementById("wan_feBox3").disabled = 0;
	}
	if(parseInt(lan_port_num) >= 4)
	{
		document.getElementById("wan_feBox4").disabled = 0;
	}
								          
	//if(document.getElementById("wan_connectionmode").options.selectedIndex != 0)		
	//{
//		connectionTypeSwitch();
//	}
}




function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen > 6)
	{		
//   		alert("最多只能创建5条规则!");
 		alert(_("pf_mostRulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//新建
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//原无用户
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay("ConfigForm1", "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	} 
	selectLine("record_new");
	Tr069Wan_style(1);
	document.getElementById("wan_connectionmode").options.selectedIndex = 1;
	document.getElementById("nat_enable").options.selectedIndex = 0;
	document.getElementById("dns_enable").options.selectedIndex = 0;
	WanIndexSwitch(1);
	document.getElementById("wan_vid").focus();
	//connectionTypeSwitch(0);
	setDisplay("apply_table", "");
}

function selectLine(id)
{
	var objTR = getElement(id);
	var wanFEBoxNode = getElement("wan_feBox");
	//var wanSsidBoxNode = getElement("wan_ssidBox");
	var wan_mode = document.getElementById("wan_connectionmode");

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		currentline = temp;
		if (temp == 'new')		//新建
		{					
			document.getElementById("wan_vid").value = "";
			document.getElementById("wan_priority").value = "";	
			document.getElementById("wan_enable").value = 1;
			document.getElementById("ipModel").value = 0;
			document.getElementById("wDhcpCon_ip").value = "";
			document.getElementById("wDhcpCon_mask").value = "";
			document.getElementById("wDhcpCon_gateway").value = "";
			document.getElementById("wDhcpCon_priDNS").value =  "";
			document.getElementById("wDhcpCon_secDNS").value = "";
			//document.getElementById("option60_value").value = "";
			/*wanSsidBoxNode[0].checked =  false;
			wanSsidBoxNode[1].checked =  false;
			wanSsidBoxNode[2].checked =  false;
			wanSsidBoxNode[3].checked =  false;*/
		     wanFEBoxNode[0].checked =  false;
			//wanFEBoxNode.checked =  false;
			 wanFEBoxNode[1].checked =  false;
			 wanFEBoxNode[2].checked =  false;
			 wanFEBoxNode[3].checked =  false;
			setLineHighLight(objTR); 
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			//alert("temp = " + temp);
			splitDate();
			showFESSID(temp)	;
			showDate(temp);		
			Tr069Wan_style(wan_mode.options.selectedIndex);
            setLineHighLight(objTR);	
	
		}	

		//标志当前编辑规则的id
		document.getElementById("fw_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('fw_curIndex').value);
		
	}	 
}

function clickRemove(tabTitle)
{

//   alert("ruleSum = " + pf_ruleSum);
	if(pf_ruleSum  == 0)
	{			
//   		alert("当前没有规则，不能删除!");
 		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pf_removeFlag');
    var noChooseFlag = true;
//	var value = checkNodes.getValue();		//判断是否全选了，如果全选了，调用ipFilterDeleteAll
//	console.info("value.length = " + value.length);
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				noChooseFlag = false;
				break;
			}
		}
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
//		alert('请先选择一条规则');
		alert(_("pf_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("你确认删除所选规则?") == false)
	if(confirm(_("pf_deleteRuleConfirm")) == false)
    	return;
	
	getElement("fw_ruleForm").submit();
	
}

function VIDLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 4094)
		{
			return true;
		}
		else
		{
			alert(_("VID_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("VID_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}
function PriorityLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 7)
		{
			return true;
		}
		else
		{
			alert(_("priority_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("priority_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkIpAddr(field, ismask)
{
	/* modify begin by 吴小娟, 20110503, 原因: 子网掩码校验范围不正确，
	    本次修改将所有校验改为采用专用的JS校验文件checkValue.js*/
	if (!CheckNotNull(field.value)) {
		//alert("Error! IP address is empty.");
		alert(_("wan_IPempty"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	if (ismask) {		
		if(!validateMask(field.value))
		{
			//alert('subnet mask is illegal!');
			alert(_("wan_mask_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}		
	}
	else {
		if (!validateIP(field.value))
		{
			//alert('IP adress is illegal!');
			alert(_("wan_ip_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	return true;
	/* modify end by 吴小娟, 20110503 */
}

function checkWanRepeat(temp)
{
	var wan_connectionmode = document.getElementById("wan_connectionmode");
	var wan_vid = document.getElementById("wan_vid");
	var wan_mode = document.getElementById("wan_connectionmode");
	var wanFEBoxNode = getElement("wan_feBox");
	var k = 0;
	var i = 0;
	//alert("temp = " + temp);
	if(pf_ruleSum > 0)
	{
		for(k = 0; k < pf_ruleSum; k++)
	    {
			if(temp != 'new') /*修改wan*/
			{
				//alert("k = " + k);
				if(temp != k)
				{
					if(wan_connectionmode.value == modeArray[k]) /*wan类型不能一样*/
					{
						alert(_("this wan mode have exist!"));
						return false;
					}
					if(wan_vid.value == VIDArray[k])/*vid 不能一样*/
					{
						alert(_("this VID have exist!"));
						return false;						
					}

					
					if((wan_mode.options.selectedIndex == 1) || (wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 3) || (wan_mode.options.selectedIndex == 5))
					{
						for(i = 0; i< 4; i++)
						{
							if(wanFEBoxNode[i].checked == true)
							{
								if(feArray[k].split(",")[i] == 1)
								{
									alert(_("该端口已经被绑定。"));
									return false;
								}
							}
						}
					}

				   if(modeArray[k] == 1)/*非当前修改wan中存在INTERNET WAN*/
				   {
						if((wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 5))
						{
							alert("已经存在INTERNET相关的WAN链接!");
							return false;
						}

				   }

				   if(modeArray[k] == 2)/*非当前修改wan中存在INTERNET_TR069 WAN*/
				   {
						if((wan_mode.options.selectedIndex == 1) || (wan_mode.options.selectedIndex == 5))
						{
							alert("已经存在INTERNET相关的WAN链接!");
							return false;
						}

				   }

				   if(modeArray[k] == 5) /*非当前修改wan中存在INTERNET_VOIP WAN*/
				   {
						if((wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 1))
						{
							alert("已经存在INTERNET相关的WAN链接!");
							return false;
						}

				   }		

					
				}
			}
			else
			{	
					if(wan_connectionmode.options.selectedIndex == modeArray[k])/*wan类型不能一样*/
					{
						alert(_("this wan mode have exist!"));
						return false;
					}
					if(wan_vid.value == VIDArray[k])/*vid 不能一样*/
					{
						alert(_("this VID have exist!"));
						return false;						
					}

					if((wan_mode.options.selectedIndex == 1) || (wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 3) || (wan_mode.options.selectedIndex == 5))
					{
						for(i = 0; i< 4; i++)
						{
							if(wanFEBoxNode[i].checked == true)
							{
								if(feArray[k].split(",")[i] == 1)
								{
									alert(_("该端口已经被绑定。"));
									return false;
								}
							}
						}
					}

					
				   if(modeArray[k] == 1) /*所有wan中存在INTERNET WAN*/
				   {
						if((wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 5))
						{
							alert("已经存在INTERNET相关的WAN链接!");
							return false;
						}

				   }

				   if(modeArray[k] == 2)/*所有wan中存在INTERNET_TR069 WAN*/
				   {
						if((wan_mode.options.selectedIndex == 1) || (wan_mode.options.selectedIndex == 5))
						{
							alert("已经存在INTERNET相关的WAN链接!");
							return false;
						}

				   }

				   if(modeArray[k] == 5)/*所有wan中存在INTERNET_VOIP WAN*/
				   {
						if((wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 1))
						{
							alert("已经存在INTERNET相关的WAN链接!");
							return false;
						}

				   }
			}
		}
	}
	return true;

}

function checkValue()
{
	var vlan_id = getElement("wan_vid");
	var vprioriry = getElement("wan_priority");
	var wan_mode = document.getElementById("wan_connectionmode");
	var wan_type  = document.getElementById("wan_connectionType");
	var connectionType =  document.getElementById("ipModel");
	var staticIp_v =  document.getElementById("staticIp");
	var staticNetmask_v =  document.getElementById("staticNetmask");
	var staticGateway_v =  document.getElementById("staticGateway");
	var staticPriDns_v =  document.getElementById("staticPriDns");
	var staticSecDns_v =  document.getElementById("staticSecDns");
	var pppoeUserNode = document.getElementById("pppoeUser");
	var pppoePassNode = document.getElementById("pppoePass");
	var pppoeOPModeNode = document.getElementById("pppoeOPMode");
	var pppoeRetryPeriod = document.getElementById("pppoeRetryPeriod");
	var pppoeOPMode = document.getElementById("pppoeOPMode");
	var v4_v6_mode = document.getElementById("ipv6_enable");

	var DS_Lite_mode = document.getElementById("DS_Lite_enable");
	var AFTR_mode = document.getElementById("AFTR_enable");
	var AFTR_value_node = document.getElementById("AFTR_value");
	var staticIp_v6_node =  document.getElementById("staticIp_ipv6");
	var Ipv6_len_node =  document.getElementById("Prefix_Length");
	var Ipv6_Gateway_node =  document.getElementById("IPv6_Gateway");
	var Ipv6_Pri_DNS_node =  document.getElementById("IPv6_Pri_DNS");
	var IPv6_prefix_node =  document.getElementById("IPv6_prefix");

   if(!checkWanRepeat(currentline))
   {
		return false;
   }
   if(!VIDLegal(vlan_id))
   {
		return false;
   }
   if(!PriorityLegal(vprioriry))
   {
		return false;
   }

			
	if((v4_v6_mode.options.selectedIndex == 2)  && (wan_type.options.selectedIndex == 1) 
		&& (DS_Lite_mode.options.selectedIndex == 1) && (AFTR_mode.options.selectedIndex == 1))
	{	
		if (!CheckNotNull(AFTR_value_node.value)) 
		{
			alert(_("ipv6AFTRAlert"));
			AFTR_value_node.value = AFTR_value_node.defaultValue;
			AFTR_value_node.focus();
			return false;
		}
	}
	
   if ((connectionType.value == 1) && (wan_type.value == 1)) /*static */
   {
   		if((v4_v6_mode.options.selectedIndex == 0))
   		{
			if (!checkIpAddr(staticIp_v, false))
				return false;
			if (!checkIpAddr(staticNetmask_v, true))
				return false;
			if (staticGateway_v.value != "")
				if (!checkIpAddr(staticGateway_v, false))
					return false;
			if (staticPriDns_v.value != "")
				if (!checkIpAddr(staticPriDns_v, false))
					return false;
			if (staticSecDns_v.value != "")
				if (!checkIpAddr(staticSecDns_v, false))
					return false;

			if (!CheckNotNull(staticIp_v6_node.value)) 
			{					
				alert(_("ipv6Alert"));
				staticIp_v6_node.value = staticIp_v6_node.defaultValue;
				staticIp_v6_node.focus();
				return false;
			}
			if(!fw_checkv6Len(Ipv6_len_node))
			{
				return false;
			}
			if (!CheckNotNull(Ipv6_Gateway_node.value)) 
			{					
				alert(_("ipv6GWAlert"));
				Ipv6_Gateway_node.value = Ipv6_Gateway_node.defaultValue;
				Ipv6_Gateway_node.focus();
				return false;
			}
			if (!CheckNotNull(Ipv6_Pri_DNS_node.value)) 
			{					
				alert(_("ipv6dnsAlert"));
				Ipv6_Pri_DNS_node.value = Ipv6_Pri_DNS_node.defaultValue;
				Ipv6_Pri_DNS_node.focus();
				return false;
			}
			if (!CheckNotNull(IPv6_prefix_node.value)) 
			{					
				alert(_("ipv6prefixAlert"));
				IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
				IPv6_prefix_node.focus();
				return false;
			}
   		}
		else if( (v4_v6_mode.options.selectedIndex == 1))
		{
			if (!checkIpAddr(staticIp_v, false))
				return false;
			if (!checkIpAddr(staticNetmask_v, true))
				return false;
			if (staticGateway_v.value != "")
				if (!checkIpAddr(staticGateway_v, false))
					return false;
			if (staticPriDns_v.value != "")
				if (!checkIpAddr(staticPriDns_v, false))
					return false;
			if (staticSecDns_v.value != "")
				if (!checkIpAddr(staticSecDns_v, false))
					return false;
		}
		else if((v4_v6_mode.options.selectedIndex == 2))
		{

			if (!CheckNotNull(staticIp_v6_node.value)) 
			{					
				alert(_("ipv6Alert"));
				staticIp_v6_node.value = staticIp_v6_node.defaultValue;
				staticIp_v6_node.focus();
				return false;
			}
			if(!fw_checkv6Len(Ipv6_len_node))
			{
				return false;
			}
			if (!CheckNotNull(Ipv6_Gateway_node.value)) 
			{					
				alert(_("ipv6GWAlert"));
				Ipv6_Gateway_node.value = Ipv6_Gateway_node.defaultValue;
				Ipv6_Gateway_node.focus();
				return false;
			}
			if (!CheckNotNull(Ipv6_Pri_DNS_node.value)) 
			{					
				alert(_("ipv6dnsAlert"));
				Ipv6_Pri_DNS_node.value = Ipv6_Pri_DNS_node.defaultValue;
				Ipv6_Pri_DNS_node.focus();
				return false;
			}
			if (!CheckNotNull(IPv6_prefix_node.value)) 
			{					
				alert(_("ipv6prefixAlert"));
				IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
				IPv6_prefix_node.focus();
				return false;
			}

		}
   }

   else if ((connectionType.value == 2) && (wan_type.value == 1))/*PPPOE*/
   { 
	   	
		if (!CheckNotNull(pppoeUserNode.value)) 
		{					
			alert(_("wPppoeCon_userNullAlert"));
			pppoeUserNode.value = pppoeUserNode.defaultValue;
			pppoeUserNode.focus();
			return false;
		}
		
		if (!CheckNotNull(pppoePassNode.value)) 
		{					
			alert(_("wPppoeCon_pwdNullAlert"));
			pppoePassNode.value = pppoePassNode.defaultValue;
			pppoePassNode.focus();
			return false;
		} 

		if ((pppoeOPModeNode.options.selectedIndex == 0) || (pppoeOPModeNode.options.selectedIndex == 1))//Keep Alive
		{
			if (pppoeRetryPeriod.value == "")
			{
				alert(_("wPppoeCon_noretryperiod"));
				pppoeRetryPeriod.focus();
				pppoeRetryPeriod.select();
				return false;
			}

			else if(!(/^[\d]{1,5}$/.test(pppoeRetryPeriod.value)))	//1-5位数字
			{
				alert(_("wPppoeCon_retryPeriodIllegalAlert"));
				pppoeRetryPeriod.focus();
				pppoeRetryPeriod.select();
				return false;
			}

			if(pppoeRetryPeriod.value < 10)
			{
				alert(_("wPppoeCon_retryPeriodIllegalAlert"));
				pppoeRetryPeriod.focus();
				pppoeRetryPeriod.select();
				return false;
			}
		}
		
	}

   if(voip_port_num == 0)
   {
		if((wan_mode.options.selectedIndex == 5) || (wan_mode.options.selectedIndex == 4))
		{
			alert("该设备没有VOIP配置，不能配置VOIP相关的WAN连接。");
			return false;
		}

   }
   if((modeWan0Array == 0) || (modeWan1Array == 0) || (modeWan2Array == 0) || (modeWan3Array == 0))
   {
		if(wan_mode.options.selectedIndex == 2)
		{
			alert("已经存在TR069相关的WAN链接!");
			return false;
		}

   }

	var wanFEBoxNode = getElement("wan_feBox");
   	if((wan_mode.options.selectedIndex == 1) || (wan_mode.options.selectedIndex == 2) || (wan_mode.options.selectedIndex == 5))
   	{
			if((wanFEBoxNode[0].checked == false) && (wanFEBoxNode[1].checked == false) && (wanFEBoxNode[2].checked == false) && (wanFEBoxNode[3].checked == false))
			{
				alert("请绑定端口!");
				return false;
			}
   	}
	else if((wan_mode.options.selectedIndex == 3))
	{
		if(wan_type.options.selectedIndex == 0)
		{
			if((wanFEBoxNode[0].checked == false) && (wanFEBoxNode[1].checked == false) && (wanFEBoxNode[2].checked == false) && (wanFEBoxNode[3].checked == false))
			{
				alert("请绑定端口!");
				return false;
			}

		}
	}
   
	/*var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
    if(WifiFlag == 0)
    {
    	if((wanSsidBoxNode[0].checked == true) || (wanSsidBoxNode[1].checked == true) || (wanSsidBoxNode[2].checked == true) || (wanSsidBoxNode[3].checked == true))
 		{
 			alert(_("wifi_band_alert"));
			wanSsidBoxNode[0].checked = false;
			wanSsidBoxNode[1].checked = false;
			wanSsidBoxNode[2].checked = false;
			wanSsidBoxNode[3].checked = false;
 			return false;
    	}
    }
    if(have_1_port == 1)
    {
		if((wanFEBoxNode[1].checked == true) || (wanFEBoxNode[2].checked == true) || (wanFEBoxNode[3].checked == true))
	    {
			alert(_("1_port_band_alert"));
			wanFEBoxNode[1].checked = false;
			wanFEBoxNode[2].checked = false;
			wanFEBoxNode[3].checked = false;
			return false;
		}
    }*/
}

function fw_checkv6Len(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 64)
		{
			return true;
		}
		else
		{
			alert(_("v6len_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("v6len_portIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

var previousTR = null;
function setLineHighLight(objTR)
{
    if (previousTR != null)
	{
	    previousTR.style.backgroundColor = '#f4f4f4';
		for (var i = 0; i < previousTR.cells.length; i++)
		{
			previousTR.cells[i].style.color = '#000000';
		}
	}
	
	objTR.style.backgroundColor = '#B7E3E3';//c7e7fe
	for (var i = 0; i < objTR.cells.length; i++)
	{
		objTR.cells[i].style.color = '#000000';		
	}
	previousTR = objTR;
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wan_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td height="22" width="7"></td>
              <td align="center" valign="bottom" width="120"></td>
              <td width="7"></td>
              <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                  <tbody>
                    <tr>
                      <td><input type="button" value="新增" id="fw_add" class="submit" onClick="clickAdd('fw_ruleList');"></td>
                      <td><input type="button" value="删除" id="fw_delete" class="submit" onClick="clickRemove('fw_ruleList');"></td> 
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/WanTr069Delete">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="WANListHead">WAN List</td>
              </tr>
              <tr class="tabal_title">
		        <td width="40%" align="center" id="WAN_nameTitle">WAN Name</td>
		        <td width="20%" align="center" id="WAN_VIDtitle">VID/Priority</td>
		        <td width="20%" align="center" id="WAN_ipmode">WAN IP Mode</td>
		        <td width="7%" align="center" ></td>
		        <td width="2%" align="center" ></td>  
              </tr>

				<% WanTr069Sync(); %>
              
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/WanTr069Cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td ><div id="div_pf_rule">
                              <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                                <tbody>
                                <tr style="">
									        <td id="wan_enableTitle" class="tabal_left" width="25%">WAN Enable</td>
									        <td class="tabal_right" ><select name="wan_enable" id="wan_enable" size="1" style="width:200px;">
									            <option value="1" id="wan_enable_tip">Enable</option>
									            <option value="0" id="wan_disable_tip">Disable</option>
									          </select>
									        </td>
									        
									      </tr>
                                  <tr style="">
                                    <td id="wan_servicetypeTitle" class="tabal_left" width="25%">Service Type</td>
                                    <td class="tabal_right" ><select name="wan_connectionmode" id="wan_connectionmode" size="1" style="width:200px;" onChange="WanIndexSwitch(this.value);">
                                        <option value="0" selected="selected">TR069</option>
                                        <option value="1">INTERNET</option>
                                        <option value="2">TR069_INTERNET</option>
                                        <option value="3">Other</option>
                                        <option value="4">VOIP</option>
                                        <option value="5">VOIP_INTERNET</option>
                                      </select></td>
                                  </tr>
									<tr style="">
									        <td width="25%" class="tabal_left" id="wan_connectionTypeTitle">Connection Type</td>
									        <td class="tabal_right"><select name="wan_connectionType" id="wan_connectionType" size="1" style="width:200px;"  onChange="ConnectTypeSwitch(this.value);" >
									            <option value="0" id="wConnType_bridge" selected="selected" >Bridge</option>
									            <option value="1" id="wConnType_route"  >Route</option>
									          </select>
									        </td>
									  </tr>

                                  <tr style="">
                                    <td id="wan_vid_title" class="tabal_left" width="25%">VLAN ID</td>
                                    <td class="tabal_right" width="75%"><input name="wan_vid" id="wan_vid" size="15"  style="width: 150px;" type="text">   
                                  </tr>
                                                                  
                                  <tr style="">
                                    <td id="wan_priorityTitle" class="tabal_left" width="25%">Priority</td>
                                    <td class="tabal_right" width="75%"><input name="wan_priority" id="wan_priority" size="15"  style="width: 150px;" type="text">   
                                  </tr>
                                 <table id="nat_dns" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								    <tbody>
                                  <tr style="">
                                    <td class="tabal_left" width="25%">NAT</td>
                                    <td class="tabal_right" width="75%"><select name="nat_enable" id="nat_enable" size="1" style="width:14%" >
                                        <option value="1" id="nat_enabletitle" selected="selected">Enable</option>
                                        <option value="0" id="nat_disabletitle" >Disable</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="lan_dns_relay" class="tabal_left" width="25%">DNS Relay</td>
                                    <td class="tabal_right" width="75%"><select name="dns_enable" id="dns_enable" size="1" style="width:14%" >
                                        <option value="1" id="dns_enabletitle" selected="selected">Enable</option>
                                        <option value="0" id="dns_disabletitle" >Disable</option>
                                      </select></td>
                                  </tr>
                                        </tbody>
                                 </table>
                                </tbody>
                              </table>
                               <table id="port_bang" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								    <tbody>
								      <tr style="">
								        <td width="25%" class="tabal_left" id="wan_FE_title"> LAN Binding</td>
								        <td class="tabal_right" ><span>LAN 1</span>
								          <input type="checkbox" name="wan_feBox" id="wan_feBox1" value="1">
								          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
								          <input type="checkbox" name="wan_feBox" readonly="readonly" id="wan_feBox2" value="2">
								          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
								          <input type="checkbox" name="wan_feBox" readonly="readonly" id="wan_feBox3" value="4">
								          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
								          <input type="checkbox" name="wan_feBox" readonly="readonly" id="wan_feBox4" value="8">
								        <td>
								      </tr>
								      <!--tr style="">
								        <td width="25%" class="tabal_left" id="wan_SSID_title">SSID绑定: </td>
								        <td class="tabal_right"><span>SSID 1</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox1" value="1">
								          &nbsp;&nbsp; <span>SSID 2</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox2" value="2">
								          &nbsp;&nbsp; <span>SSID 3</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox3" value="4">
								          &nbsp;&nbsp; <span>SSID 4</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox4" value="8">
								        </td-->
								      </tr>
								    </tbody>
								  </table>
								    </table>
									  <table id="wan_ipv6enable" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
									    <tbody>
									      <tr style="">
									        <td width="25%" class="tabal_left"  id="wIP_mode_title">IP模式</td>
									        <td class="tabal_right"><select name="ipv6_enable" id="ipv6_enable" size="1" style="width:200px;" onChange="ipv6_enableSwitch();">
					 							<option value="3" id="wIP_mode_3_tip">IPv4&IPv6</option>
									            <option value="1" id="wIP_mode_1_tip" selected="selected">IPv4</option>
									            <option value="2" id="wIP_mode_2_tip" >IPv6</option>
									          </select>
									        </td>
									        
									      </tr>
									    </tbody>
									  </table>
									  <table id="wan_ipv6mode" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
									    <tbody>
									      <tr style="">
									        <td width="25%" class="tabal_left" >IP 模式</td>
									        <td class="tabal_right"><select name="ipv6_enable1" id="ipv6_enable1" size="1" style="width:200px;" >
									            <option value="1" selected="selected">IPv4</option>
									          </select>
									        </td>
									        
									      </tr>
									    </tbody>
									  </table>
								    <table id="tb_wanIPModel" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								    <tbody>
								      <tr style="">
								        <td width="25%" class="tabal_left" id="wConnectionType">WAN IP Type: </td>
								        <td class="tabal_right"><select name="ipModel" id="ipModel" size="1" style="width:200px;" onChange="connectionTypeSwitch();">
 											<option value="0" id="wConnTypeDhcp" selected="selected">DHCP</option>
								            <option value="1" id="wConnTypeStatic">Static</option>  
								            <option value="2" id="wConnTypePppoe">PPPoE</option>
								          </select>
								        </td>
								      </tr>
												 <table id="dsline_ipv6_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								           			<tr style="">
											        <td width="25%" class="tabal_left" id="wConnectionType">DS-Lite: </td>
											        <td class="tabal_right"><select name="DS_Lite_enable" id="DS_Lite_enable" size="1" style="width:200px;" onChange="DsliteSwitch();">
											            <option value="0"  selected="selected">关闭</option>
											            <option value="1" >启用</option>   
											          </select>
											        </td>
											      </tr>
											      </tbody>
												</table>
													<table id="AFTR_ipv6_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								           			<tr style="">
											        <td width="25%" class="tabal_left" >AFTR手工配置: </td>
											        <td class="tabal_right"><select name="AFTR_enable" id="AFTR_enable" size="1"  style="width:200px;" onChange="AFTRSwitch();">
												         <option value="0"  selected="selected">关闭</option>
											             <option value="1" >启用</option>   
											          </select>
											        </td>
											      </tr>
											      </tbody>
												</table>
													<table id="AFTR_value_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								           			<tr style="">
											        <td width="25%" class="tabal_left" id="wConnectionType">AFTR: </td>
											        <td class="tabal_right" width="75%"><input name="AFTR_value" id="AFTR_value" size="15"  maxlength=40 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "aftr_value"); %>"> </td>  
											      </tr>
											      </tbody>
												</table>
								    </tbody>
								  </table>
								  <br>
								  <!-- ================= STATIC Mode ================= -->
								  <table id="static" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								    <tbody>
								      <tr class="tabal_head">
								        <td colspan="2" id="wStaticMode">Static Mode</td>
								      </tr>
								      <table id="static_ipv4_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
								      <tr>
								        <td class="tabal_left" width="25%" id="wStaticIp">IP Address</td>
								        <td class="tabal_right"><input name="staticIp" id="staticIp" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_ipaddr"); %>">
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticNetmask">Subnet Mask</td>
								        <td class="tabal_right"><input name="staticNetmask" id="staticNetmask" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_netmask"); %>">
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticGateway">Default Gateway</td>
								        <td class="tabal_right"><input name="staticGateway" id="staticGateway" maxlength=15 size=32
								  		value="<% getCfgGeneral(1, "wan_gateway"); %>">
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticPriDns">Primary DNS Server</td>
								        <td class="tabal_right"><input name="staticPriDns" id="staticPriDns" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_primary_dns"); %>"></td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticSecDns">Secondary DNS Server</td>
								        <td class="tabal_right"><input name="staticSecDns" id="staticSecDns" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_secondary_dns"); %>"></td>
								      </tr>  
										  </tbody>
										  </table>

										<table id="static_ipv6" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
										      <tr>
										        <td class="tabal_left" width="25%" id="wStaticIpv6">IPv6 Address</td>
										        <td class="tabal_right"><input name="staticIp_ipv6" id="staticIp_ipv6" maxlength=128 size=32 value="<% getCfgGeneral(1, "staticIp_ipv6"); %>">
										        </td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="Prefix_Length_title">IPv6 Prefix Length</td>
										        <td class="tabal_right"><input name="Prefix_Length" id="Prefix_Length" maxlength=128 size=32 value="<% getCfgGeneral(1, "Prefix_Length"); %>">
										         </td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="wStaticGateway_ipv6">Default Gateway</td>
										        <td class="tabal_right"><input name="IPv6_Gateway" id="IPv6_Gateway" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_Gateway"); %>">
										        </td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="wStaticPriDns_ipv6">Primary DNS Server</td>
										        <td class="tabal_right"><input name="IPv6_Pri_DNS" id="IPv6_Pri_DNS" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_Pri_DNS"); %>"></td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="wStaticSecDns_ipv6">Secondary DNS Server</td>
										        <td class="tabal_right"><input name="IPv6_Sec_DNS" id="IPv6_Sec_DNS" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_Sec_DNS"); %>"></td>
										      </tr>   
										      <tr>
										        <td class="tabal_left" width="25%" id="Address/Prefix_title1">IPv6 Address Mode</td>
										        <td class="tabal_right"><select name="Address/Prefix_static" id="Address/Prefix_static" size="1">
										            <option value="2" >静态</option>
										          </select>
										        </td>
										      </tr> 
										      	<tr>
										        <td class="tabal_left" width="25%" id="Prefix_title">IPv6前缀获取方式</td>
										        <td class="tabal_right"><select name="Prefix_static" id="Prefix_static" size="1">
										            <option value="2" >静态</option>		        
										          </select>
										        </td>
										      </tr> 
										      <tr>
										        <td class="tabal_left" >IPv6前缀:</td>
										        <td class="tabal_right"><input name="IPv6_prefix" id="IPv6_prefix" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_prefix"); %>"></td>
										      </tr> 
										    </tbody>
										  </table>
								      
								    </tbody>
								  </table>
								  <!-- ================= DHCP Mode ================= -->
								  <table id="dhcp" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								    <tbody>
								      <tr class="tabal_head">
								        <td colspan="2" id="wDhcpMode">DHCP Mode</td>
								      </tr>
								      <!--add begin by 吴小娟, 20110601, 原因: 新增DHCP连接IP等-->
									 <table id="dhcp_ipv4_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
								      <tr id="wDhcpCon_ip_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_ip_title">IP Address</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_ip" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_ip"); %>">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_mask_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_mask_title">Subnet Mask</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_mask" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_mask"); %>">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_gateway_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_gateway_title">Default Gateway</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_gateway" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_gateway"); %>">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_priDNS_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_priDNS_title">Primary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_priDNS" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_priDNS"); %>">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_secDNS_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_secDNS_title">Secondary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_secDNS" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_secDNS"); %>">
								        </td>
								      </tr>
								        </tbody>
										  </table>
									   <!--tr>
									        <td class="tabal_left" id="Option43Enable_title" align="left" width="25%">Option43:</td>
									        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1"  name="option43_enable" type="radio">
									          <font id="option43_enable_tip">Enable</font>
									          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									          <input value="0" name="option43_enable" type="radio">
									          <font id="option43_disable_tip">Disable</font> </td>
									    </tr>
									     <tr>
									         <td class="tabal_left" id="Option60Enable_title" align="left" width="25%">Option60:</td>
									         <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" id="option60_enable" name="option60_enable" type="radio">
									          <font id="option60_enable_tip">Enable</font>
									          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									          <input value="0" name="option60_enable" type="radio">
									          <font id="option60_disable_tip">Disable</font> </td>
									     </tr>
									     <tr id="wDhcpCon_secDNS_tr">
										        <td class="tabal_left" width="25%" id="Option60value_title">Option60 Value:</td>
										        <td class="tabal_right"><input type="text"   name="option60_value" id="option60_value" style="width:320px;" value="<% getCfgGeneral(1, "option60_value"); %>">
										        </td>
								         </tr-->
									
								      <table id="dhcp_ipv6" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
										      <tr>
										        <td class="tabal_left" width="25%" id="Address/Prefix_title">IPv6 Address Mode</td>
										        <td class="tabal_right"><select name="Address/Prefix_dhcp" id="Address/Prefix_dhcp" size="1">
								        			<option value="DHCPv6" >DHCPv6</option>
								          			<option value="AutoConfigured" selected="selected">自动配置</option>
										          </select>
										        </td>
										      </tr> 
										      	<tr>
										        <td class="tabal_left" width="25%" id="Prefix_title_dhcp">IPv6前缀获取方式</td>
										        <td class="tabal_right"><select name="Prefix_dhcp" id="Prefix_dhcp" size="1">
										            <option value="PrefixDelegation" >前缀代理</option>		        
										          </select>
										        </td>
										      </tr> 
										    </tbody>
										  </table>																		     
								    </tbody>
								  </table>
								  <!-- ================= PPPOE Mode ================= -->
								  <table id="pppoe" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								    <tbody>
								      <tr class="tabal_head">
								        <td colspan="2" id="wPppoeMode">PPPoE Mode</td>
								      </tr>
								       <!--tr>	
								        <td class="tabal_right"  width="25%"><input type='checkbox' id='route_brige_enable' name='route_brige_enable' value='1'></td>
								        <td class="tabal_left" id="wPppoeroute_briTips">启用PPPOE路由桥混合模式</td>
								      </tr-->
								      <tr>
								        <td class="tabal_left" width="25%" id="wPppoeUser">User Name</td>
								        <td class="tabal_right"><input name="pppoeUser" id="pppoeUser" maxlength=31 style="width:320px;">
								          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips">(1-31位字符)</span></td>
								      </tr>
								      <tr>
								        <td class="tabal_left" width="25%" id="wPppoePassword">Password</td>
								        <td class="tabal_right"><input type="password" name="pppoePass" id="pppoePass" maxlength=31 style="width:320px;" >
								          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips">(1-31位字符)</span></td>
								      </tr>
								      <!--tr>
								        <td class="tabal_left" width="25%" id="wPppoePass2">Verify Password</td>
								        <td class="tabal_right"><input type="password" name="pppoePass2" id="pppoePass2" maxlength=31 style="width:320px;"
								             value="<% getCfgGeneral(1, "wan_pppoe_pass"); %>"></td>
								      </tr-->
								      <tr>
								        <td class="tabal_left" width="25%" rowspan="2" id="wPppoeOPMode">Operation Mode</td>
								        <td class="tabal_right"><select name="pppoeOPMode" id="pppoeOPMode" size="1" onChange="pppoeOPModeSwitch()">
								            <option value="0" id="wPppoeKeepAlive" selected="selected">Keep Alive</option>
								            <option value="1" id="wPppoeManual1">有流量时连接</option>
								            <option value="2" id="wPppoeManual">Manual</option>
								          </select>
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_right" id="wPppoeCon_retryPeriod_td"> <span id="wPppoeCon_retryPeriod_title">Keep Alive Mode: Retry Period</span>
								          <input type="text" name="pppoeRetryPeriod" id="pppoeRetryPeriod" maxlength="5" size="3" value="<% getCfgGeneral(1, "wan_pppoe_optime"); %>">
								          <span id="wPppoeCon_retryPeriod_tips">Seconds (10-99999)</span>

								        </td>
								      </tr>
								      <!--add begin by 吴小娟, 20110427, 原因: 新增PPPOE连接状态及IP;20110510, 原因:新增PPPOE连接DNS等-->
								         <table id="pppoe_ipv4_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								       <tbody>
								      <tr>
								        <td class="tabal_left" width="25%" id="wPppoeCon_status_title">State</td>
								        <td class="tabal_right" id="wPppoeCon_status">&nbsp;</td>
								      </tr>
								      <tr id="wPppoeCon_ip_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_ip_title">IP Address</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_ip" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wPppoeCon_ip"); %>">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_mask_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_mask_title">Subnet Mask</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_mask" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wPppoeCon_mask"); %>">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_gateway_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_gateway_title">Default Gateway</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_gateway" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wPppoeCon_gateway"); %>">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_priDNS_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_priDNS_title">Primary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_priDNS" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wPppoeCon_priDNS"); %>">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_secDNS_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_secDNS_title">Secondary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_secDNS" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wPppoeCon_secDNS"); %>">
								        </td>
								      </tr>								       
								      </tbody>
								     </table>

								      
								          <table id="pppoe_ipv6" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								       <tbody>
								       <tr>
								        <td class="tabal_left" width="25%" id="Address/Prefix_title_pppoe">IPv6 Address Mode</td>
								        <td class="tabal_right"><select name="Address/Prefix_pppoe" id="Address/Prefix_pppoe" size="1">
								        	<option value="DHCPv6" >DHCPv6</option>
								            <option value="AutoConfigured" selected="selected">自动配置</option>
								          </select>
								        </td>
								      </tr>
								      	<tr>
								        <td class="tabal_left" width="25%" id="Prefix_title_pppoe">IPv6前缀获取方式</td>
								        <td class="tabal_right"><select name="Prefix_pppoe" id="Prefix_pppoe" size="1">
								        	<option value="PrefixDelegation" >前缀代理</option>
								          </select>
								        </td>
								      </tr>
								        </tbody>
								     </table>
								    </tbody>
								    <!--add end by 吴小娟, 20110427 -->
								  </table>
                            </div></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
              </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
    		<tbody>
    		  <tr>
    		    <td height="5"></td>
    		  </tr>
   			 </tbody>
 			 </table>
            <table id="apply_table" class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="wApply" id="wApply" class="submit">
                    <input type="reset" value="Cancel" name="wCancel" id="wCancel" class="submit" onClick="window.location.reload()">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="fw_curIndex" id="fw_curIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
</body>

