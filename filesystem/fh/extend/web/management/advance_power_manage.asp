<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Advanced Power Management</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
//Butterlate.setTextDomain("advanced_power_management", lang);

function initTranslation()
{	
}

function initValue()
{
	initTranslation();
	
	var enable_energy_val = '<% getCfgGeneral(1, "enable_energy"); %>';
	var enable_energy_mode = document.getElementsByName("enable_energy");
	showCheckboxNodeByValue(enable_energy_mode,enable_energy_val);

	var enable_usb_val = '<% getCfgGeneral(1, "enable_usb"); %>';
	var enable_usb_mode = document.getElementsByName("enable_usb");
	showCheckboxNodeByValue(enable_usb_mode,enable_usb_val);
	
	var enable_lan_val = '<% getCfgGeneral(1, "enable_lan"); %>';
	var enable_lan_mode = document.getElementsByName("enable_lan");
	showCheckboxNodeByValue(enable_lan_mode,enable_lan_val);	

	var enable_wlan_val = '<% getCfgGeneral(1, "enable_wlan"); %>';
	var enable_wlan_mode = document.getElementsByName("enable_wlan");
	showCheckboxNodeByValue(enable_wlan_mode,enable_wlan_val);

	var enable_voice_val = '<% getCfgGeneral(1, "enable_voice"); %>';
	var enable_voice_mode = document.getElementsByName("enable_voice");
	showCheckboxNodeByValue(enable_voice_mode,enable_voice_val);

	var enable_remote_val = '<% getCfgGeneral(1, "enable_remote"); %>';
	var enable_remote_mode = document.getElementsByName("enable_remote");
	showCheckboxNodeByValue(enable_remote_mode,enable_remote_val);
	
}
function CheckValue()
{
	return true;
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_advanced_power" action="/goform/setAdvancePower" onSubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="advanced_power_prompt"  class="title_01" style="padding-left: 10px;" 
                	width="100%">On this page, you can set energy saving for the device.</td>
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
  <table id="energy_saving_cfg_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="energy_savingConf_title">Energy Saving Configuration</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="enable_energy_title">Enable Energy Saving</td>
        <td class="tabal_right"><input type="checkbox"  name="enable_energy" id="enable_energy" value="1" /></td>
      </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table id="enable_services_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="enable_services_title">Enable Services in Battery Mode</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="services_service">Service</td>
        <td class="tabal_right" id="services_enable">Enable</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="service_usb">USB</td>
        <td class="tabal_right"><input type="checkbox" name="enable_usb" id="enable_usb" value="1" /></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="service_lan">LAN</td>
        <td class="tabal_right"><input type="checkbox" name="enable_lan" id="enable_lan" value="1" /></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="service_Wlan">WLAN</td>
        <td class="tabal_right"><input type="checkbox" name="enable_wlan" id="enable_wlan" value="1" /></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="service_voice">Voice</td>
        <td class="tabal_right"><input type="checkbox" name="enable_voice" id="enable_voice" value="1" /></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="service_remote_management">Remote Management</td>
        <td class="tabal_right"><input type="checkbox" name="enable_remote" id="enable_remote" value="1" /></td>
      </tr>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="lApply" class="submit">
          <input type="reset" value="Cancel" id="lCancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
  <input type="hidden" name="curIndex" id="curIndex" value="0">
</form>
</body>
</html>
