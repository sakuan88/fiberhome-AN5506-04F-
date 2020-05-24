<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Battery Information</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

function initTranslation()
{
/*	
	var e = document.getElementById("remote_manage_prompt");
	e.innerHTML = _("remote_manage_prompt");

	e = document.getElementById("powerSup_mode_title");
	e.innerHTML = _("powerSup_mode_title");
	
	e = document.getElementById("batteryCap_title");
	e.innerHTML = _("batteryCap_title");	
*/
}

function initValue()
{
	initTranslation();	
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
              <td id="battery_info_prompt" class="title_01" style="padding-left: 10px;" 
                	width="100%">On this page, you can view the power supply mode and the available battery capacity.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="tabal_left" width="25%" id="powerSup_mode_title">Power Supply Mode</td>
      <td class="tabal_right" id = "powerSup_mode_value">Commercial Power</td>
    </tr>
    <tr id = "hardver_tr">
      <td class="tabal_left" width="25%" id="batteryCap_title">Available Battery Capacity</td>
      <td class="tabal_right" id = "batteryCap_value">0%</td>
    </tr>
  </tbody>
</table>
</body>
</html>
