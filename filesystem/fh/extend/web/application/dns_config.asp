<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Portal Configuration</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;

var dns_search_size_sync = '<% dns_search_size_sync(); %>';
var search_rulenum  = '<% getCfgGeneral(1, "search_rulenum"); %>';

var dns_static_size_sync = '<% dns_static_size_sync(); %>';
var static_rulenum  = '<% getCfgGeneral(1, "static_rulenum"); %>';

var currentline;

var wanNameSync = '<% wanNameSync(); %>';

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var curTab;

function LoadFrame()
{
	initTranslation();
	
	var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
	var wannameArray = wanname_all.split("|");
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var wannameText_all;
	if(device_type == 0)	/* SFU */
	{
		wannameText_all = wanname_all;
	}
	else		
	{
		wannameText_all = '<% getCfgGeneral(1, "tr069_wan_name_all"); %>';
	}
	var wannameTextArray = wannameText_all.split("|");
	
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	var wannameNode = getElement("dns_interface");
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("INTERNET") >= 0)
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
		else if((ispNameCode == 5) && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	if(wannameNode.length > 1)
	{
		wannameNode.options.remove(0);
	}

	if(search_rulenum == 0)
	{	
		setDisplay("searchConfigForm1", "none");
	}
	else
	{	
		selectLine('search', "searchRecord_0");	
		setDisplay("searchConfigForm1", "");
	}
	
	if(static_rulenum == 0)
	{	
		setDisplay("staticConfigForm1", "none");
	}	
	else
	{	
		selectLine('static', "staticRecord_0");	
		setDisplay("staticConfigForm1", "");
	}
}

function initTranslation()
{
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];
	
	var rowFix;
	if(tabTitle.search("search") >= 0)
	{
		rowFix = "search"; 
		curTab = "search"; 
	}
	else
	{
		rowFix = "static";  
		curTab = "static"; 
	}

	if(rowLen - 2 >= 20)
	{		
 		alert(_("fw_most20RulesAlert"));
		return;
	}
	
	if (lastRow.id == rowFix + 'Record_new')		//新建
	{
		selectLine(curTab, lastRow.id);
		return;
	}
    else if (lastRow.id == rowFix + 'Record_no')		//原无用户
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay(rowFix + "ConfigForm1", "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = rowFix + 'Record_new';
		row.attachEvent("onclick", function(){selectLine(curTab, row.id);});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id',rowFix + 'Record_new');
		row.setAttribute('onclick','selectLine(' + curTab + ', this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length - 1; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	}
	col = row.insertCell(i);
	
	selectLine(curTab, rowFix + "Record_new");

	if(tabTitle == "search")				//search
	{
		getElement("searchDomain").focus();
	}
	else							   //static
	{
		getElement("staticDomain").focus();
	}
}
function selectSearch(temp)
{
	if(temp == 'new')		//新建
	{
		document.getElementById("searchDomain").value = "";
		document.getElementById("dns_interface").options[0].selected = true;
		document.getElementById("searchDNS").value = "";
	}
	else
	{
		document.getElementById("searchDomain").value = document.getElementById("searchDomain_" + temp).innerHTML;
				
		var curWan = getElement("dns_interface_" + temp).innerHTML;
		var wanNode = getElement("dns_interface");
		showSelectNodeByValue(wanNode, curWan);
		if(wanNode.value != curWan)
		{
			wanNode.value = 0;
		}
		
		document.getElementById("searchDNS").value = document.getElementById("searchDNS_" + temp).innerHTML;
	}
	//标志当前编辑规则的id
	document.getElementById("searchCurIndex").value = temp;
}
function selectStatic(temp)
{
	if(temp == 'new')		//新建
	{
		document.getElementById("staticDomain").value = "";
		document.getElementById("staticIP").value = "";
	}
	else
	{
		document.getElementById("staticDomain").value = document.getElementById("staticDomain_" + temp).innerHTML;
		document.getElementById("staticIP").value = document.getElementById("staticIP_" + temp).innerHTML;
	}
	//标志当前编辑规则的id
	document.getElementById("staticCurIndex").value = temp;
}
function selectLine(tab, id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];	
		currentline = temp;
		if(tab == 'search')
			selectSearch(temp);
		else
			selectStatic(temp);	
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;
	}	 
}

