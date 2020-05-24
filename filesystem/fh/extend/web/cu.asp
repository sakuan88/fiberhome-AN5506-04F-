<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode"); %>';
var page_style = '<% getCfgGeneral(1, "page_style"); %>';
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "cu.asp");

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
var login_error = '<% getCfgGeneral(1, "login_error");%>';
var no_error = '<% clearLoginError(); %>';

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
	var e;
	e = document.getElementById("submit");
	e.value = _("login_submit");
	e = document.getElementById("reset");
	e.value = _("login_reset");
}

function formLoad(){   

	initTranslation();

	/* 由于 path =/goform  的cookie 不是我们需要的，所以在前台login 前清除*/
	removeCookie("loginName",  "/goform" );
	
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	if(device_type == 1)	/* HGU */
	{
		var devRegisterSync = '<% devRegisterSync(); %>';
		var authResult = '<% getCfgGeneral(1, "auth_result"); %>';
		var oltAuthRst = '<% getCfgGeneral(1, "olt_auth_rst"); %>';

		setDisplay("td_regist", "");
		getElement("td_submit").width = "20%";
		getElement("td_reset").width = "20%";
		
		if(parseInt(oltAuthRst) == 0 && parseInt(authResult) == 1)/*OLT注册成功 itms平台注册成功*/
		{
			document.getElementById("td_regist").disabled = true;
		}
		else
		{
			document.getElementById("td_regist").disabled = false;
		}
	}
	
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

</script>
<STYLE type="text/css">
.STYLE1 {
	background-image: url(images/background.png);
	background-repeat: repeat-x;
	
}
.STYLE2 {	
	height: 35px;
	width: 90px;
	background-image: url(images/loginbutton.png);
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
<form name="login" method="post" onSubmit="return onlogin();" action="/goform/webLoginAdmin">
  <table valign="middle" height="100%" width="100%">
    <tbody>
      <tr valign="middle" height="80%">
        <td width="33%"></td>
        <td width="33%"><table valign="middle" align="center" background="images/login_cu.png" border="0" width="935" height="415">
            <tbody>
              <tr>
                <td width="47%"><table valign="middle" height="415" width="100%">
                    <tbody>
                      <tr>
                        <td width="33%" height="80%"></td>
                      </tr>
                      <tr>
                        <td width="33%" height="30%"><span class="STYLE5">&nbsp &nbsp</span></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="28%"><table valign="middle" height="415" width="100%" >
                    <tbody>
                      <tr >
                        <td width="28%" height="30%"></td>
                      </tr>
                      <tr >
                        <td width="28%" height="35%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr>
                                <td height="30%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="100%" style="background-image: url(images/loginput.png); background-repeat: no-repeat;"><font id="accounttitle" class="STYLE6">管理账户</font>
                                          <input name="User" id="User" value="" type="text"  style="width:155px; height:30px;">
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr >
                                <td height="30%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="100%" height="30%" style="background-image: url(images/loginput.png); background-repeat: no-repeat;"><font id="pwdtitle" class="STYLE6">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</font>
                                          <input name="Passwd" id="Passwd" value="" type="password"  style="width:155px; height:30px;"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr >
                                <td height="30%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="5%"></td>
                                        <td width="25%" id="td_submit" align="center"><input type="submit" class="STYLE2" value="登录" id="submit"></td>
                                        <td width="5%"></td>
                                        <td width="25%" id="td_reset" align="center"><input type="reset" class="STYLE2" value="重置" id="reset"></td>
                                        <td width="5%"></td>
                                        <td width="30%" id="td_regist" align="center" style="display: none"><input type="button" class="STYLE2" value="设备注册" onClick="location='./devregist/register_cu.asp'">
                                        </td>
                                        <td></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                      <tr >
                        <td width="28%" height="35%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr>
                                <td height="30%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="5%"></td>
                                        <td width="90%" align="center" id="td_error" ><span class="STYLE4" id="span_error"></span></td>
                                        <td width="5%"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr>
                                <td height="40%"width="100%" ></td>
                              </tr>
                              <tr>
                                <td height="30%"width="100%" ></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="25%" height="15%"></td>
              </tr>
            </tbody>
          </table></td>
        <td width="34%"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>