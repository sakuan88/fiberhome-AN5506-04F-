<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCP CLIENT REQUEST PARAMETER</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);


var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var currentline;
var previousTR = null;
var dhcpcli_req_size_sync = '<% dhcpcli_req_size_sync(); %>';
var dhcpReq_rulenum ='<% getCfgGeneral(1, "dhcpReq_rulenum"); %>';
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
	var wannameNode = getElement("dhcp_interface");
	
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R_") >= 0)  // 路由相关
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	if(wannameNode.length > 1)
	{
		wannameNode.options.remove(0);
	}
	
	if(dhcpReq_rulenum == 0)
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
	/* add begin by 陈鹏，20181113，原因:增加国际化 */
	var e = document.getElementById("dhcp_reqPrompt");
	e.innerHTML = _("dhcp_reqPrompt");

	e = document.getElementById("dhcp_reqListHead");
	e.innerHTML = _("dhcp_reqListHead");

	e = document.getElementById("dhcp_wanDisableTitle");
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
	
	/*add end by 陈鹏，20181113 */ 
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
	getElement("dhcp_interface").focus();
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
			document.getElementById("dhcp_interface").options[0].selected = true;
			document.getElementById("dhcp_interface").disabled = 0;
			document.getElementById("option_id").value = "";
			document.getElementById("option_req_seq").value = "";
			document.getElementsByName("optiomFormat").value = 0;
			document.getElementById("option_value").value = "";
			document.getElementById("option_value").disabled = 1;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("dhcp_interface").value = document.getElementById("dhcp_interface_" + temp).innerHTML;
			document.getElementById("option_id").value = document.getElementById("option_id_" + temp).innerHTML;
			document.getElementById("option_req_seq").value = document.getElementById("option_req_seq_" + temp).innerHTML;
			//showRadioNodeByValue(getElement('optiomFormat'), 0);
			document.getElementById("option_value").value = "";

			var curMode = getElement("option_mode_" + temp).innerHTML;
			var modeNode = getElement("option_mode");
			if(curMode == 'Hexadecimal')
			{
				showRadioNodeByValue(modeNode, '1');
			}
			else
			{	
				showRadioNodeByValue(modeNode, '0');
			}
		
		
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}

		//标志当前编辑规则的id
		document.getElementById("curIndex").value = temp;
	}	 
}

