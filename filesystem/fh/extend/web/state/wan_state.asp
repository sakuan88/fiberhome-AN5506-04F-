<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Refresh" content="20">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/wan_state.js"></script>
<title>WAN STATE</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var previousTR = null;
var setWAN_IPV6InfoSync = '<% setWAN_IPV6InfoSync(); %>';
var setLanstateSync = '<% setLanstateSync(); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var get_wan_detail = '<% get_wan_detail(); %>';

var wan_num = '<% getCfgGeneral(1, "wan_num"); %>';
var wan_mac_buff = '<% getCfgGeneral(1, "wan_mac_buff"); %>';
var wan_gateway_buff = '<% getCfgGeneral(1, "wan_gateway_buff"); %>';
var uptime_buff = '<% getCfgGeneral(1, "uptime_buff"); %>';
var pppoe_state = '<% getCfgGeneral(1, "pppoe_state"); %>';

function initTranslation()
{
	var e = document.getElementById("wan_statePrompt");
	e.innerHTML = _("wanstate_prompt");

	e = document.getElementById("wanListHead");
	e.innerHTML = _("wanListHead");
	e = document.getElementById("wan_name");
	e.innerHTML = _("wan_name");
	e = document.getElementById("wan_state");
	e.innerHTML = _("wan_state");
	e = document.getElementById("wan_mode");
	e.innerHTML = _("wan_mode");
	e = document.getElementById("ip_mode");
	e.innerHTML = _("ip_mode");
	e = document.getElementById("wan_mask");
	e.innerHTML = _("wan_mask");
	e = document.getElementById("wan_vlan");
	e.innerHTML = _("wan_vlan");
	e = document.getElementById("wan_type");
	e.innerHTML = _("wan_type");
	e = document.getElementById("v6State");
	e.innerHTML = _("v6State");
	e = document.getElementById("wanIpv6");
	e.innerHTML = _("wanIpv6");
	e = document.getElementById("wanprefix");
	e.innerHTML = _("wanprefix");
	e = document.getElementById("gateway_v6");
	e.innerHTML = _("v6gateway");
	e = document.getElementById("wan_dns");
	e.innerHTML = _("wan_dns");
	e = document.getElementById("wan_dns2");
	e.innerHTML = _("wan_dns2");
	e = document.getElementById("v6State_title");
	e.innerHTML = _("v6State");
	e = document.getElementById("v6_address_title");    
	e.innerHTML = _("wanIpv6");
	e = document.getElementById("v6_state_title");
	e.innerHTML = _("wan_state");
	e = document.getElementById("v6_index_title");
	e.innerHTML = _("wan_name");
	e = document.getElementById("v6_IPMode_title");
	e.innerHTML = _("wan_mode");

	if(ispName == 12)/*厄瓜多尔 ipv6多wan*/
	{
		var V6_wan_num = '<% getCfgGeneral(1, "v6_wan_num"); %>';
		for(var i = 0; i < V6_wan_num; i++)
		{
			e = document.getElementById("ipv6_prefixTitle_" + i);
			e.innerHTML = _("wanprefix");
			e = document.getElementById("ipv6_gatewayTitle_" + i);
			e.innerHTML = _("v6gateway");
			e = document.getElementById("ipv6_priDNSTitle_" + i);
			e.innerHTML = _("wan_dns");
		}
	}	
}

