<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCPv6 MAC BINDING</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;

var dhcpv6_macband_size_sync = '<% dhcpv6_macband_size_sync(); %>';
var ruleSum  = '<% getCfgGeneral(1, "dhcpv6mac_rulenum"); %>';
var currentline;

function initTranslation()
{
}
function LoadFrame()
{
	initTranslation();
	
	if(ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	else
	{	
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 8)
	{		
 		alert(_("fw_most8RulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//新建
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//原无用户
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay("ConfigForm1", "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine(row.id);});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length - 1; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	}
	col = row.insertCell(i);
	
	selectLine("record_new");
	document.getElementById("dhcp_mac").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		currentline = temp;
		if (temp == 'new')		//新建
		{					
			document.getElementById("dhcp_mac").value = "";
			document.getElementById("dhcp_ip").value = "";

		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			getElement("dhcp_mac").value = document.getElementById("dhcp_mac_" + temp).innerHTML;
			getElement("dhcp_ip").value = document.getElementById("dhcp_ip_" + temp).innerHTML;
		}
		
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;

		//标志当前编辑规则的id
		getElement("curIndex").value = temp;	

	}	 
}

function clickRemove(tabTitle)
{
	if(ruleSum  == 0)
	{			
 		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = tab[0].getElementsByTagName('input');
    var noChooseFlag = true;
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				noChooseFlag = false;
				break;
			}
		}
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
		alert(_("fw_noChooseAlert"));
		return ;
	}
	        
	if(confirm(_("fw_deleteRuleConfirm")) == false)
    	return;
	var form = document.getElementById(tabTitle).getElementsByTagName('form');
	form[0].submit();
	
}
/*校验mac地址的重复性*/
function isMacRepeat(k)
{
	var current_mac = document.getElementById("dhcp_mac");
	var current_mac_lowercast = current_mac.value.toLowerCase();
	var dhcp_mac = document.getElementById("dhcp_mac_" + k).innerHTML;

	if(dhcp_mac == current_mac_lowercast)  /*非当前规则中存在与当前mac相同的规则 */
	{
		//alert("MAC 地址已绑定 ，请重新输入!");
		alert(_("macAddr_RepeatAlert"));
		current_mac.value = current_mac.defaultValue;
		current_mac.focus();
		return true;
	}		
	return false;
}

function checkRepeat(temp)
{
	var k = 0;

	if(ruleSum > 0)
	{
		for(k = 0; k < ruleSum; k++)
		{
			if(temp != 'new') /*修改规则*/
			{
				if(temp != k) /*temp 为当前修改规则行号，不和自己进行比较*/
				{
					if(isMacRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增规则*/
			{	
				if(isMacRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;

}
function checkValue()
{
	var macaddr_value = document.getElementById("dhcp_mac");
	var dhcpIP_value = document.getElementById("dhcp_ip");
	
	if (!CheckNotNull(macaddr_value.value)) 
	{
		//alert(_("请输入需要过滤的MAC地址!"));
		alert(_("fw_nomacalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	if(!checkRepeat(currentline))
	{
		return false;
	}

	if(!validateMAC(macaddr_value.value))
	{
		//alert(_("您输入MAC地址非法!"));
		alert(_("fw_macillegalalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
		
	return true;
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="dhcp_macbandPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can assign an IP address to a MAC using a reserved interface ID and IPv6 GUA address. The IPv6 GUA address is a combination of the interface ID and prefix configured on the LAN side. If the method of obtaining LAN addresses is set to SLAAC, the configuration on this page does not take effect.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td height="22" width="7"></td>
              <td align="center" valign="bottom" width="120"></td>
              <td width="7"></td>
              <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                  <tbody>
                    <tr>
                      <td><input type="button" value="Add" id="rule_add" class="submit" onClick="clickAdd('ruleList');"></td>
                      <td><input type="button" value="Delete" id="rule_delete" class="submit" onClick="clickRemove('ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="ruleList"><form method="post" id="fw_ruleForm" action="/goform/dhcpv6_macband_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_title">
                <td width="48%" align="center" id="urlip">MAC Address</td>
                <td width="48%" align="center" id="urltime">Interface ID</td>
                <td width="4%" align="center" ></td>
              </tr>
              <% dhcpv6_macband_sync(); %>
              <!--TR id='record_no' class='tabal_01' >
                <TD align='center'>--</TD>
                <TD align='center'>--</TD>
                <TD align='center'></TD>
              </TR-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/dhcpv6_macband_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td  class="tabal_left" width="25%">MAC Address</td>
                  <td class="tabal_right" width="75%"><input name="dhcp_mac" id="dhcp_mac" size="17"  style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(00:11:22:33:44:55)</span></td>
                </tr>
                <tr>
                  <td  class="tabal_left" width="25%">Interface ID</td>
                  <td class="tabal_right" width="75%"><input name="dhcp_ip" id="dhcp_ip" size="17"  style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(XXXX:XXXX:XXXX:XXXX)</span></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="apply" class="submit">
                    <input type="reset" value="Cancel" name="cancel" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="curIndex" id="curIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
