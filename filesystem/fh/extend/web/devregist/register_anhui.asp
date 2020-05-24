<!-- saved from url=(0022)http://internet.e-mail -->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>设备注册</title>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" language="javascript">
var devRegisterSync = '<% devRegisterSync(); %>';

var start = '0';
var bar;
var res;
var count = 0;
var result_flag = 0;
var result_count = 0;
//var request  = initXMLHttpClient();
var request = getRequest();
var progress;

var oltAuthRst = '<% getCfgGeneral(1, "olt_auth_rst"); %>';
var getACSIPRst;
var authStatus = '<% getCfgGeneral(1, "auth_status"); %>';
var authResult = '<% getCfgGeneral(1, "auth_result"); %>';
var authTimes = '<% getCfgGeneral(1, "auth_times"); %>';
var authLimit = '<% getCfgGeneral(1, "auth_limit"); %>';

var iNeedAcsAuthFlag;

var loId;
var loPwd;
function LoadFrame()
{
	var codeTxt;
	if(parseInt(devRegisterSync) == 0)
	{
		if(parseInt(authStatus) == 5)
		{
			if(parseInt(authResult) == 1)
			{
				codeTxt = "已经注册成功，无需重新注册。";
			}
			else
			{
				codeTxt = "已经注册成功，无需重新注册。如需重新注册，请进行配置全恢复后尝试。";
			}
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else if(parseInt(authStatus) == 0 && parseInt(authResult) == 1)
		{
			codeTxt = "注册成功，下发业务成功。";
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else if(parseInt(authResult) == 0 || parseInt(authResult) == 2)
		{
			codeTxt = "上次设备注册业务下发不完整，请登录WEB进行配置全恢复后重新注册。";
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else
		{
			setDisplay("tb_register","");
			setDisplay("tb_progressBar","none");
		}
		
	}
	else
	{
		setDisplay("tb_register","");
		setDisplay("tb_progressBar","none");
	}
}

function codeTransform()
{
	var codeTxt;
	var codeTxt2;
	if(parseInt(oltAuthRst) == 99)
	{
		codeTxt = "终端正在注册OLT";
	}
	else if(parseInt(oltAuthRst) != 0)
	{
		switch(parseInt(oltAuthRst))
		{
			case -1:
				codeTxt = "在OLT上注册失败，请检查逻辑ID和密码是否正确。";
				break;
			case 2:
				codeTxt = "在OLT上注册失败(逻辑ID错误)，请检查逻辑ID和密码是否正确。";
				break;
			case 3:
				codeTxt = "在OLT上注册失败(逻辑密码错误)，请检查逻辑ID和密码是否正确。";
				break;
			case 4:
				codeTxt = "在OLT上注册失败(逻辑ID冲突)，请检查逻辑ID和密码是否正确。";
				break;
			case 10:
				codeTxt = "在OLT上注册失败(物理SN冲突)，请检查输入是否正确。";
				break;
			case 11:
				codeTxt = "在OLT上注册失败(无资源)，请重试。";
				break;
			case 12:
				codeTxt = "在OLT上注册失败(ONU类型错误)。";
				break;
			case 13:
				codeTxt = "在OLT上注册失败(物理SN错误)，请检查输入是否正确。";
				break;
			case 14:
				codeTxt = "在OLT上注册失败(物理密码错误)，请检查输入是否正确。";
				break;
			case 15:
				codeTxt = "在OLT上注册失败(物理密码冲突)，请检查输入是否正确。";
				break;
			default:
				codeTxt = "在OLT上注册失败，请重试。";
				break;				
		}
		
	}
	else
	{
		if(parseInt(getACSIPRst) == 99)
		{
			codeTxt = "OLT注册成功，终端正在获取管理地址；";
		}
		else if(parseInt(getACSIPRst) == -1)
		{
			codeTxt = "终端获取管理地址失败，请重试。";
		}
		else		//getACSIPRst == 0
		{
			if(iNeedAcsAuthFlag == 0)	//first display
			{
				codeTxt = "终端获取管理地址成功；";
			}
			else
			{
				if(parseInt(authTimes) < parseInt(authLimit))
				{
					codeTxt2 = "请重试（剩余尝试次数：" + (parseInt(authLimit) - parseInt(authTimes)) + ")";
				}
				else
				{
					codeTxt2 = "已超出终端认证最大次数，请联系客服。";
				}
				switch(parseInt(authStatus))
				{
					case 0:
						switch(parseInt(authResult))
						{
							case 99:
								codeTxt = "终端注册ACS管理平台成功；";
								break;
							case 0:
								codeTxt = "ACS正在下发业务，请勿断电或插拔光纤；";
								break;
							case 1:
								codeTxt = "注册全部完成，业务下发配置成功，欢迎使用!";
								break;
							case 2:
								codeTxt = "注册成功，下发业务失败。";
								break;
							default:
								codeTxt = "终端注册ACS管理平台成功；";
								break;
						}
						break;
					case 1:
						codeTxt = "用户认证码不存在。" + codeTxt2;
						break;
					case 2:
						codeTxt = "用户逻辑ID不存在。" + codeTxt2;
						break;
					case 3:
						codeTxt = "用户逻辑ID与用户认证码匹配失败。" + codeTxt2;
						break;
					case 4:
						codeTxt = "注册超时！请检查线路后重试。";
						break;
					case 5:
						codeTxt = "已经注册成功，无需重新注册。";
						break;
					case 99:
						codeTxt = "终端正在注册ACS管理平台；";
						break;
					default:
						codeTxt = "注册失败，请重试。";		/* 规范里无此提示信息 --获取注册结果失败 */
						break;
				}
			}
		}
	}

	return codeTxt;
}

function identityRegist()
{	
	with ( document.forms[0] ) 
	{
		if(LOID.value.length <= 0) {
			alert("逻辑ID为空，请输入逻辑ID!");
			return false;
		}

		if(LOPWD.value.length <= 0) {
			LOPWD.value="";
		}
		register();
		return true;
	}	
}
function register(){	
	setDisplay("tb_register","none");
	setDisplay("tb_progressBar","");
	
	progress = new CProgress("progress", 300, 15, 0);
	progress.Create();
	if(start == 0)
	{
		send_request();
		bar = setInterval("progress.Inc();",200);
//		res = setInterval("checkresult();",5000);
		res = setInterval("checkresult();",10000);	//2011-10-13　应丰工要求，修改为10秒
	}
	else if(start == 2)
	{
		document.getElementById("information").innerHTML = "注册次数已超过最大重试次数<br>请联系客服。";
	}
	else
	{
		document.getElementById("information").innerHTML = "服务器内部错误。";
	}
}

function CProgress(progressIdStr, width, height, pos)
{
    this.progressIdStr = progressIdStr;
    this.progressId = document.getElementById(this.progressIdStr);
    this.barIdStr = progressIdStr + "_bar";
    this.barId = null;
    
    this.pos = pos>=100?100:pos;
    this.step = 1;
	this.rate = 10;
	this.limit = 10;
	this.result = "终端正在向OLT注册；";

    this.progressWidth = width;
    this.progressHeight = height;
    
    this.Create = Create;

    this.SetStep = SetStep;
    this.SetPos = SetPos;
	this.SetResult = SetResult;
	this.SetRate = SetRate;
	this.SetLimit = SetLimit;
    this.Inc = Inc;
    this.Desc = Desc;
}

function Create()
{
    if (document.all)
    {
        this.progressId.style.width = this.progressWidth+2;
    }
    else
    {
        this.progressId.style.width = this.progressWidth;
    }
    this.progressId.style.height = this.progressHeight;
    this.progressId.style.fontSize = this.progressHeight;
    this.progressId.style.border = "1px solid #000000";
    this.progressId.innerHTML = "<div id=\"" + this.barIdStr + "\" style=\"background-color:#aabbcc;height:100%;text-align:center\"></div>";
    this.barId = document.getElementById(this.barIdStr);
    this.SetPos(this.pos);
}

function SetStep(step)
{
    this.step = step;
}

function SetPos(pos)
{
    this.pos = (pos<=0)?0:pos;
    this.pos = (parseInt(this.pos) >parseInt(this.limit))?this.limit:this.pos;
    if(this.rate == -1)
    	this.pos = 100;

		showResult();
}

function Inc()
{
	count++;		
	this.pos = parseInt(this.pos) + parseInt(this.step);
	this.SetPos(this.pos);
}

function Desc()
{
    this.pos -= this.step;
    this.SetPos(this.pos);
}

function SetLimit(limit){
	this.limit = limit<0?0:limit;
	this.limit = this.limit>100?100:this.limit;
}

function SetRate(rate){	
	this.rate = rate;

	if(parseInt(rate) > parseInt(this.pos)){
		this.SetLimit(parseInt(rate));
	}
}

function SetResult(result){
	this.result = result;
}

function showResult(){	
	if(count > 3000) {								//2400	--8分钟	//2011-10-13应丰工要求修改为10分钟
		progress.barId.style.width = "100%";
		document.getElementById("information").innerHTML = 
			"<a href=\"/devregist/register_anhui.asp\">注册超时！请检查线路后重试。</a>";
	}else{
		progress.barId.style.width = progress.pos+"%";
//		if(parseInt(progress.pos) >= parseInt(progress.rate))
			document.getElementById("information").innerHTML = progress.result;
	}

	progress.barId.innerHTML=progress.barId.style.width;

	if(progress.barId.style.width == "100%"){
		window.clearInterval(bar);
		window.clearInterval(res);
		return;
	}
}

 // create an XMLHttpClient in a cross-browser manner  
 function initXMLHttpClient(){  
   var xmlhttp;  
   try {xmlhttp=new XMLHttpRequest()} // Mozilla/Safari/IE7 (normal browsers)  
   catch(e){                          // IE (?!)  
     var success=false;  
     var XMLHTTP_IDS=new Array('MSXML2.XMLHTTP.5.0','MSXML2.XMLHTTP.4.0',  
                               'MSXML2.XMLHTTP.3.0','MSXML2.XMLHTTP','Microsoft.XMLHTTP');  
     for (var i=0; i<XMLHTTP_IDS.length && !success; i++)  
       try {success=true; xmlhttp=new ActiveXObject(XMLHTTP_IDS[i])} catch(e){}  
     if (!success) throw new Error('Unable to create XMLHttpRequest!');  
   }  
   return xmlhttp;  
 }  
 
 function send_request(){ 
	loId = document.getElementById("LOID").value;
	loPwd = document.getElementById("LOPWD").value;
	request.open('GET','/goform/devRegister?LOID=' + loId + '&LOPWD=' + loPwd + '&' + Math.random(), true); // open asynchronus request  
	request.onreadystatechange = request_handler;          // set request handler  
	request.send(null);                                    // send request  
 } 

 function request_handler()
 { 
   if (request.readyState == 4){ // if state = 4 (the operation is completed)  
   
     if (request.status == 200 || request.status == 0){ // and the HTTP status is OK  
       // get progress from the XML node and set progress bar width and innerHTML  
		var array = request.responseText.split("|");
		oltAuthRst = array[0];
		getACSIPRst = array[1];
		authStatus = array[2];
		authResult = array[3];
		authTimes = array[4];
		authLimit = array[5];
		iNeedAcsAuthFlag = array[6];
		progress.SetRate(array[7]);	   
		progress.SetResult(codeTransform());
		result_flag = 1;
		result_count += 1;
     }  
     else{ // if request status is different then 200  
       progress.style.width = '100%';  
       progress.innerHTML='Error: ['+request.status+'] '+request.statusText;  
     }  
   }
 } 

 function checkresult(){
	 
	if(result_flag == 1){
		result_flag = 0;
		send_request();		
	}
 }
</script>
</head>
<body onLoad="LoadFrame();">
<form>
  <table align="center" border="0" cellpadding="0" cellspacing="0" height="768" width="1024">
    <tbody>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td><table align="middle" border="0" cellpadding="0" cellspacing="0" height="768" width="1024">
            <tbody>
              <tr>
                <td rowspan="3" width="77"></td>
                <td align="center" background="../images/login_ct.jpg" height="768" width="1024">
                <table border="0" cellpadding="0" cellspacing="0" height="30" width="700">
                    <tbody>
                      <tr>
                         <td align="right"><a href="../login.html"><font color="#000000" size="2">返回登录页面</font></a></td>
                      </tr>
                    </tbody>
                  </table>
					<table border="0" cellpadding="0" cellspacing="0" height="50" width="320">
                    <tbody>
                      <tr>
                        <td colspan="2" align="left" height="25">宽带账号注册</td>
                        </tr>
                    </tbody>
                  </table>
                  <table id="tb_register" border="0" cellpadding="0" cellspacing="0" height="200" width="300" style="display:none">
                    <tbody>
                      <tr>
                        <td colspan="2" height="12"></td>
                      </tr>
					  
                      <tr>
                        <td colspan="2" align="center" height="25">注:请您依次输入逻辑ID和密码。</td>
                      </tr>
                      <tr>
                        <td align="right" height="25" valign="bottom" width="130">逻辑ID：</td>
                        <td align="left" valign="bottom" width="200"><input name="LOID" id="LOID" size="24" maxlength="24" type="text"></td>
                      </tr>
                      <tr height="8">
                        <td colspan="2"></td>
                      </tr>
                      <tr>
                        <td align="right" height="25" valign="top" width="130">密&nbsp;&nbsp;码：</td>
                        <td align="left" valign="top" width="200"><input name="LOPWD" id="LOPWD" size="24" maxlength="12" type="text"></td>
                      </tr>
                      <tr>
                 
                        <td colspan="2" align="center" width="200" height="35">&nbsp; &nbsp;&nbsp;&nbsp;<input name="submit" value="&nbsp;注&nbsp;册&nbsp;" type="button" onClick="identityRegist()">
                          &nbsp;&nbsp;&nbsp;
                          <input name="cancel" value="&nbsp;取&nbsp;消&nbsp;" type="reset">
                        </td>
                      </tr>
					  
                      <tr>
                        <td colspan="2" height="20"></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center" height="20" width="100%"><font size="2">  </font></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="left" height="30"></td>
                      </tr>
                    </tbody>
                  </table>
                  <table id="tb_progressBar" align="center" border="0" cellpadding="0" cellspacing="0" height="200" width="400">
                  <tbody>
                    <tr>
                      <td colspan="2" id="note" height="32"></td>
                    </tr>
                    <tr align="">
                      <td colspan="2" align="center" height="10" width="400">
                      	<div style="width: 300px; height: 15px; font-size: 15px; border: 1px solid rgb(0, 0, 0);" id="progress" align="left">
                      		<div id="progress_bar" style="background-color: rgb(170, 187, 204); height: 100%; text-align: center;"></div>
                      	</div></td>
                    </tr>
                    <tr>
                      <td colspan="2" id="information" align="center" height="20" width="400">正在注册，请等待... </td>
                    </tr>
                    <tr>
                      <td colspan="2" align="center" height="20" width="100%"><font size="2">   </font></td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left" height="60"></td>
                    </tr>
                  </tbody>
                </table></td>
                <td rowspan="3" width="78"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
