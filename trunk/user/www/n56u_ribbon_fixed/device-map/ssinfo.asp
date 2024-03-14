<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script>
var $j = jQuery.noConflict();
$j(document).ready(function() {
	document.querySelector("#google_ico").src="https://www.google.com/favicon.ico?" + new Date().getTime();
});
</script>

<style>
.table-list td {
    padding: 6px 8px;
}
.table-list input,
.table-list select {
    margin-top: 0px;
    margin-bottom: 0px;
}
</style>
</head>

<body class="body_iframe" >

<ul class="nav nav-tabs">
    <li><a href="ss.asp">设置参数</a></li>
    <li class="active"><a href="javascript:;">查询Shadowsocks</a></li>
</ul>
<div class="jumbotron">
		<table class="table table-bordered">
			<tbody><tr>
				<td width="20%">检测点</td>
				<td width="40%">检测结果</td>
				<td width="40%">解释</td>
			</tr>

			<tr>
				<td>国内网站</td>
				<td>
<iframe src="https://myip.ipip.net/" width="100%" height="70" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"> </iframe>
				</td>
				<td>如果没有全局代理或者VPN，左侧显示的IP就是您本机的IP。如果有，则显示的就是全局代理或者VPN的IP地址。</td>
			</tr>
			<tr>
				<td>国外网站 </td>
				<td>
<iframe src="https://api.myip.la/" width="100%" height="30" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"> </iframe>
				</td>
				<td>左侧IP就是您用来访问国外普通网站（没有被封的网站）的IP地址。</td>
			</tr>

			<tr>
				<td>谷歌网站</td>
				<td>
<iframe id="google_ico" name="google_ico" src="" width="100%" height="30" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"> </iframe>
</td>
				<td>左侧如果没有显示 Google 图标，则说明您现在还不能科学上网，不能访问谷歌，Facebook，Twitter，youtube 等国外网站。</td>
			</tr>

		</tbody></table>

      </div>

<form method="post" name="diskForm" action="">

</form>

</body>
</html>
