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
<title>Port Isolation</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);

//get init value from driver
var RemoteControlSync = '<% port_isolate_sync(); %>';

function initTranslation()
{
}
function initValue()
{
//	initTranslation();

	var ISOLATIONEnable = '<% getCfgZero(1, "ISOLATIONEnable"); %>';
	var isolation_enable_state = document.getElementsByName("ISOLATIONEnable");	
	for(var i = 0;i<isolation_enable_state.length;i++)
	{
		if(isolation_enable_state[i].value == ISOLATIONEnable)
		{
			isolation_enable_state[i].checked = true;
			break;
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="rc_enableform" action="/goform/port_isolate">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="port_isolate_prompt"  class="title_01" style="padding-left: 10px;" width="100%">On this page, you could configure port isolation enable/disable. </td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_isolation" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%"><font id="td_isolation_enable">Port Isolation</font></td>
        <td class="tabal_right" align="left"><input checked="checked"value="1" name="ISOLATIONEnable" type="radio">
          <font id="isolation_enable">Enable</font> &nbsp; &nbsp; &nbsp;
          <input value="0" name="ISOLATIONEnable" type="radio">
          <font id="isolation_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="basicApply" class="submit">
          <input type="reset" name="Cancel" value="Cancel" id="basicCancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
