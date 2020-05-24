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
<title>Indicator Status Management</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("restore", lang);

function initTranslation()
{
	var e = document.getElementById("indicator_prompt");
	e.innerHTML = _("indicator_prompt");
	e = document.getElementById("indecator_head");
	e.innerHTML = _("indecator_head");
	e = document.getElementById("indicator_switch_title");
	e.innerHTML = _("indicator_switch_title");

	e = document.getElementById("indicator_on");
	e.innerHTML = _("indicator_on");
	e = document.getElementById("indicator_off");
	e.innerHTML = _("indicator_off");

	e = document.getElementById("apply");
	e.value = _("apply");
	e = document.getElementById("cancel");
	e.value = _("cancel");
}

function initValue()
{
	initTranslation();
	var indicatorSwitch = document.getElementsByName("indicatorSwitch");
	var indicatorSwitch_val = '<% getCfgGeneral(1, "indicatorSwitch"); %>';
	if(indicatorSwitch_val == '')
		indicatorSwitch_val = 'on';
	showRadioNodeByValue(indicatorSwitch, indicatorSwitch_val);
}

function indicatorSwitchConfirm()
{	
	if(confirm("It is necessary to restart ONU to configure effectively! Are you sure you want to restart the device?"))
	{	makeRequest("/goform/reboot", "n/a", indicatonHandler);
	}
	else
	{
		showRadioNodeByValue(document.getElementsByName("indicatorSwitch"), 'off');
	}
}
function indicatonHandler(http_request)
{
	var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
	var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var errorCode = http_request.responseText;
			if(errorCode == "0")
			{
				getElement("div_indicatorHead").innerHTML = _("div_rebootingHead");
				getElement("div_info").innerHTML = _("rebooting");
				waitToLogin(ispName, curUserType);
			}
		 }  
		else													// if request status is different then 200  
		{
			getElement("div_info").innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_indicator_switch" action="/goform/setIndicatorSwitch">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="indicator_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
      <tr class="tabal_head">
        <td colspan="2" id="indecator_head">Indicator Switch Configuration</td>
      </tr>
      <tr>
        <td class="tabal_left" id="indicator_switch_title" align="left" width="25%">Indicator Switch Configuration</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="on" name="indicatorSwitch" type="radio" onClick="indicatorSwitchConfirm()">
          <font id="indicator_on">On</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="off" name="indicatorSwitch" type="radio">
          <font id="indicator_off">Off</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong></td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="cancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
  <div id="div_indicatorHead" class="div_indicatorHead"></div>
  <br>
  <div id="div_info"></div>
</form>
</body>
</html>
