<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<title>Fault Info Collect</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("restore", lang);

function initTranslation()
{
}
//loadpage
function LoadFrame()
{ 
	initTranslation();
}
/*-----------------------adapte funcion--------------------------*/
function start()
{
	getElement('start').disabled = true;
	makeRequest("/goform/fault_collect", "n/a", collectHandler);
}
function collectHandler(http_request)
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			getElement('start').disabled = false;
			var responseText = http_request.responseText;
			if(responseText == '-1')
			{
				getElement("div_rst").innerHTML = 'Collection failed!';
			}
			else
			{
				getElement("div_rst").innerHTML = 'Collection finished!';
				setDisplay("area_info", "");
				getElement("area_info").innerHTML = responseText;
			}
				
		 }  
		else	// if request status is different then 200  
		{
			getElement("div_rst").innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}

</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="reboot_Prompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can collect and view fault information.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<div>
  <div id="div_button">
    <input class="submit" id="start" style="width: 98px;" value="Start" type="button" onClick="start()">
  </div>
  <br>
  <div id="div_rst"></div>
  <div>
    <textarea rows="20" cols="116" readonly="readonly" name="area_info" id="area_info" style="display: none">
        </textarea>
  </div>
</div>
</body>
</html>
