<html>

<head>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
	<title>Login Bro</title>
	<script type="text/javascript" src="/lang/b28n.js"></script>
</head>

<body>
	<h1>Logine</h1>
	<form name="login" method="post" action="/goform/webLogin">
		<table>
			<tbody>
				<tr>
					<td height="30%" width="100%">
						<table align="center" border="0" height="100%" width="100%">
							<tbody>
								<tr>
									<td width="35%">
										<font id="accounttitle" class="STYLE6">Jenenge</font>
									</td>
									<td width="65%"><input name="User" id="User" value="" maxlength="32" type="text"
											style="width:130px; height:28px;">
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td height="30%" width="100%">
						<table align="center" border="0" height="100%" width="100%">
							<tbody>
								<tr>
									<td width="35%" height="30%">
										<font id="pwdtitle" class="STYLE6">Passworde</font>
									</td>
									<td width="65%"><input name="Passwd" id="Passwd" value="" maxlength="32"
											type="password" style="width:130px; height:28px;"></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td height="30%" width="100%">
						<table align="center" border="0" height="100%" width="100%">
							<tbody>
								<tr>
									<td width="40%" id="td_submit"><input type="submit" class="STYLE2" value="Login"
											id="submit"></td>
									<td width="5%"></td>
									<td width="40%" id="td_reset"><input type="reset" class="STYLE2" value="Cancel"
											id="reset"></td>
									<td width="5%"></td>
									<td width="30%" id="td_regist" align="center" style="display: none"><input
											id="devReg" type="button" class="STYLE2" value="Regist"
											onClick="gotoRegisterPage()">
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		</td>
		</tr>
		<tr>
			<td width="28%" height="35%">
				<table valign="middle" height="100%" width="100%">
					<tbody>
						<tr>
							<td height="30%" width="100%">
								<table align="center" border="0" height="100%" width="100%">
									<tbody>
										<tr>
											<td width="5%"></td>
											<td width="90%" align="center" id="td_error"><span class="STYLE4"
													id="span_error"></span></td>
											<td width="5%"></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td height="40%" width="100%"></td>
						</tr>
						<tr>
							<td height="30%" width="100%"></td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		</tbody>
		</table>
	</form>
	<script type="text/javascript">
		var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
		var login_error = '<% getCfgGeneral(1, "login_error");%>';
		window.document.forms[0].User.focus();

		if (login_error != '0') {
			document.getElementById("submit").disabled = 0;
			document.getElementById("td_error").disabled = 1;
		}
		if (login_error == '1') {
			document.getElementById("span_error").innerHTML = _("namePwdError");
		}
		else if (login_error == '2') {
			document.getElementById("span_error").innerHTML = _("adminUnavailable");
		}
		else if (login_error == '3') {
			document.getElementById("span_error").innerHTML = _("serverError");
		}
		else if (login_error == '4') {
			document.getElementById("span_error").innerHTML = _("logoutError");
		}
		else if (login_error == '5') {
			document.getElementById("span_error").innerHTML = _("haveuserLogin");
		}
		else if (login_error == '6') {
			if (ispName == 22)	//泰锟斤拷TRUE锟斤拷锟斤拷30锟斤拷锟斤拷
				document.getElementById("span_error").innerHTML = _("3timeError_30");
			else
				document.getElementById("span_error").innerHTML = _("3timeError");
		}
		else if (login_error == '7') {
			document.getElementById("span_error").innerHTML = _("ipNotAllowError");
		}

	</script>
</body>
</html>