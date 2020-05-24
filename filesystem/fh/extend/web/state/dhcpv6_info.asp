<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Refresh" content="20">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCPv6 Info</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

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
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="dhcpv6_infoPrompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can query basic DHCPv6 information, including the DUID, IPv6 address, prefix, and remaining lease time.</td>
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
      <td class="tabal_left" width="25%">Total IP Addresses</td>
      <td class="tabal_right" width="75%">256</td>
    </tr>
    <tr>
      <td class="tabal_left">Remaining IP Addresses</td>
      <td class="tabal_right">256</td>
    </tr>
  </tbody>
</table>
<br>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_title">
      <td width="33%">DUID</td>
      <td width="33%"id="dhcpv6_ip/prefix">IPv6 Address/Prefix</td>
      <td width="34%"id="dhcpv6_time">Remaining Lease Time</td>
    </tr>
    <% dhcpv6_info_sync(); %>
    <!--TR class='tabal_01' >
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
      <TD align='center'>--</TD>
    </TR-->
  </tbody>
</table>
<br>
</td>
</tr>
</table>
</body>
</html>
