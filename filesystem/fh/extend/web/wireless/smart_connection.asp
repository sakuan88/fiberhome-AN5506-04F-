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
<title>smart connection</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);

//get init value from driver
var smartConnectEnableSync = '<% smartConnectEnableSync(); %>';

function initTranslation()
{
	var e = document.getElementById("smart_connection_prompt");
	e.innerHTML = _("smart_connection_prompt");
	
	e = document.getElementById("smart_connect_enable_title");
	e.innerHTML = _("smart_connect_enable_title");    

	e = document.getElementById("smart_connection_enable");
	e.innerHTML = _("wireless enable");
	e = document.getElementById("smart_connection_disable");
	e.innerHTML = _("wireless disable");

	e = document.getElementById("smart_connect_apply");
	e.value = _("wireless apply");
	e = document.getElementById("smart_connect_cancel");
	e.value = _("wireless cancel");	
	
}

function initValue()
{
	initTranslation();
	var smartConnectEnableCode = document.getElementsByName("SmartConnectEnable");	
	for(var i = 0;i<smartConnectEnableCode.length;i++)
	{
		if(smartConnectEnableCode[i].value == '<% getCfgGeneral(1, "SmartConnectEnable"); %>')
		{
			smartConnectEnableCode[i].checked = true;
			break;
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method=post name="fm_smart_connection" action="/goform/setSmartConnectEnable">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="smart_connection_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="smart_connect_enable_title" align="left" width="25%">Smart Connection Switch</td>
        <td class="tabal_right" align="left" width="75%"><input checked="checked" value="enable" name="SmartConnectEnable" type="radio">
          <font id="smart_connection_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="SmartConnectEnable" type="radio">
          <font id="smart_connection_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong></td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="smart_connect_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="smart_connect_cancel" onClick="window.location.reload()"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
