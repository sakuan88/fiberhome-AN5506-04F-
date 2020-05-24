<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="./js/checkValue.js"></script>
<script type="text/javascript" src="./js/utils.js"></script>
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode"); %>';
var page_style = '<% getCfgGeneral(1, "page_style"); %>';
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "login_ct.asp");

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);
/*
var readerr = '';
var userrelog = '';
var passwderror = '';
var usererror = '';
var pleasewait = '';
var ur = '';
*/
var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
var login_error = '<% getCfgGeneral(1, "login_error");%>';

var devRegisterSync = '<% devRegisterSync(); %>';
var authResult = '<% getCfgGeneral(1, "auth_result"); %>';
var oltAuthRst = '<% getCfgGeneral(1, "olt_auth_rst"); %>';

function onlogin() {
	with ( document.forms[0] ) {
		if(User == null || User.value.length <= 0) {
		  alert(_("uernameNotNull"));
			return false;
		}
		if(Passwd == null || Passwd.value.length <= 0) {
			alert(_("passwordNotNull"));
			return false;
		}
	}
	document.all("submit").disabled = true;
	
	return true;	
}

function foreach()
{
	var strCookie = document.cookie;
  
	var arrCookie=strCookie.split("; "); // 将多cookie切割为多个名/值对
      
      for(var i=0; i < arrCookie.length; i++)
     { 
     	// 遍历cookie数组，处理每个cookie对
		var arr=arrCookie[i].split("=");

		if(arr.length>0)
		{
			DelCookie(arr[0]);
		}
  }
}
	
function onkey(){
	if(window.event.keyCode==13){
		document.getElementById('submit').click();
	}
}

function initTranslation()
{
	var e = document.getElementById("accounttitle");
	e.innerHTML = _("accounttitle");
	e = document.getElementById("pwdtitle");
	e.innerHTML = _("pwdtitle");
	e = document.getElementById("submit");
	e.value = _("login_submit");
}

function formLoad()
{
	if(parseInt(oltAuthRst) == 0)/*OLT注册成功*/
	{
		if(parseInt(authResult) == 1)/*itms平台注册成功*/
		{
			document.getElementById("reg_but").disabled = true;
		}
		else
		{
			document.getElementById("reg_but").disabled = false;
		}
	}
	else
	{
		document.getElementById("reg_but").disabled = false;
	}

	initTranslation();

	/* 由于 path =/goform  的cookie 不是我们需要的，所以在前台login 前清除*/
	removeCookie("loginName",  "/goform" );

	//仅当隐私设置为“阻止所有Cookie”级别时为false
	var cookieEnabled=(navigator.cookieEnabled)? true : false;
	////navigator is not ie4+ or ns6+
    if (typeof navigator.cookieEnabled=="undefined" && !cookieEnabled){ 
        document.cookie="testcookie";
        cookieEnabled=(document.cookie=="testcookie")? true : false;
        document.cookie=""; //erase dummy value
    }
    if(cookieEnabled == false)
	    alert("COOKIES need to be enabled!");

	//清空原cookie数据
	//foreach();
	
	window.document.forms[0].User.focus();

	if ( login_error != '0')
	{
		document.getElementById("submit").disabled = 0;
		document.getElementById("td_error").disabled = 1;
	}
	if ( login_error== '1')
	{
		document.getElementById("span_error").innerHTML = _("namePwdError");
	}
	else if ( login_error== '2')
	{
		document.getElementById("span_error").innerHTML = _("adminUnavailable");
	}
	else if ( login_error== '3')
	{
		document.getElementById("span_error").innerHTML = _("serverError");
	}
	else if ( login_error== '4')
	{
		document.getElementById("span_error").innerHTML = _("logoutError");
	}
	else if ( login_error== '5')
	{
		document.getElementById("span_error").innerHTML = _("haveuserLogin");
	}
	else if ( login_error== '6')
	{
		document.getElementById("span_error").innerHTML = _("3timeError");
	}
		
}

function gotoRegisterPage()
{	
	if(ispMinorNameCode == '101')							/*江苏电信设备注册页面*/
	{
		document.location = './devregist/register_jiangsu.asp'   /*没有进度条*/
	}
	else
	{
		document.location = './devregist/register.asp'
	}
}

</script>
<STYLE type="text/css">
.STYLE1 {
	background-image: url(images/background.png);
	background-repeat: repeat-x;
	
}
.STYLE2 {	
	height: 35px;
	width: 90px; 
}
.STYLE4 {
	color: #FF0000;
	text-align: center;	
	font-size: 20px;
}
.STYLE5 {
	color: #FFFFFF;
	text-align: center;	
	font-size: 10px;
}
.STYLE6 {
	color: #000000;
	text-align: center;	
	font-size: 18px;
}

</style>
</head>
<body class="STYLE1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="formLoad()">
<form name="login" method="post" onSubmit="return onlogin();" action="/goform/webLogin">
  <table valign="middle" height="100%" width="100%"  >
    <tbody>
      <tr valign="middle" height="80%">
        <td width="33%"></td>
        <td width="33%"><table valign="middle" align="center" background="images/login_ct.jpg" border="0" width="1024" height="768">
            <tbody>
              <tr>
                <td width="28%"><table valign="middle" height="415" width="100%">
                    <tbody>
                      <tr>
                        <td width="33%" height="80%"></td>
                      </tr>
                      <tr>
                        <td width="33%" height="30%"><span class="STYLE5">&nbsp &nbsp</span></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="43%"><table valign="middle" height="768" width="100%" >
                    <tbody>
                      <tr>
                        <td width="28%" height="35%"></td>
                      </tr>
                      <tr>
                        <td width="28%" height="29%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr>
                                <td height="5%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="100%" ><font  class="STYLE6">终端管理登陆</font></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr>
                                <td height="20%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="25%"></td>
                                        <td width="50%" ><font id="accounttitle" class="STYLE6">账号</font>
                                          <input name="User" id="User" value="" type="text"  style="width:135px; height:28px;">
                                        </td>
                                        <td width="25%"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr>
                                <td height="20%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="25%"></td>
                                        <td width="50%" height="30%" ><font id="pwdtitle" class="STYLE6">密码</font>
                                          <input name="Passwd" id="Passwd" value="" type="password"  style="width:135px; height:28px;"></td>
                                        <td width="25%"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr>
                                <td height="20%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="20%"></td>
                                        <td width="35%"><input type="submit" class="STYLE2" value="登录" name="submit" id="submit"></td>
                                        <td width="10%"></td>
                                        <td id width="35"><table id="regit_table" align="center" border="0" height="100%" width="100%">
                                            <tbody>
                                              <tr>
                                                <td width="100%"><input id="reg_but"type="button" class="STYLE2" 
										   value="设备注册" onClick="gotoRegisterPage()"></td>
                                              </tr>
                                            </tbody>
                                          </table></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr>
                                <td height="35%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="5%"></td>
                                        <td width="90%" align="center" id="td_error" ><span class="STYLE4" id="span_error"></span></td>
                                        <td width="5%"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                      <tr>
                        <td width="28%" height="36%"></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="26%" height="15%"></td>
            </tbody>
          </table></td>
        <td width="27%"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
