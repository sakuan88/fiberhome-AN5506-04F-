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
<title>help</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("help", lang);


function initTranslation()
{

}

function initValue()
{
	initTranslation();

}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="igmp_form">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="30"></td>
      </tr>
    </tbody>
 </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         网络连接页面中可以配置WAN业务相关信息。</td>         
      </tr>
	      <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         IPTV配置页面可以配置组播VLAN。</td>         
      </tr>
      	<tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         VLAN绑定页面可以设置端口绑定或者VLAN绑定到相关LAN口。</td>         
      </tr>
      
    </tbody>
  </table>
</form>
</body>
</html>