<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>ARP Aging</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;

var arp_aging_size_sync = '<% arp_aging_size_sync(); %>';
var arp_rulenum = '<% getCfgGeneral(1, "arp_rulenum"); %>';

var wanNameSync = '<% wanNameSync(); %>';

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

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
	var wannameNode = getElement("arp_interface");
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R_") >= 0)
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

	if(arp_rulenum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	else
	{	
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function initTranslation()
{
	var e = document.getElementById("arp_agingPrompt");
	e.innerHTML = _("arp_agingPrompt");

	e = document.getElementById("arp_agingListHead");
	e.innerHTML = _("arp_agingListHead");

	e = document.getElementById("arp_wanDisableTitle");
	e.innerHTML = _("arp_wanDisableTitle");

	e = document.getElementById("rule_add");
	e.value = _("fw_add");
	e = document.getElementById("rule_delete");
	e.value = _("fw_delete");
	e = document.getElementById("rule_deleteAll");
	e.value = _("fw_deleteAll");
	
	e = document.getElementById("apply");
	e.value = _("firewall_apply");
	e = document.getElementById("cancel");
	e.value = _("firewall_cancel");
	
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
	getElement("arp_interface").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("arp_interface").options[0].selected = true;
			document.getElementById("arp_aging").value = "";

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			var curWan = getElement("arp_interface_" + temp).innerHTML;
			var wanNode = getElement("arp_interface");
			showSelectNodeByValue(wanNode, curWan);
			if(wanNode.value != curWan)
			{
				wanNode.value = 0;
			}
			document.getElementById("arp_aging").value = document.getElementById("arp_aging_" + temp).innerHTML;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}	

		//标志当前编辑规则的id
		document.getElementById("curIndex").value = temp;
	}	 
}

function clickRemove(tabTitle)
{
	if(arp_rulenum  == 0)
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

function clickRemoveAll(tabTitle)
{
	if(arp_rulenum == 0)
	{
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('arp_removeFlag');
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = true;
		}
	}
	else
	{
		checkNodes.checked = true;
	}

	if(confirm(_("fw_deleteRuleConfirm")) == false)
	{		
		if(checkNodes.length > 0)
		{
			for(var i = 0; i < checkNodes.length; i++)
			{
				checkNodes[i].checked = false;
			}
		}
		else
		{
			checkNodes.checked = false;
		}	        
		return;
	}
	document.location = "/goform/arp_aging_delete_all";    
	
}

function checkValue()
{
	var arp_aging = getElement("arp_aging");
	
	if (!checkNumberLegal(arp_aging, 5, 1440)) 
	{
		alert(_("arpAgingIllegalAlert"));
		arp_aging.value = arp_aging.defaultValue;
		arp_aging.focus();
		return false;
	}
	if(getElement("arp_interface").value == '0')
	{
		alert(_("wanIllegalAlert"));
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
              <td id="arp_agingPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure the ARP aging time of a WAN port.</td>
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
                      <td><input type="button" value="Delete All" id="rule_deleteAll" class="submit" onClick="clickRemoveAll('ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/arp_agingDelete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="4" id="arp_agingListHead">ARP Aging List</td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center">ID</td>
                <td width="40%" align="center" id="wanTitle">WAN Name</td>
                <td width="43%" align="center" id="agingTitle">ARP Aging Time(s)</td>
                <td width="2%" align="center" ></td>
              </tr>
              <% arp_aging_sync(); %>
              <!--TR id='record_no' class='tabal_01' >
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
      <td><form id="ConfigForm" method="post" action="/goform/arp_aging" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td class="tabal_left" width="25%">WAN Name</td>
                  <td class="tabal_right" width="75%"><select id="arp_interface" name="arp_interface" size="1" style="width: 150px;">
                      <option value="0" id="arp_wanDisableTitle">Current WAN isn't available</option>
                    </select></td>
                </tr>
                <tr>
                  <td  class="tabal_left" width="25%">ARP Aging Time</td>
                  <td class="tabal_right" width="75%"><input name="arp_aging" id="arp_aging" size="17" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(5-1440s)</span></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="apply"  id="apply" class="submit">
                    <input type="reset" value="Cancel" name="cancel" id="cancel" class="submit" onClick="window.location.reload();">
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
