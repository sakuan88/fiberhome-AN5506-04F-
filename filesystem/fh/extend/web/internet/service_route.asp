<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Service Route Configuration</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);

var previousTR = null;

var service_route_size_sync = '<% service_route_size_sync(); %>'
var serviceRoute_rulenum ='<% getCfgGeneral(1, "serviceRoute_rulenum"); %>';
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
	var wannameNode = getElement("route_interface");
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_B_") >= 0)
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	if(wannameNode.length > 1)
	{
		wannameNode.options.remove(0);
	}

	if(serviceRoute_rulenum == 0)
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
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 32)
	{
 		alert(_("rule_most32RulesAlert"));
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
	getElement("route_interface").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("route_interface").options[0].selected = true;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("route_interface").value = document.getElementById("route_interface_" + temp).innerHTML;
			showSelectNodeByText(getElement('service_type'), document.getElementById("service_type_" + temp).innerHTML);

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}	

		//标志当前编辑规则的id
		getElement("curIndex").value = temp;	

	}	 
}

function clickRemove(tabTitle)
{
	if(serviceRoute_rulenum  == 0)
	{			
 		alert(_("rule_noRuleAlert"));
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
		alert(_("rule_noChooseAlert"));
		return ;
	}
	        
	if(confirm(_("pf_deleteRuleConfirm")) == false)
    	return;
	
	var form = document.getElementById(tabTitle).getElementsByTagName('form');
	form[0].submit();
}

function checkValue()
{
	if(getElement("route_interface").value == '0')
	{
		alert(_("pf_wanIllegalAlert"));
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
              <td id="service_routePrompt" style="padding-left: 10px;" class="title_01"
                  width="100%">On this page,you can configure a route for a service.Then the packets of the service are sent to the OLT through the specified WAN port.</td>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/service_routeDelete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="3" id="service_RouteListHead">Service Route List</td>
              </tr>
              <tr class="tabal_title">
                <td width="45%" align="center" id="serviceTitle">Service Type</td>
                <td width="50%" align="center" id="wanTitle">WAN Name</td>
                <td width="5%" align="center" ></td>
              </tr>
              <% service_route_sync(); %>
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
      <td><form id="ConfigForm" method="post" action="/goform/service_route_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td class="tabal_left" width="25%">Service Type</td>
                  <td class="tabal_right" width="75%"><select id="service_type" name="service_type" size="1" style="width: 150px;">
                      <option value="0" id="serviceType_value" selected="selected">PPPoE</option>
                    </select>
                    <strong style="color:#FF0033">*</strong> </td>
                </tr>
                <tr>
                  <td class="tabal_left" width="25%">WAN Name</td>
                  <td class="tabal_right" width="75%"><select id="route_interface" name="route_interface" size="1" style="width: 150px;">
                      <option value="0" id="route_wanDisableTitle">Current WAN isn't available</option>
                    </select>
                    <strong style="color:#FF0033">*</strong></td>
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
