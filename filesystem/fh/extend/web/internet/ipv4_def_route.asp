<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>IPv4 default route</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<%cu_web_access_control();%>'
web_access_check(checkResult);
//web_access_check_admin(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("route", lang);

var v4_dr_sync = '<% v4_dr_sync(); %>';
var wanNameSync = '<% wanNameSync(); %>';

function initValue()
{
	initTranslation();	
	
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	
	var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
	var wannameArray = wanname_all.split("|");
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var wannameText_all;
	if(device_type == 0)	/* SFU */
	{
		wannameText_all = wanname_all;
	}
	else		
	{
		wannameText_all = '<% getCfgGeneral(1, "tr069_wan_name_all"); %>';
	}
	var wannameTextArray = wannameText_all.split("|");

	var ipv6_state = '<% getCfgGeneral(1, "ipv6_state"); %>';
	
	var v4_dr_wanNode = getElement("v4_dr_wan");
	var v6_dr_wanNode = getElement("v6_dr_wan");
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R") >= 0)//route wan
		{
			if(wannameArray[i].search("INTERNET") >= 0)//internet
			{
				//0:V4 1:V4/V6 2:V6
				if(ipv6_state == '0')
					v4_dr_wanNode.options[v4_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
				else if(ipv6_state == '1')
				{
					v4_dr_wanNode.options[v4_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
					v6_dr_wanNode.options[v6_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
				}
				else
					v6_dr_wanNode.options[v6_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
					
			}
			else
			{
				v4_dr_wanNode.options[v4_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);//new Option(text, value)
			}
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			v4_dr_wanNode.options[v4_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	showSelectNodeByValue(v4_dr_wanNode, '<% getCfgGeneral(1, "v4_dr_wan"); %>');
	showSelectNodeByValue(v6_dr_wanNode, '<% getCfgGeneral(1, "v6_dr_wan"); %>');
	
	var v4_dr_enable = '<% getCfgGeneral(1, "v4_dr_enable"); %>';
	showCheckboxNodeByValue(getElement("v4_dr_enable"), v4_dr_enable);
	clickV4DrEnable();
	
	var v6_dr_enable = '<% getCfgGeneral(1, "v6_dr_enable"); %>';
	showCheckboxNodeByValue(getElement("v6_dr_enable"), v6_dr_enable);
	clickV6DrEnable();
}
function clickV4DrEnable()
{
	var v4_dr_enableNode = getElement("v4_dr_enable");
	if(v4_dr_enableNode.checked == true)
	{
		getElement("v4_dr_wan").disabled = false;
		getElement("v4_dr_enableFlag").value = 1;	
	}
	else
	{
		getElement("v4_dr_wan").disabled = true;
		getElement("v4_dr_enableFlag").value = 0;
	}
}
function clickV6DrEnable()
{
	var v6_dr_enableNode = getElement("v6_dr_enable");
	if(v6_dr_enableNode.checked == true)
	{
		getElement("v6_dr_wan").disabled = false;
		getElement("v6_dr_enableFlag").value = 1;
	}
	else
	{
		getElement("v6_dr_wan").disabled = true;
		getElement("v6_dr_enableFlag").value = 0;
	}
}
function v4checkValue()
{
	var v4_dr_enableNode = getElement("v4_dr_enable");
	var v4_dr_wanNode = getElement("v4_dr_wan");
	if((v4_dr_enableNode.checked == true) && (v4_dr_wanNode.value == '0'))
	{
		alert(_("dr_wannameNUllAlert"));
		return false;
	}
	
	return true;
}
function v6checkValue()
{
	var v6_dr_enableNode = getElement("v6_dr_enable");
	var v6_dr_wanNode = getElement("v6_dr_wan");
	if((v6_dr_enableNode.checked == true) && (v6_dr_wanNode.value == '0'))
	{
		alert(_("dr_wannameNUllAlert"));
		return false;
	}
	
	return true;
}
function initTranslation()
{
	var e = document.getElementById("dr_prompt");
	e.innerHTML = _("dr_prompt");

	e = document.getElementById("v4_dr_enableTitle");
	e.innerHTML = _("dr_v4_enableTitle");
	e = document.getElementById("v4_dr_wanTitle");
	e.innerHTML = _("dr_wanTitle");
	e = document.getElementById("v4_dr_wanDefaultTitle");
	e.innerHTML = _("dr_wanDefaultTitle");
	
	e = document.getElementById("v6_dr_enableTitle");
	e.innerHTML = _("dr_v6_enableTitle");
	e = document.getElementById("v6_dr_wanTitle");
	e.innerHTML = _("dr_wanTitle");
	e = document.getElementById("v6_dr_wanDefaultTitle");
	e.innerHTML = _("dr_wanDefaultTitle");
	
	e = document.getElementById("v4_apply");
	e.value = _("apply");
	e = document.getElementById("v4_cancel");
	e.value = _("cancel");
	e = document.getElementById("v6_apply");
	e.value = _("apply");
	e = document.getElementById("v6_cancel");
	e.value = _("cancel");
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
              <td id="dr_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" action="/goform/set_v4_def_route" onSubmit="return v4checkValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%" id="v4_dr_enableTitle">Enable the IPv4 default route</td>
        <td class="tabal_right"><input type="checkbox" name="v4_dr_enable" value="1" onClick="clickV4DrEnable()">
          <input type="hidden" name="v4_dr_enableFlag">
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="v4_dr_wanTitle">WAN Name</td>
        <td class="tabal_right"><select name="v4_dr_wan" size="1" style="width:27%" value=3>
            <option value="0" id="v4_dr_wanDefaultTitle" selected="selected">Please choose</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Applay" id="v4_apply">
          <input class="submit" type="reset" onClick="window.location.reload();" value="Cancel" id="v4_cancel">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<form method="post" action="/goform/set_v6_def_route" onSubmit="return v6checkValue()">
  <table id='tb_v6_def_route' class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%" id="v6_dr_enableTitle">Enable the IPv6 default route</td>
        <td class="tabal_right"><input type="checkbox" name="v6_dr_enable" value="1" onClick="clickV6DrEnable()">
          <input type="hidden" name="v6_dr_enableFlag">
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="v6_dr_wanTitle">WAN Name</td>
        <td class="tabal_right"><select name="v6_dr_wan" size="1" style="width:27%" value=3>
            <option value="0" id="v6_dr_wanDefaultTitle" selected="selected">Please choose</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table id='tb_v6_submit' class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Applay" id="v6_apply">
          <input class="submit" type="reset" onClick="window.location.reload();" value="Cancel" id="v6_cancel">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