function clickRemove(tabTitle)
{
	var curRulenum;
	if(tabTitle.search("search") >= 0)
	{
		curRulenum = search_rulenum;
	}
	else
	{
		curRulenum = static_rulenum;
	}
	if(curRulenum == 0)
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

function checkPortalUrl(type)
{
	var node;
	if(type == 1)
		node = getElement("portal_defaultUrl");
	else
		node = getElement("portal_url");
	if (!validateURL(node.value)) 
	{
		//alert(_("请输入需要过滤的MAC地址!"));
		alert(_("fw_URLIllegalAlert"));
		node.value = node.defaultValue;
		node.focus();
		return false;
	}
	
	return true;
}

function isSearchDomainNameRepeat(k)
{
	var current_domain_name = document.getElementById("searchDomain");
	var domain_name = document.getElementById("searchDomain_" + k).innerHTML;

	if(domain_name == current_domain_name.value)  /*非当前规则中存在与当前Domain_name相同的规则 */
	{
		alert("This Domain Name repeats with the existing rule's. Please reconfigure it!");
		current_domain_name.value = current_domain_name.defaultValue;
		current_domain_name.focus();
		return true;
	}		
	return false;
}

function isStaticDomainNameRepeat(k)
{
	var current_domain_name = document.getElementById("staticDomain");
	var domain_name = document.getElementById("staticDomain_" + k).innerHTML;

	if(domain_name == current_domain_name.value)  /*非当前规则中存在与当前Domain_name相同的规则 */
	{
		alert("This Domain Name repeats with the existing rule's. Please reconfigure it!");
		current_domain_name.value = current_domain_name.defaultValue;
		current_domain_name.focus();
		return true;
	}		
	return false;
}

function checkSearchRepeat(temp)
{
	var k = 0;

	if(search_rulenum > 0)
	{
		for(k = 0; k < search_rulenum; k++)
		{
			if(temp != 'new') /*修改规则*/
			{
				if(temp != k) /*temp 为当前修改规则行号，不和自己进行比较*/
				{
					if(isSearchDomainNameRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增规则*/
			{	
				if(isSearchDomainNameRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;
}

function checkStaticRepeat(temp)
{
	var k = 0;

	if(static_rulenum > 0)
	{
		for(k = 0; k < static_rulenum; k++)
		{
			if(temp != 'new') /*修改规则*/
			{
				if(temp != k) /*temp 为当前修改规则行号，不和自己进行比较*/
				{
					if(isStaticDomainNameRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增规则*/
			{	
				if(isStaticDomainNameRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;
}

function checkSearch()
{
	var searchDomainNode = getElement("searchDomain");	 
	if(!CheckNotNull(searchDomainNode.value) || !validateURL(searchDomainNode.value)) //检查searchDomain是否为空及域名合法字符校验
	{
		alert("Domain Name is invalid!");
		searchDomainNode.value = searchDomainNode.defaultValue;
		searchDomainNode.focus();
		return false;
	}

	var searchDNSNode = getElement("searchDNS");	
	if (!validateIP(searchDNSNode.value)) 
	{
		alert(_("fw_ipIllegalAlert"));
		searchDNSNode.value = searchDNSNode.defaultValue;
		searchDNSNode.focus();
		return false;
	}
	if(getElement("dns_interface").value == '0')
	{
		alert(_("wanIllegalAlert"));
		return false;
	}

	if(!checkSearchRepeat(currentline))
	{
		return false;
	}
	
	return true;
}

function checkStatic()
{
	var staticDomainNode = getElement("staticDomain");	
	if(!CheckNotNull(staticDomainNode.value) || !validateURL(staticDomainNode.value)) //检查searchDomain是否为空及域名合法字符校验
	{
		alert("Domain Name is invalid!");
		staticDomainNode.value = staticDomainNode.defaultValue;
		staticDomainNode.focus();
		return false;
	}
	
	var staticIPNode = getElement("staticIP");	
	if (!validateIP(staticIPNode.value)) 
	{
		alert(_("fw_ipIllegalAlert"));
		staticIPNode.value = staticIPNode.defaultValue;
		staticIPNode.focus();
		return false;
	}

	if(!checkStaticRepeat(currentline))
	{
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
              <td id="dnsTemplatePrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure the policy for forwarding DNS packets on the LAN side or the SSID side that is not bound to the WAN port.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" action="/goform/dnsTemplateSet">
  <table id="tb_portal_enable" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%">Dns template</td>
        <td class="tabal_right" align="left"><select id="dnsTemplate" name="dnsTemplate" size="1" style="width: 150px;">
            <option value=0>PRIORITY</option>
          </select></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="dnsTemplateApply" class="submit">
          <input type="reset" value="Cancel" id="dnsTemplateCancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td>DNS Search List Configuration</td>
    </tr>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="dnsTemplatePrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure the DNS search list. It is suggested that setting WAN name is a top priority, if both the WAN name and the DNS server are configured, the WAN name takes effect.</td>
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
                      <td><input type="button" value="Add" id="search_add" class="submit" onClick="clickAdd('searchRuleList');"></td>
                      <td><input type="button" value="Delete" id="search_delete" class="submit" onClick="clickRemove('searchRuleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="searchRuleList"><form method="post" id="searchRuleForm" action="/goform/dnsSearchDelete">
          <table class="tabal_bg" id = "tb_search" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_title">
                <td width="15%" align="center">ID</td>
                <td width="41%" align="center" id="domainTitle">Domain Name</td>
                <td width="21%" align="center" id="wanTitle">WAN Name</td>
                <td width="21%" align="center" id="serverTitle">DNS Server</td>
                <td width="2%" align="center"></td>
              </tr>
              <% dns_search_sync(); %>
              <!--TR id='searchRecord_no' class='tabal_01'>
                <TD align='center'>--</TD>
                <TD align='center'>--</TD>
                <TD align='center'>--</TD>
                <TD align='center'>--</TD>
                <TD align='center'></TD>
              </TR-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
    <tr>
      <td><form id="searchConfigForm" method="post" action="/goform/dnsSearchSet" onSubmit="return checkSearch()">
          <div id="searchConfigForm1">
            <table class="tabal_bg" id="search" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td class="tabal_left" width="25%">Domain Name</td>
                          <td class="tabal_right" width="75%"><input name="searchDomain" id="searchDomain" size="17" style="width: 150px;" type="text">
                            <strong style="color:#FF0033">*(Domain)</strong></td>
                        </tr>
                        <tr>
                          <td class="tabal_left" width="25%">WAN Name</td>
                          <td class="tabal_right" width="75%"><select id="dns_interface" name="dns_interface" size="1" style="width: 150px;">
                              <option value="0" id="dns_wanDisableTitle">Current WAN isn't available</option>
                            </select></td>
                        </tr>
                        <tr>
                          <td class="tabal_left" width="25%">DNS Server</td>
                          <td class="tabal_right" width="75%"><input name="searchDNS" id="searchDNS" size="17" style="width: 150px;" type="text"></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="dnsSearchApply" class="submit">
                    <input type="reset" value="Cancel" name="dnsSearchCancel" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="searchCurIndex" id="searchCurIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td>Static DNS Configuration</td>
    </tr>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="dnsStaticPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure static DNS.</td>
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
                      <td><input type="button" value="Add" id="static_add" class="submit" onClick="clickAdd('staticRuleList');"></td>
                      <td><input type="button" value="Delete" id="static_delete" class="submit" onClick="clickRemove('staticRuleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="staticRuleList"><form method="post" id="staticRuleForm" action="/goform/dnsStaticDelete">
          <table class="tabal_bg" id = "tb_static" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_title">
                <td width="15%" align="center">ID</td>
                <td width="43%" align="center" id="staticDomainTitle">Domain Name</td>
                <td width="40%" align="center" id="ipTitle">IP Address</td>
                <td width="2%" align="center"></td>
              </tr>
              <% dns_static_sync(); %>
              <!--TR id='staticRecord_no' class='tabal_01'>
                <TD align='center'>--</TD>
                <TD align='center'>--</TD>
                <TD align='center'>--</TD>
                <TD align='center'></TD>
              </TR-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
    <tr>
      <td><form id="staticConfigForm" method="post" action="/goform/dnsStaticSet" onSubmit="return checkStatic()">
          <div id="staticConfigForm1">
            <table class="tabal_bg" id="static" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td class="tabal_left" width="25%">Domain Name</td>
                          <td class="tabal_right" width="75%"><input name="staticDomain" id="staticDomain" size="17" style="width: 150px;" type="text">
                            <strong style="color:#FF0033">*(Domain)</strong></td>
                        </tr>
                        <tr>
                          <td class="tabal_left" width="25%">IP Address</td>
                          <td class="tabal_right" width="75%"><input name="staticIP" id="staticIP" size="17" style="width: 150px;" type="text">
                            <strong style="color:#FF0033">*</strong></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="dnsStaticApply" class="submit">
                    <input type="reset" value="Cancel" name="dnsStaticCancel" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="staticCurIndex" id="staticCurIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
