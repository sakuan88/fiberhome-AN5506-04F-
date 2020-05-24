<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCP Client Option Configuration</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;

var dhcpcli_option_size_sync = '<% dhcpcli_option_size_sync(); %>';
var ruleSum  = '<% getCfgGeneral(1, "dhcpcli_option_size"); %>';
var currentline;

var wanNameSync = '<% wanNameSync(); %>';

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
	var wannameNode = getElement("wan_name");
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

function initTranslation()
{
	/* add begin by 陈鹏，20181113，原因:增加国际化 */
	var e = document.getElementById("dhcp_optionPrompt");
	e.innerHTML = _("dhcp_optionPrompt");

	e = document.getElementById("dhcp_optionListHead");
	e.innerHTML = _("dhcp_optionListHead");

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
	getElement("wan_name").focus();
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
			document.getElementById("wan_name").options[0].selected = true;
			getElement("wan_name").disabled = false;
			document.getElementById("option_id").value = "";
			showRadioNodeByValue(getElement('option_mode'), 0);
			document.getElementById("option_value").value = "";
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			var curWan = getElement("wan_name_" + temp).innerHTML;
			var wanNode = getElement("wan_name");
			showSelectNodeByValue(wanNode, curWan);
			
			/* delete begin by 陈鹏,20181113，原因:修正 wan_name为灰选时，配置下发为空,页面回读为空*/
			/*if(wanNode.value != curWan)
			{
				wanNode.value = 0;
			}
			else
				wanNode.disabled = true;
			*/
			/* delete end by 陈鹏,20181113*/	
			
			document.getElementById("option_id").value = document.getElementById("option_id_" + temp).innerHTML;
			showRadioNodeByValue(getElement('option_mode'), 0);
			document.getElementById("option_value").value = document.getElementById("option_value_" + temp).innerHTML;

			var curMode = getElement("option_mode_" + temp).innerHTML;
			var modeNode = getElement("option_mode");
			if(curMode == 'Hexadecimal')
				showRadioNodeByValue(modeNode, '1');
			else
				showRadioNodeByValue(modeNode, '0');
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

/* add begin by 陈鹏，20181113，原因:增加全删功能 */
function clickRemoveAll(tabTitle)
{
	if(ruleSum == 0)
	{
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('dhcpcli_option_removeFlag');
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
	document.location = "/goform/dhcpcli_option_delete_all";    
	
}

/* add end by 陈鹏，20181113 */

var curOptionMode = 0;
function ChangeOptionMode(newMode)
{
	var optionModeNode = getElement('option_mode');
	var dhcpoption = getValue('option_value');
      
	if (curOptionMode == newMode)
	   return;       

	if (dhcpoption == '')
	{
	   curOptionMode = newMode;
	   return;
	}
   
	if (1 == newMode)// Hexadecimal 
	{
	    if (isValidAscii(dhcpoption) != '')
		{
	        //alert("The option value is invalid.");
			alert(_("option_valueIllegalAlert"));
	        showRadioNodeByValue(optionModeNode, curOptionMode);
	        return ;
		}
	     
	    for (i = 0; i < dhcpoption.length; i++)
	    {   
	        if (isHexaDigit(dhcpoption.charAt(i)) == false)
	        {
				//alert("Please enter a valid hexadecimal string.");
				alert(_("option_valueInvalidateAlert"));
				showRadioNodeByValue(optionModeNode, curOptionMode);
	            return ;
	        }
	    }

	    var dhcpoption64 = ConvertHexToBase64(dhcpoption);
		if(dhcpoption64.length > 340)
		{
		    //alert("The option value length exceeds the maximum allowed.");
			alert(_("option_valueLengthMaxAlert"));
		    showRadioNodeByValue(optionModeNode, curOptionMode);
		    return ;
		}

	    setText('option_value', dhcpoption64);
	}
	else
	{   
	    if (!isValidBase64(dhcpoption))
		{
		    //alert("Please enter a valid Base64 string.");
			alert(_("Base64InvalidxAlert"));
		    showRadioNodeByValue(optionModeNode, curOptionMode);
		    return ;
		}

		if(dhcpoption.length > 340)
		{
		    //alert("The option value length exceeds the maximum allowed.");
			alert(_("option_valueLengthMaxAlert"));
		    showRadioNodeByValue(optionModeNode, curOptionMode);
		    return ;
		}

	   setText('option_value', ConvertBase64ToHex(dhcpoption));
	}
      
}

/*add begin by 陈鹏，20181113，原因:校验option_id的重复性*/
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

/* 校验option_id重复性*/
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
					if(isOptionIdRepeat(k))
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
			}
		}
	}
	return true;

}

/* add end by 陈鹏，20181113 */

