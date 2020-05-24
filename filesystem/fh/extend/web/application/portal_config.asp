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

var portal_cfg_size_sync = '<% portal_cfg_size_sync(); %>';
var portal_rulenum  = '<% getCfgGeneral(1, "portal_rulenum"); %>';

function LoadFrame()
{
	initTranslation();

	if(portal_rulenum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
	var portal_enalbe_val = '<% getCfgGeneral(1, "portal_enable"); %>';
	var portal_enalbe_mode = document.getElementsByName("portal_enalbe");
	showCheckboxNodeByValue(portal_enalbe_mode,portal_enalbe_val);	
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
	document.getElementById("portal_type").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("portal_type").options[0].selected = true;
			document.getElementById("portal_url").value = "";

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			showSelectNodeByValue(getElement('portal_type'), document.getElementById("portal_type_" + temp).innerHTML);
			document.getElementById("portal_url").value = document.getElementById("portal_url_" + temp).innerHTML;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}	

		//标志当前编辑规则的id
		document.getElementById("curIndex").value = temp;
	}	 
}

function clickRemove(tabTitle)
{
	if(portal_rulenum  == 0)
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

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="portalPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure portal. The browser displays a special web page based on your device type when you access the Internet for the first time.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" action="/goform/portal_enable" onSubmit="return checkPortalUrl(1)">
  <table id="tb_portal_enable" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%">Enable Portal</td>
        <td class="tabal_right" align="left"><input type="checkbox" name="portal_enalbe" value="1"></td>
      </tr>
      <tr>
        <td class="tabal_left">Default Redirection URL</td>
        <td class="tabal_right"><input name="portal_defaultUrl" size="17" style="width: 150px;" type="text" value='<% getCfgGeneral(1, "portal_defaultUrl"); %>'></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="portalEnableApply" class="submit">
          <input type="reset" value="Cancel" id="portalEnableCancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/portalDelete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="4" id="portalListHead">Portal Configuration List</td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center">ID</td>
                <td width="40%" align="center" id="typeTitle">Device Type</td>
                <td width="43%" align="center" id="urlTitle">Redirection URL Address</td>
                <td width="2%" align="center"></td>
              </tr>
              <% portal_cfg_sync(); %>
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
      <td><form id="ConfigForm" method="post" action="/goform/portal_config" onSubmit="return checkPortalUrl(2)">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td class="tabal_left" width="25%">Device Type</td>
                  <td class="tabal_right" width="75%"><select id="portal_type" name="portal_type" size="1" style="width: 150px;">
                      <option value=0>Computer</option>
                    </select></td>
                </tr>
                <tr>
                  <td  class="tabal_left" width="25%">Redirection URL Address</td>
                  <td class="tabal_right" width="75%"><input name="portal_url" id="portal_url" size="17" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="portalConfigApply" class="submit">
                    <input type="reset" value="Cancel" name="portalConfigCancel" class="submit" onClick="window.location.reload();">
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
