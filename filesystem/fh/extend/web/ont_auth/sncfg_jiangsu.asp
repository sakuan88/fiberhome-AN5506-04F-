<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/versionControl.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>SN Config</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var sncfgSync = <% sncfgSync();%>
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("sncfg", lang);


/* modify by wuxj, 20120314, commit authentication separately*/
function initValue()
{	
	initTranslation();
	//document.getElementById("LOID").value = "";
	//document.getElementById("LOPWD").value = "";
}

function initTranslation()
{
	e = document.getElementById("sncfg_loidTips");
	e.innerHTML = _("sncfg_loidTips");
	e = document.getElementById("sncfg_lopwdTips");
	e.innerHTML = _("sncfg_lopwdTips");

}	



function checkValue(cfgType)
{

	var logicSN = document.getElementById("LOID");
	var logicPwd = document.getElementById("LOPWD");
	if (!CheckNotNull(logicSN.value)) 
	{
		alert(_("sncfg_loidNullAlert"));
		logicSN.value = logicSN.defaultValue;
		logicSN.focus();
		return false;
	}

	if(!checkASCIIChar(logicSN.value))
	{
		alert(_("sncfg_loidchnAlert"));
		logicSN.value = logicSN.defaultValue;
		logicSN.focus();
		return false;
	}
	

	return true;
}

function checkLogicSN(str)
{
	var reg = /^[\w./]{1,24}$/;	//number letter _ . /
    if (!reg.test(str))
	{ 
     	return false; 
    }
	else
	{
		return true;
	}
}

function checkLogicPwd(str)
{
	if (str.length > 0) 
	{
		var reg = /^[\w]{1,12}$/;	//number letter _
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}

function checkPwdCfg(str)
{
	if (str.length > 0) 
	{
		var reg = /^[\w-]{1,10}$/;	//number letter _ -
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}


</script>
</head>
<body class="mainbody" onload="initValue()">

<form method="post" name="sn_form" action="/goform/devRegister_JiangSu" onSubmit="return CheckValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="sn_prompt" class="title_01" style="padding-left: 10px;" width="100%">在本页面上，您可以提交注册信息，然后到状态页面查询注册结果。</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td></td>
    </tr>
  </tbody>
</table>

  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_head">注册认证</td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="TrLoid">
          <td class="tabal_left" width="20%" id="sncfg_loid">LOID</td>
          <td class="tabal_right"><input name="LOID" id="LOID" maxlength="24" type="text" value="<% getCfgGeneral(1, "logic_sn"); %>">
            <strong style="color:#FF0033">*</strong><span class="gray" id="sncfg_loidTips">&nbsp;(You can input 1-24 basic Latin characters)</span> </td>
        </tr>
        <tr id="TrLopwd">
          <td class="tabal_left" width="20%" id="sncfg_lopwd">逻辑密码</td>
          <td class="tabal_right"><input name="LOPWD" id="LOPWD" maxlength="12" type="password" value="<% getCfgGeneral(1, "logic_pwd"); %>" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
            <span class="gray" id="sncfg_lopwdTips">&nbsp;&nbsp;(You can input 0-12 basic Latin characters)</span> </td>
        </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="应用" type="submit" id="ddns_apply">
          <input class="submit" name="cancel" onclick="window.location.reload();" value="取消" id="ddns_cancel" type="reset">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>