function checkValue()
{
	if(getElement("wan_name").value == '0')
	{
		alert(_("wanIllegalAlert"));
		return false;
	}

	var optionIPNode = getElement("option_id");	
	if (!checkOptionIdLegal(optionIPNode, 1, 254)) //修改option id校验规则，option id不可为53、55
	{
		//alert("Please input legal option id: 1-254 except 53 and 55!");
		alert(_("dhcp_opt_idIllegalalert"));
		optionIPNode.value = optionIPNode.defaultValue;
		optionIPNode.focus();
		return false;
	}
	
	var optionModeNode = getElement('option_mode');
	var dhcpoption = getValue('option_value');
	if (1 == getRadioVal('option_mode'))//Hexadecimal
	{
		if (isValidAscii(dhcpoption) != '' || !CheckNotNull(dhcpoption))
	    {
	    	//alert("The option value is invalid.");
			alert(_("option_valueIllegalAlert"));
			return false;
	    }
	        
	    for (i = 0; i < dhcpoption.length; i++)
	    {   
			if (!isHexaDigit(dhcpoption.charAt(i)))
	        {
				//alert("Please enter a valid hexadecimal string.");
				alert(_("option_valueInvalidateAlert"));
	            return false;
	        }
	    }
	             
	    var dhcpvalue64 = ConvertHexToBase64(dhcpoption);
	    
	    if(dhcpvalue64.length > 340)
	    {
	    	 //alert("The option value length exceeds the maximum allowed.");
			 alert(_("option_valueLengthMaxAlert"));
	        return false;
	    }
		
	}
	else
	{
		if(!CheckNotNull(dhcpoption)) // option value为空
		{
			alert(_("option_valueIllegalAlert"));
		}
		if (!isValidBase64(dhcpoption))
	    {
	        //alert("Please enter a valid Base64 string.");
			alert(_("option_valueBase64InvalidAlert"));
	        return false;
	    }
	    
	    if(dhcpoption.length > 340)
	    {
	    	//alert("The option value length exceeds the maximum allowed.");
			alert(_("option_valueLengthMaxAlert"));
	        return false;
	    }
	}

	if(!checkRepeat(currentline))
	{
		return false;
	}
			
	return true;
}
function setDHCPClientOption()
{
	var content;
	if(checkValue())
	{
		var option_mode = getValue('option_mode');
		var option_value = getValue('option_value');
		if(option_mode == 1)
			option_value = ConvertHexToBase64(option_value);
		content = "wan_name=" + getValue('wan_name') 
				+ "&option_id=" + getValue('option_id') 
				+ "&option_value=" + option_value;
		console.info('content: ' + content);
		makeRequest("/goform/dhcpcli_option_cfg", content, rstHandler);
	}
}

function rstHandler(http_request)
{
	if (http_request.readyState == 4)		//the operation is completed
	{
		if (http_request.status == 200)		// and the HTTP status is OK 
		{
			window.location.reload();
		}  
		else									// if request status is different then 200  
		{
			console.info('Error: ['+http_request.status+'] ' + http_request.statusText);  			
		}
	}
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
              <td id="dhcp_optionPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure the DHCPv4 options carried by the DHCP client for the route WAN. The DHCPv4 options can be in hexadecimal or Base64 format.</td>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/dhcpcli_option_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="4" id="dhcp_optionListHead">DHCP Client Option List</td>
              </tr>
              <tr class="tabal_title">
                <td width="30%" align="center" id="urlip">WAN Name</td>
                <td width="18%" align="center" id="urltime">Option ID</td>
                <td width="18%" align="center" id="urltime">Option Format</td>
                <td width="30%" align="center" id="urltime">Options in Base64 format</td>
                <td width="4%" align="center" ></td>
              </tr>
              <% dhcpcli_option_sync() ; %>
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
      <td><form id="ConfigForm" method="post" action="/goform/dhcpcli_option_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td class="tabal_left" width="25%">WAN Name</td>
                  <td class="tabal_right" width="75%"><select id="wan_name" name="wan_name" size="1" style="width: 150px;">
                      <option value="0" id="dhcp_wanDisableTitle">Current WAN isn't available</option>
                    </select></td>
                </tr>
                <tr>
                  <td  class="tabal_left" width="25%">Option ID</td>
                  <td class="tabal_right" width="75%"><input name="option_id" id="option_id" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(1-254)</span></td>
                </tr>
                <tr>
                  <td  class="tabal_left" width="25%">Option Format</td>
                  <td class="tabal_right" width="75%"><input name="option_mode" id="hex" value="1" checked="checked" onClick="ChangeOptionMode(this.value)" type="radio"/>
                    <span id="format_hexTitle">Hexadecimal</span>
                    <input name="option_mode" id="base64" value="0" checked="checked" onclick="ChangeOptionMode(this.value)" type="radio"/>
                    <span id="format_base64Title">Base64</span></td>
                </tr>
                <tr>
                  <td  class="tabal_left" width="25%">Option Value</td>
                  <td class="tabal_right" width="75%"><input name="option_value" id="option_value" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span>(a Base64 string of 1-340 digits or a hexadecimal string)</span></td>
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
