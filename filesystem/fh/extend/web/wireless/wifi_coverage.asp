<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Wifi Coverage Management</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';

var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);

Butterlate.setTextDomain("wireless", lang);

//get init value from driver

function initTranslation()
{
}

function initValue()
{
	initTranslation();
	var use_default_flag = '<% getCfgGeneral(1, "use_default_flag"); %>';
	var use_default_flagNode = getElement("use_default_flag");
	showCheckboxNodeByValue(use_default_flagNode,use_default_flag);
	
	var auto_switch_2access = '<% getCfgGeneral(1, "auto_switch_2access"); %>';
	var auto_switch_2accessNode = getElement("auto_switch_2access");
	showCheckboxNodeByValue(auto_switch_2accessNode,auto_switch_2access);

	var rssi_forced_switch = '<% getCfgGeneral(1, "rssi_forced_switch"); %>';
	setText("rssi_forced_switch",rssi_forced_switch);
	var rssi_condition_switch = '<% getCfgGeneral(1, "rssi_condition_switch"); %>';
	setText("rssi_condition_switch",rssi_condition_switch);
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wificoverage_prompt"  class="title_01" style="padding-left: 10px;" width="100%">On this page, you can manage smart WiFi coverage. Specifically, you can enable the ONT to work with external APs to construct a WiFi network and extend WiFi coverage.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
  </tbody>
</table>
<form method=post action="/goform/set_wifi_coverage">
  <div>
    <input type="checkbox" name="use_default_flag" value="1">
    <span>Automatically use the default SSID for extending the WiFi connection to the AP. </span>
    <select name="wifi_ap" id="wifi_ap" size="1">
    <option value="0">AN5506-04FS</option>
    </select>
  </div>
  <br>
  <div>
    <input type="checkbox" name="auto_switch_2access" value="1">
    <span>The ONT enables wireless devices to automatically switch to an access point where the signal performance is better.</span> </div>
  <br>
  <div> <span>RSSI threshold for force switching</span>
    <input type="text" name="rssi_forced_switch" value='-79'>
    <span class="gray">dBm(range: -100 dBm to -66 dBm; default -79 dBm)</span> </div>
  <div><span class="gray">(Forced switching: When signal strength is poor on a wireless device, the device is directly disconnected from the current access point and switched to another wireless access point.)</span> </div>
  <br>
  <div> <span>RSSI threshold for conditioned switching</span>
    <input type="text" name="rssi_condition_switch" value='-75'>
    <span class="gray">dBm(range: -84 dBm to -60 dBm; default -75 dBm)</span> </div>
  <div><span class="gray">(Conditioned switching: When signal strength deteriorates on a wireless device, the device is switched to another access point only after an appropriate access point is detected.)</span> </div>
  <br>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="wifi_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="wifi_cancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="6" id="dhcp_userListHead">External AP List</td>
    </tr>
    <tr class="tabal_title">
      <td width="5%">No.</td>
      <td width="20%"id="wifi_model">Device Model</td>
      <td width="20%"id="wifi_serial">Serial Number</td>
      <td width="10%"id="wifi_status">Status</td>
      <td width="20%"id="wifi_duration"> Online Duration</td>
      <td width="25%"id="wifi_cfg_status">Configuration Status</td>
    </tr>
    <TR class='tabal_01' >
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
    </TR>
  </tbody>
</table>
</body>
</html>
