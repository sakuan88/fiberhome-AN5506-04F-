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
<title>Device Information</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var setDeviceInfoSync = '<% setDeviceInfoSync(); %>';

function initTranslation()
{
	var e = document.getElementById("deviceinf_prompt");
	e.innerHTML = _("deviceinf_prompt");

	e = document.getElementById("DeInf");
	e.innerHTML = _("DeInf");
	e = document.getElementById("softver");
	e.innerHTML = _("softver");
	e = document.getElementById("hardver");
	e.innerHTML = _("hardver");
	e = document.getElementById("device_model");
	e.innerHTML = _("device_model");
	e = document.getElementById("device_descrip");
	e.innerHTML = _("device_descrip");
	e = document.getElementById("ONU_state");
	e.innerHTML = _("ONU_state");
	e = document.getElementById("CPU_rate");
	e.innerHTML = _("CPU_rate");
	e = document.getElementById("mem_rate");
	e.innerHTML = _("mem_rate");
	e = document.getElementById("server_port");
	e.innerHTML = _("server_port");
			
}

function initValue()
{
	initTranslation();

	var port_value = document.getElementById("server_port_value");
	var web_port = '<% getCfgGeneral(1, "web_port"); %>';
	var ONU_regstate = document.getElementById("ONU_regstate");
	var loid_state = '<% getCfgGeneral(1, "loid_state"); %>';
	
	port_value.innerHTML = web_port;
	
	switch(parseInt(loid_state))
	{
		case 0:
		ONU_regstate.innerHTML = _("初始化");
		break;
		case 1:
		ONU_regstate.innerHTML = _("注册成功");
		break;
		case 2:
		ONU_regstate.innerHTML = _("逻辑ID错误");
		break;
		case 3:
		ONU_regstate.innerHTML = _("逻辑密码错误");
		break;
		case 4:
		ONU_regstate.innerHTML = _("逻辑ID冲突");
		break;
		case 10:
		ONU_regstate.innerHTML = _("物理SN冲突");
		break;
		case 11:
		ONU_regstate.innerHTML = _("无资源");
		break;
		case 12:
		ONU_regstate.innerHTML = _("ONU类型错误");
		break;
		case 13:
		ONU_regstate.innerHTML = _("物理SN错误");
		break;
		case 14:
		ONU_regstate.innerHTML = _("物理密码错误");
		break;
		case 15:
		ONU_regstate.innerHTML = _("物理密码冲突");
		break;
		default:
		ONU_regstate.innerHTML = _("初始化");
		break;
			
			
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="deviceinf" id="deviceinf">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="deviceinf_prompt" class="title_01" style="padding-left: 10px;" width="100%">You can query device information here.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="DeInf">Device Information</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="softver">Software Version</td>
        <td class="tabal_right"><% getCfgGeneral(1, "software_version"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="hardver">Hardware Version</td>
        <td class="tabal_right"><% getCfgGeneral(1, "hardware_version"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="device_model">设备型号</td>
        <td class="tabal_right"><% getCfgGeneral(1, "DeviceType"); %></td>
      </tr>
        <tr>
        <td class="tabal_left" width="25%" id="device_descrip">设备描述</td>
        <td class="tabal_right"><% getCfgGeneral(1, "PonType"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ONU_state">ONT 注册状态</td>
        <td class="tabal_right"><% getCfgGeneral(1, "ONT_state"); %></td> 
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="ONU_reg_title">ONT认证结果</td>
        <td class="tabal_right" id="ONU_regstate"></td> 
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="ONU_ID">ONT ID</td>
        <td class="tabal_right"><% getCfgGeneral(1, "ONT_SNumber"); %></td> 
      </tr>
   
       <tr>
        <td class="tabal_left" width="25%" id="CPU_rate">CPU 使用率</td>
        <td class="tabal_right"><% getCfgGeneral(1, "CPU_rate"); %></td> 
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="mem_rate">Memory 使用率</td>
        <td class="tabal_right"><% getCfgGeneral(1, "mem_rate"); %></td> 
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="server_port">Web Server port</td>
        <td class="tabal_right" id="server_port_value"></td> 
      </tr>
    
      </tbody>
  </table>
</form>
</body>
</html>

