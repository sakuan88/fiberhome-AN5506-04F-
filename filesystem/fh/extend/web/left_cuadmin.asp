<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>welcome</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
<script type="text/javascript" src="/js/utils.js"></script>
<script language="JavaScript" type="text/javascript">
function show()
{
	var checkResult = '<%cu_web_access_control();%>';
	var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';
	getAccessLoginPageForCUAdmin(checkResult, ispMinorNameCode);

}
</script>
</head>
<body onLoad="show()">
</body>
</html>