function clickRemove(tabTitle)
{
	if(dhcpReq_rulenum  == 0)
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

/* add begin by 陈鹏，20181113，原因:增加全删功能 */
function clickRemoveAll(tabTitle)
{
	if(dhcpReq_rulenum == 0)
	{
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('dhcp_req_removeFlag');
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
	document.location = "/goform/dhcpcli_req_delete_all";    
	
}

/* add end by 陈鹏，20181113 */

/*add begin by 陈鹏，20181113，原因:校验option_id /option_req_seq的重复性*/
function isOptionIdRepeat(k)
{
	var current_option_id = document.getElementById("option_id");
	var option_id = document.getElementById("option_id_" + k).innerHTML;

	if(option_id == current_option_id.value)  /*非当前规则中存在与当前option_id相同的规则 */
	{
		//alert("option_id已存在 ，请重新输入!");
		alert(_("option_id_RepeatAlert"));
		current_option_id.value = current_option_id.defaultValue;
		current_option_id.focus();
		return true;
	}		
	return false;
}

/*校验option_req_seq地址的重复性*/
function isOptionReqSeqRepeat(k)
{
	var current_option_req_seq = document.getElementById("option_req_seq");
	var option_req_seq = document.getElementById("option_req_seq_" + k).innerHTML.split('-')[0].split(':')[0];

	if(option_req_seq == current_option_req_seq.value)  /*非当前规则中存在与当前option_req_seq相同的规则 */
	{
		//alert("option_req_seq已存在 ，请重新输入!");
		alert(_("option_req_seq_RepeatAlert"));
		current_option_req_seq.value = current_option_req_seq.defaultValue;
		current_option_req_seq.focus();
		return true;
	}		
	return false;
}

function checkRepeat(temp)
{
	var k = 0;

	if(dhcpReq_rulenum > 0)
	{
		for(k = 0; k < dhcpReq_rulenum; k++)
		{
			if(temp != 'new') /*修改规则*/
			{
				if(temp != k) /*temp 为当前修改规则行号，不和自己进行比较*/
				{
					if(isOptionIdRepeat(k))
					{
						return false;
					}
					if(isOptionReqSeqRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增规则*/
			{	
				if(isOptionIdRepeat(k))
				{
					return false;
				}
				if(isOptionReqSeqRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;

}

/* add end by 陈鹏，20181113 */

function checkValue()
{
	var option_id = getElement("option_id");
	
	if (!checkOptionIdLegal(option_id, 1, 254)) //修改option id校验规则，option id不可为53、55
	{
		//alert("Please input legal Option ID: 1-254 except 53 and 55!"); 
		alert(_("dhcp_opt_idIllegalalert"));
		option_id.value = option_id.defaultValue;
		option_id.focus();
		return false;
	}
	
	var option_req_seq = getElement("option_req_seq");
	
	if (!checkNumberLegal(option_req_seq, 1, 8)) 
	{
		//alert("Please input legal Option request sequence!");
		alert(_("dhcp_opt_seqIllegalalert"));
		option_req_seq.value = option_req_seq.defaultValue;
		option_req_seq.focus();
		return false;
	}
	if(!checkRepeat(currentline))
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
              <td id="dhcp_reqPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/dhcpcli_req_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="4" id="dhcp_reqListHead">DHCP Client Request List</td>
              </tr>
              <tr class="tabal_title">
                <td width="20%" align="center" id="wan_title">WAN name</td>
                <td width="18%" align="center" id="optionId_title">Option ID</td>
                <td width="15%" align="center" id="optionRes_seq_title">Option request sequence</td>
                <td width="15%" align="center" id="option_format">Option Format</td>
                <td width="25%" align="center" id="options_foramt_title">Options in Base64 format</td>
                <td width="7%" align="center" ></td>
              </tr>
              <% dhcpcli_req_sync(); %>
               <!--TR id='record_no' class='tabal_01' >
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
      <td><form id="ConfigForm" method="post" action="/goform/dhcpcli_req_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td class="tabal_left" width="25%">WAN name</td>
                  <td class="tabal_right" width="75%"><select id="dhcp_interface" name="dhcp_interface" size="1" style="width: 150px;">
                      <option value="0" id="dhcp_wanDisableTitle">Current WAN isn't available</option>
                    </select>
                    <strong style="color:#FF0033">*</strong></td>
                </tr>
                <tr>
                  <td class="tabal_left" width="25%">Option ID</td>
                  <td class="tabal_right" width="75%"><input name="option_id" id="option_id" size="17" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(1-254)</span></td>
                </tr>
                <tr>
                  <td class="tabal_left" width="25%">Option request sequence</td>
                  <td class="tabal_right" width="75%"><input name="option_req_seq" id="option_req_seq" size="10" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(1-8)</span></td>
                </tr>
                <tr>
                  <td class="tabal_left" id="Option format_title" align="left" width="18%">Option format</td>
                  <td class="tabal_right" colspan="6" align="left" width="82%"><input checked="checked" value="1" name="option_mode" 
        				type="radio">
                    <font id="hexadecimal"></font>Hexadecimal
                    <input value="0" name="option_mode" type="radio" >
                    <font id="base64">Base64</font></td>
                </tr>
                <tr>
                  <td class="tabal_left" width="25%">Option value</td>
                  <td class="tabal_right" width="75%"><input name="option_value" id="option_value" disabled="disabled" size="14" 
                    	style="width: 150px;" type="text"></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="apply" id="apply" class="submit">
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
