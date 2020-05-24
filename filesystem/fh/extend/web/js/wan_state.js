/***********************************************************************************
wan_state.js
wuxj
2017.12.8
wan state common js functions
***********************************************************************************/

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];		
		
		var up_time = uptime_buff.split("|")[temp];
		var up_time_hour = parseInt(up_time/3600);
		var up_time_hour_text;
		up_time_hour_text = up_time_hour + " h ";
		
		var up_time_min = parseInt((up_time - up_time_hour*3600)/60);
		var up_time_min_text;
		up_time_min_text = up_time_min + " m ";
	
		var up_time_sec = up_time%60;
		var up_time_sec_text;
		up_time_sec_text = up_time_sec + " s ";
	
		document.getElementById("wan_mac").innerHTML = wan_mac_buff.split("|")[temp];
		document.getElementById("wan_uptime").innerHTML = up_time_hour_text + up_time_min_text + up_time_sec_text;
		document.getElementById("wan_gateway").innerHTML = wan_gateway_buff.split("|")[temp];

		if(ispName == 26)/* 巴西TIM Wan State 增加 Mac Address列*/
		{
			document.getElementById("td_wan_mac").value = getElement("wan_mac_" + temp).innerHTML;
		}
		
		var curIPMode = getElement("ip_mode_" + temp).innerHTML;
		var curPppCode = pppoe_state.split("|")[temp];
		if(ispName == 15)
		{
			if(curIPMode == 'PPPoE')
			{
				setDisplay("tr_ppp_state", "");
				getElement("ppp_stateDetail").innerHTML = getPppoeState(parseInt(curPppCode));
			}
			else
			{
				setDisplay("tr_ppp_state", "none");
			}
		}
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;
	}	 
}

function getPppoeState(code)
{
	switch(code)
	{
		case 0:
			return "OK";
			break;
		case 15:
		case 22:
		case 23:
			return "Request sent but no reply from server";
			break;
		case 11:
		case 19:
		case 21:
			return "Authenticaltion failed";
			break;
		default:
			return "Internet is down";
			break;
	}
}