function initValue()
{
	initTranslation();
	selectLine("record_0");
	
	var ipv6_enable_s = '<% getCfgGeneral(1, "ipv6_enable"); %>';/* 0:ipv4; 1:双栈 ;2:ipv6 */
	switch(parseInt(ipv6_enable_s))
	{
		case 0:
			setDisplay("tb_wanstate", "");
			setDisplay("ipv6_wan_state", "none");//无V6,不显示V6 WAN信息
			break;
		case 1:
			setDisplay("tb_wanstate", "");
			setDisplay("ipv6_wan_state", "");
			break;
		case 2:
			//delete by wuxj, 20180824, V6单栈时也需要显示V4表，用于显示其它WAN连接的信息
//			setDisplay("tb_wanstate", "none");	//无V4,不显示WAN状态表
			setDisplay("ipv6_wan_state", "");
			break;
		default:								//视为V4
			setDisplay("tb_wanstate", "");
			setDisplay("ipv6_wan_state", "none");
			break;
	}

	if((wan_num > 0) && (ispName == 9 || ispName == 15 || ispName == 26)) /*罗马尼亚版本\菲律宾GLOBE HGU\巴西TIM ，wan计数大于0*/
	{
		setDisplay("wan_state_table", "");
	}
	
	if(ispName == 12)/*厄瓜多尔 ipv6多wan*/
	{
		setDisplay("tb_wanstate", "");
		setDisplay("ipv6_mutiwan_state", "");
		setDisplay("ipv6_wan_state", "none");
	}
	var WEB_COMM_WAN_CFG = '<% getCfgGeneral(1, "WEB_COMM_WAN_CFG");%>';
	if(WEB_COMM_WAN_CFG == 1)
	{
		setDisplay("tb_wanstate", "");
		setDisplay("ipv6_wan_state", "");
	}

	if(ispName == 26)/* 巴西TIM Wan State 增加 Mac Address列*/
	{
		var ip_td = document.getElementById("ip_td");
		var wan_mask = document.getElementById("wan_mask");
		ip_td.width = "11%";
		wan_mask.width = "12%";
		setDisplay("td_wan_mac", "");	
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wan_statePrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="tb_wanstate" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="wanListHead">WAN State</td>
    </tr>
    <tr class="tabal_title">
      <td width="8%" align="center" id="wan_name">Index</td>
      <td width="9%" align="center" id="wan_state">State</td>
      <td width="10%" align="center" id="wan_mode">Mode</td>
      <td width="9%" align="center" id="ip_mode">IP Type</td>
      <td width="14%" align="center" id="ip_td">IP</td>
      <td width="15%" align="center" id="wan_mask">Mask</td>
      <td width="14%" align="center" >DNS</td>
      <td width="7%" align="center" id="wan_vlan">VLAN/Priority</td>
      <td width="14%" align="center" id="td_wan_mac" style="display: none">MAC Address</td>
      <td width="5%" align="center" id="wan_type">Connection Type</td>    
    </tr>
    <% setWANInfoSync(); %>
  </tbody>
</table>
<table  border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="wan_state_table" class="tabal_bg" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" >More Information</td>
    </tr>
    <tr id="tr_ppp_state" style="display: none;">
      <td class="tabal_left" width="25%">PPPoE State</td>
      <td class="tabal_right" id="ppp_stateDetail"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">WAN Mac</td>
      <td class="tabal_right" id="wan_mac"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Connection Uptime</td>
      <td class="tabal_right" id="wan_uptime"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Gateway</td>
      <td class="tabal_right" id="wan_gateway"></td>
    </tr>
  </tbody>
</table>
<table  id="ipv6_wan_state" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="v6State">IPv6 State</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wanIpv6">IPv6 Address</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_ip"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wanprefix">Prefix</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6Prefix"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="gateway_v6">Default Gateway</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_gateway"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wan_dns">Primary DNS Server</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_pridns"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wan_dns2">Secondary DNS Server</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_secdns"); %></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table  id="ipv6_mutiwan_state" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="v6State_title">IPv6 State</td>
    </tr>
    <tr class="tabal_title">
      <td width="8%" align="center" id="v6_index_title">Index</td>
      <td width="9%" align="center" id="v6_state_title">State</td>
      <td width="20%" align="center" id="v6_IPMode_title">Mode</td>
      <td width="63%"colspan="2" align="center"  id="v6_address_title">IPv6 Address</td>
    </tr>
    <% mutiwan_ipv6_sync(); %>
  <table  border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td height="22"></td>
      </tr>
    </tbody>
  </table>
  </tbody>
</table>
</body>
</html>