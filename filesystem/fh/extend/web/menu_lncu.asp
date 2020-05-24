<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WebServer</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link type="text/css" rel="stylesheet" href="./style/frame_cuadmin.css"/>
<script type="text/javascript" src="./lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="./js/versionControl.js"></script>
<script type="text/javascript" src="./js/jquery.js"></script>
<script type="text/javascript" src="./js/frame_cu.js"></script>
<script type="text/javascript" src="./js/menuParse.js"></script>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

var menuPath = '<% getCfgZero("1", "menuPath");%>';

Frame.show(curUserType, menuPath);

function LoadFrame()
{
	document.getElementById("headerLogoutSpan").innerHTML = _("logout");
}
</script>
</head>
<body onload="LoadFrame()">
<div id="main">
  <div id="header">
    <div id="headerLogoImg"></div>
    <div id="headerContent">
      <div id="headerInfo"></div>
      <div id="headerTab">
        <div id="headerTab1">
          <ul>
          </ul>
        </div>
        <div id="headerTab2">
          <div id="headerTab2Right">
            <table>
              <tr>
                <td id="menuLogout" class="menuLogout"><span id="headerLogoutSpan">Logout</span></td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="headerSpace"></div>
  <div id="center">
    <div id="navLeft"> </div>
    <div id="navCenter">
      <div id="navtop"> </div>
      <div id="navMenu">
        <ul>
        </ul>
      </div>
    </div>
    <div id="navRight"> </div>
    <div id="content">
      <div id="topNav"> <span id="topNavMainMenu"></span>&nbsp;&#187;&nbsp;<span id="topNavSubMenu"></span>&nbsp;&#187;&nbsp;<span id="topNavSub2Menu"></span> </div>
      <div id="frameWarpContent">
        <iframe id="frameContent" marginheight="0" marginwidth="0" frameborder="0" height="100%" width="100%"></iframe>
      </div>
    </div>
    <div id="logo_uc">
      <input id="haha" type="hidden" value='<% getCfgGeneral(1, "Index_nav");%>'>
    </div>
  </div>
</div>
</body>
</html>
