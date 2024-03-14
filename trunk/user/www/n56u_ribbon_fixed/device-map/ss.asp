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
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/wireless.js"></script>
<script type="text/javascript" src="/wireless_2g.js"></script>
<script type="text/javascript" src="/help_wl.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="formcontrol.js"></script>
<script type="text/javascript" src="/client_function.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/link_d.js"></script>
<script type="text/javascript" src="/link/ping_ss.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
	init_itoggle('ss_enable');
});

</script>
<script>

<% login_state_hook(); %>

function initial(){

	set_wan();
	get_LinkList();
	showLinkList();
	//document.form.ssr_type_protocol.value = "";
	//document.form.ssr_type_obfs.value = "";
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.app_24.sh'], v);
}

function getHashId(){
	var curHash = window.location.hash;
	if (curHash == '')
		curHash = '#0';
	var id = parseInt(curHash.replace('#', '0'));
	if (isNaN(id))
		return 0;
	return id;
}

function set_wan(){
	var wan_proto_id = getHashId();
	if(wan_proto_id == "1"){
	document.form.current_page.value = "/Advanced_Extensions_SS_list.asp";
	document.form.next_page.value = "";
	} else{
	document.form.current_page.value = "/";
	document.form.next_page.value = "device-map/ss.asp";
	
	}
}
function applyRule(){
	document.form.action_mode.value = " Apply ";
	parent.showLoading();

	document.form.submit();
}

function change_ss_mode_bridge(){
	var m = document.form.ss_mode_x.value;
	var is_local_port = (m == "3") ? 1 : 0;
	if(is_local_port == "1"){
		document.form.ss_run_ss_local.selectedIndex = 0;
	}
}

function openToolss(obj, ss_server)
{
	$j(obj).attr('data-original-title', obj.innerHTML).attr('data-content', ss_server);
	$j(obj).popover('show');
}

function delval(id){
	var obj = $j('#'+id);
	var obj_icon = $j('#'+id+'_icon');
	var changeTo = (obj.attr('value') == '') ? '0' : '1';
	if (changeTo == 1){
		obj.attr('refresh' , obj.attr('value'));
		obj.attr('value' , '');
		obj_icon.attr('class' , 'icon-share-alt');
	}else{
		obj.attr('value' , obj.attr('refresh'));
		obj_icon.attr('class' , 'icon-trash');
	}
}

function up_ssr_link(mflag){
	var ssr_link = document.form.ssr_link.value;
	if(ssr_link == ""){
		alert("填入订阅下载地址后，请按【应用保存设置】");
		return false;
	}
	var str = "你确定要执行 【更新订阅】 按钮功能吗？";
	if(confirm(str)){
		document.form.app_77.value = 'up_link';
		parent.showLoading();
		document.form.action_mode.value = " Apply ";
		document.form.submit();
	}
}

function del_ssr_link(){
	var str = "你确定要执行 【清空订阅】 按钮功能吗？";
	if(confirm(str)){
		parent.showLoading();
		var $j = jQuery.noConflict();
		$j.ajax({
			type: "post",
			url: "/apply.cgi",
			data: {
				'action_script': "script/_ss del_link "
			},
			dataType: "json",
			error: function() {
				setTimeout("document.form.submit();",2000);
			},
			success: function() {
				setTimeout("document.form.submit();",2000);
			}
		});
	}
}

//停止定时更新订阅
function click_ss_link_up(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_link_up.value = v;
}
//停止ping订阅节点
function click_ss_link_ping(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_link_ping.value = v;
	if(v == "1"){
		document.form.app_99.value = "0";
		document.form.app_99_fake.checked = false;
	}
}
//更新后自动选用节点
function click_app_99(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_99.value = v;
	if(v == "1"){
		document.form.ss_link_ping.value = "0";
		document.form.ss_link_ping_fake.checked = false;
	}
}
//默认排序节点
function click_app_100(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_100.value = v;
}

function done_validating(action){
	refreshpage();
}
function button_start(){
	var str = "你确定要执行 重启SS 按钮功能吗？";
	if(confirm(str)){
	
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_script': 'script/_ss start',
	});
	}
}
function button_swap(){
	var str = "你确定要执行 自动选用节点 按钮功能吗？";
	if(confirm(str)){
	
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_script': 'script/_ss link_ss_matching',
	});
	
	
	document.form.submit();
	}
}
function button_ping(){
	var str = "你确定要执行 ping 按钮功能吗？";
	if(confirm(str)){
	
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_script': 'script/_ss ping_link',
	});
	}
}
function domore_link_txt(obj){
	obj.value = "../Advanced_Extensions_SS.asp";
	domore_link(obj);
	document.form.submit();
}


function htmlEscape(str) {
	return String(str)
			.replace(/&/g, '&amp;')
			.replace(/"/g, '&quot;')
			.replace(/'/g, '&#39;')
			.replace(/</g, '&lt;')
			.replace(/>/g, '&gt;');
}

function get_LinkList(){
	var tmp_LinkList_tmp = new Array();
	ping_data_all = "";
	if (typeof(ping_data) != "undefined"){
		ping_data_all = ping_data_all + ping_data;
	}
	if (typeof(document.getElementById("app_24_txt").childNodes["0"]) != "undefined"){
	var link_txt = document.getElementById("app_24_txt").childNodes["0"].data;
	link_txt.trim().split('\n').forEach(function(v, i) {
		link_d(v);
		if (link_protocol_d == "ss" || link_protocol_d == "ssr"){
		var LinkList_tmp = [ i ];
		LinkList_tmp.push(htmlEscape(link_protocol_d));
		LinkList_tmp.push(link_wget + htmlEscape(link_name_d));
		LinkList_tmp.push(htmlEscape(link_remote_host_d));
		LinkList_tmp.push(htmlEscape(link_input));
		var ping_type = get_ping(link_remote_host_d);
		var btn_type = get_btn_type(ping_type);
		LinkList_tmp.push(htmlEscape(btn_type));
		LinkList_tmp.push(htmlEscape(ping_type) + " ms");
		if(document.form.app_76.value.indexOf(link_input) != -1){
			link_selected = '🚀';
		}else{link_selected = '';}
		LinkList_tmp.push(link_selected);
		LinkList_tmp.push(Base64.encode(link_input));
		tmp_LinkList_tmp.push(LinkList_tmp);
		}
	})
	}
	if(document.form.app_100.value != 1){
		tmp_LinkList_tmp.sort(function(a, b){
			if(a[2].indexOf('过期时间') != -1)
				return -1;
			if(a[2].indexOf('剩余流量') != -1)
				return -1;
			if(b[2].indexOf('过期时间') != -1)
				return 1;
			if(b[2].indexOf('剩余流量') != -1)
				return 1;
			return a[6].replace(' ms', '').replace('>', '') - b[6].replace(' ms', '').replace('>', '');
		});
	}
	if (typeof(LinkList) == "undefined"){
		LinkList = [];
	}
	LinkList = [];
	LinkList = LinkList.concat(tmp_LinkList_tmp);
}

function showLinkList(){
	var code = '';
	var code2 = '';
	var Norule_i = 1;
	if (typeof(LinkList) != "undefined"){
		if(LinkList.length > 0) {
			var Norule_i = 0;
		}
	}
	if(Norule_i == 1){
		code +='<tr><td colspan="9" style="text-align: center;"><div class="alert alert-info"><#IPConnection_VSList_Norule#></div></td></tr>';
	}
	if (typeof(LinkList) != "undefined"){
	if(LinkList.length > 0) {
		for(var i = 0; i < LinkList.length; i++){
		code +='<tr id="row3' + i + '">';
		code +='<td><a class="help_tooltip" href="javascript: void(0)" onmouseover="openToolss(this, ' + "'" + '协议: ' + LinkList[i][1]  + '<br/>节点信息: ' + LinkList[i][2]  + '<br/>节点地址: ' + LinkList[i][3] + "'" + ');">' + LinkList[i][2] + '</td>';
		code +='<td width="10%">&nbsp;<input type="text" class="span12" size="32" disabled value="' + LinkList[i][1] + '" ></td>';
		code +='<td width="20%"><button class="btn-mini ' + LinkList[i][5] + '" type="submit" >' + LinkList[i][6] + '</button><input type="text" class="span12" size="32" disabled value="' + LinkList[i][3] + '" ></td>';
		code +='<td width="15%">&nbsp;<input type="text" class="span12" size="32" disabled value="' + LinkList[i][4] + '" ></td>';
		code += '<td width="10%"><button class="btn btn-success" type="submit" name="rt_LinkList_' + i + '" id="rt_LinkList_' + i + '" onclick="return markGroupLink(this, ' + i + ');" >' + LinkList[i][7] + '应用</button></td>';
		code +='</tr>';
		}
	}
	if(LinkList.length > 0) {
		code2 += '<tr><th style="border-top: 0 none;">✨快捷选用节点✨：</th><td style="border-top: 0 none;">'
		code2 += '<select style="width: 370px;" name="app_97_select" id="app_97_select" class="input" onChange="return markGroupLink2(this, document.form.app_97_select.value);">'
		code2 += '<option value="-1" >选用服务器后点击[应用]生效</option>'
		for(var i = 0; i < LinkList.length; i++){
			if (typeof(LinkList[i][2]) != "undefined"){
			code2 += '<option value="' + i + '" >' + padding2(padding(LinkList[i][6],7),7) + padding2(padding('[' + LinkList[i][1] + ']',5),5) + LinkList[i][2] + '</option>'
			}
		}
	}
	}
	var code0 = '<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list" id="LinkList_Block2">'
	$j('#LinkList_Block2').replaceWith(code0 + code + '</table>');
	var code1 = '<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table" id="LinkList_select" style="margin-bottom: 0px;">'
	$j('#LinkList_select').replaceWith(code1 + code2 + '</table>');
}

function markGroupLink(o, c) {
	var rusult=c;
	if(document.form.markGroupLink_re.value == 0){
	var str = "你确定要应用 【" + LinkList[rusult][2] + "】 节点吗？";
	if(confirm(str)){
		document.form.app_75.value = Base64.decode(LinkList[rusult][8]);
		parent.showLoading();
		document.form.action_mode.value = " Apply ";
		document.form.submit();
	}
	}
	if(document.form.markGroupLink_re.value == 1){
		del_LinkList(c, LinkList[rusult][0]);
	}
	return false;
}

function markGroupLink2(o, c) {
	var rusult=c;
	if(rusult >= 0){
		document.form.app_75.value = Base64.decode(LinkList[rusult][8]);
	}else{
		document.form.app_75.value = ''
	}
	return true;
}
function change_markGroupLink_re(){
	if(document.form.markGroupLink_re.value == 1){
	var str = "你确定要【删除】节点吗？点击【应用】删除节点，F5刷新显示";
	if(confirm(str)){
		document.form.markGroupLink_re.selectedIndex = 1;
		document.form.markGroupLink_re.value = 1;
	}else{
		document.form.markGroupLink_re.selectedIndex = 0;
		document.form.markGroupLink_re.value = 0;
	}
	}
}
function get_ping(domain) {
	var ping_type = "";
	if (typeof(ping_data_all) != "undefined"){
		domain = domain.replace("[", '\\[');
		domain = domain.replace("]", '\\]');
		var matchArr = ping_data_all.match('🔗' + domain + '=[^🔗]+');
		if (!matchArr) {
			ping_type = "";
			return ping_type;
		}
		if (matchArr) {
			var matchArr2 = matchArr[0].split('=');
			if (typeof(matchArr2) != "undefined") {
				if (matchArr2.length > 1)
					ping_type = matchArr2[1];
				if (ping_type >= 1000) {
					ping_type = ">1000";
					return ping_type;
				}
			} 
		} else {
			ping_type = "";
			return ping_type;
		}
	}
	return ping_type;
}

function get_btn_type(ping_type) {
	var btn_type = "";
	if (ping_type >=0)
		btn_type = "btn-success";
	if (ping_type >= 250)
		btn_type = "btn-warning";
	if (ping_type >= 500)
		btn_type = "btn-danger";
	if (ping_type == ">1000")
		btn_type = "btn-danger";
	if (ping_type == "")
		btn_type = "";
	return btn_type;
}

function add_LinkList(i){
	if(i == 2){
		document.form.app_75.value = document.form.app_76.value;
	}
	if(document.form.app_75.value == ""){
		alert("手动粘贴单节点链接后，请按【应用保存设置】");
		return false;
	}else{
		document.form.action_mode.value = " Apply ";
		parent.showLoading();

		document.form.submit();
	}
	return;
}

function del_LinkList(c, i){
	if(i.length != 0){
	var $j = jQuery.noConflict();
	var $btn = $j('#rt_LinkList_' + c);
	$j.ajax({
		type: "post",
		url: "/apply.cgi",
		data: {
			'action_script': "script/_ss del_LinkList " + i
		},
		dataType: "json",
		error: function() {
		},
		success: function() {
		}
	});
	//setTimeout("document.form.submit();", 1500);
	$btn.removeClass('btn-success');
	$btn.addClass('btn-danger');
	$btn.removeAttr("onclick");
	$btn.text("已删");
	}
	return;
}
function padding(num, length) {
	return (Array(length).join("") + num).slice(-length);
}
function padding2(num, length) {
	var len = (num + "").length -1;
	var diff = length - len;
	if(diff > 0) {
		return num + Array(diff).join("&ensp;");
	}
	return num;
}
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

<body class="body_iframe" onload="initial();">

	
	
<iframe name="hidden_frame" style="position: absolute;" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

<form method="post" name="form" id="form" action="/start_apply.htm">
	<input type="hidden" name="current_page" value="">
<input type="hidden" name="next_page" value="/device-map/ss.asp">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="LANHostConfig;General;APP;">
	<input type="hidden" name="group_id" value="rt_ACLList">
<input type="hidden" name="action_mode" value="">
<input type="hidden" name="action_script" value="">

	<input type="hidden" name="ss_link_up" value="<% nvram_get_x("", "ss_link_up"); %>" />
	<input type="hidden" name="ss_link_ping" value="<% nvram_get_x("", "ss_link_ping"); %>" />
	<input type="hidden" name="app_99" value="<% nvram_get_x("", "app_99"); %>" />
	<input type="hidden" name="app_100" value="<% nvram_get_x("", "app_100"); %>" />
	<input type="hidden" name="app_77" value="<% nvram_get_x("", "app_77"); %>" />

<ul class="nav nav-tabs">
	<li class="active"><a href="javascript:;">设置参数</a></li>
	<li><a href="ssinfo.asp">查询Shadowsocks</a></li>
</ul>


				<!--Body content-->
				
						
							
							
								<div class="row-fluid">

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table" style="margin-bottom: 0px;">

										<tr>
											<th width="30%" style="border-top: 0 none;"><#SSConfig_enable#></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_enable_on_of">
														<input type="checkbox" id="ss_enable_fake" <% nvram_match_x("", "ss_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_enable" id="ss_enable_1" class="input" value="1" <% nvram_match_x("", "ss_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_enable" id="ss_enable_0" class="input" value="0" <% nvram_match_x("", "ss_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td id="col_gotoss" width="40%" style="margin-top: 10px; border-top: 0 none;">
											&nbsp;<input class="btn btn-success" style="width:60px" type="button" value="重启" onclick="button_start()" />
												<input class="btn btn-info" type="button" name="gotoss" value="转到详细设置" onclick="domore_link_txt(this);">
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table" style="margin-bottom: 0px;">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;" >Shadowsocks 链接生成 Shadowsocks 配置</th>
										</tr>
										<tr>
											<th style="border-top: 0 none;">代理方案选择</a></th>
											<td colspan="3" style="border-top: 0 none;" onclick="change_ss_mode_bridge();">
												<select name="ss_mode_x" class="input" style="width: 365px;">
													<option value="0" <% nvram_match_x("","ss_mode_x", "0","selected"); %>>方案一chnroutes，国外IP走代理</option>
													<option value="1" <% nvram_match_x("","ss_mode_x", "1","selected"); %>>方案二gfwlist（推荐），只有被墙的站点IP走代理</option>
													<option value="2" <% nvram_match_x("","ss_mode_x", "2","selected"); %>>方案三，全部IP走代理</option>
													<option value="3" <% nvram_match_x("","ss_mode_x", "3","selected"); %>>方案四，只启用ss-local 建立本地 SOCKS 代理</option>
												</select>
										</tr>
										<tr>
											<th style="border: 0 none;">启用 ss-local？</a></th>
											<td  colspan="3" style="border: 0 none;">
												<select name="ss_run_ss_local" class="input" style="width: 365px;">
													<option value="0" <% nvram_match_x("","ss_run_ss_local", "0","selected"); %>>不启用 ss-local</option>
													<option value="1" <% nvram_match_x("","ss_run_ss_local", "1","selected"); %>>同时启用 ss-local 本地代理</option>
												</select>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">手动粘贴单节点链接:<div>(<a href="https://shadowsocks.org/en/config/quick-guide.html" target="blank_ss">ss://</a>、ssr://)</div></th>
											<td colspan="3" style="border: 0 none;">
												<input type="text" style="width: 220px;" maxlength="5120" class="input" size="15" id="app_75" name="app_75" placeholder="ss://base64" value="<% nvram_get_x("","app_75"); %>" refresh="" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="document.getElementById('app_97_select').options[0].selected=true;delval('app_75')"><i class="icon-trash" name="ss_link_icon" id="ss_link_icon"></i></button>
												<input class="btn btn-info" type="button" value="生成配置" onclick="add_LinkList(1);">
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table" id="LinkList_select" style="margin-bottom: 0px;">
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th>当前使用服务器节点:</th>
											<th><input style="width: 365px; background-color: #ffd;" readonly="readonly" type="text" class="input" size="15" id="app_97" name="app_97" value="<% nvram_get_x("","app_97"); %>" onKeyPress="return is_string(this,event);" /></th>
										</tr>
										<tr>
											<th style="border: 0 none;">当前使用节点的链接:</th>
											<th style="border: 0 none;"><input style="width: 220px; background-color: #ffd;" readonly="readonly" type="text" class="input" size="15" id="app_76" name="app_76" value="<% nvram_get_x("","app_76"); %>" onKeyPress="return is_string(this,event);" />
											<input class="btn btn-info" type="button" value="重新生成配置" onclick="add_LinkList(2);"></th>
										</tr>
									</table>
									<table class="table" style="margin-bottom: 0px;">
										<tr>
											<td width="50%" style="margin-top: 10px; border-top: 0 none;">
											   <input class="btn btn-success" type="button" value="ping" onclick="button_ping();">
											&nbsp;<input class="btn btn-primary" type="button" value="自动选用节点" onclick="button_swap();">
											</td>
											<td style="border-top: 0 none;">
												<input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" />
											</td>
										</tr>
									</table>
									<table width="100%" cellpadding="4" cellspacing="0" class="table table-list" style="margin-bottom: 0px;">
										<tr>
											<th colspan="9" style="background-color: #E3E3E3;">Shadowsocks节点选择</th>
										</tr>
										<tr>
											<th style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">匹配关键词节点故障转移:</th>
											<td cellpadding="3" style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">
											<input type="text" maxlength="512" class="input" size="15" id="app_95" name="app_95" placeholder="留空停用,填[|]分割关键词,填[.]全选" value="<% nvram_get_x("","app_95"); %>" onKeyPress="return is_string(this,event);" />&nbsp;<span style="color:#888;">对节点名称有效，支持<a href="https://www.runoob.com/regexp/regexp-syntax.html" target="blank_regexp">正则表达式</a></span>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">排除关键词节点故障转移:</th>
											<td cellpadding="3" style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">
											<input type="text" maxlength="512" class="input" size="15" id="app_96" name="app_96" placeholder="留空则只使用上行的匹配关键词" value="<% nvram_get_x("","app_96"); %>" onKeyPress="return is_string(this,event);" />&nbsp;<span style="color:#888;">优选低延迟，支持<a href="https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Regular_Expressions" target="blank_Regular">正则表达式</a></span>
											</td>
										</tr>
									</table>
									<table width="100%" cellpadding="4" cellspacing="0" class="table table-list" style="margin-bottom: 0px;">
										<tr>
											<th>服务器订阅节点:</th>
											<td cellpadding="3">
												<input type="text" style="width: 180px;" maxlength="5120" class="input" size="15" id="ssr_link" name="ssr_link" placeholder="(ss、ssr): https://www.123.com/ss_link.txt" value="<% nvram_get_x("","ssr_link"); %>" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="delval('ssr_link')"><i class="icon-trash" name="ssr_link_icon" id="ssr_link_icon"></i></button>
												<input class="btn btn-info" type="button" name="ssr_ss" id="ssr_ss" value="更新" onclick="up_ssr_link();">
												<input class="btn btn-danger" type="button" name="ssr_ss" id="ssr_ss" value="清空订阅" onclick="del_ssr_link();">
												
												
											</td>
										</tr>
										<tr>
											<td colspan="4">订阅链接更新配置 : 
												<label id="ss_link_up_tr" class="checkbox inline"><input type="checkbox" name="ss_link_up_fake" value="" style="margin-left:10;" onclick="click_ss_link_up(this);" <% nvram_match_x("", "ss_link_up", "1", "checked"); %>/>停止每6小时更新订阅</label>
												<label id="app_100_tr" class="checkbox inline"><input type="checkbox" name="app_100_fake" value="" style="margin-left:10;" onclick="click_app_100(this);get_LinkList();showLinkList();" <% nvram_match_x("", "app_100", "1", "checked"); %>/>停止更新订阅后优选排序显示节点</label>
												<div><label id="ss_link_ping_tr" class="checkbox inline"><input type="checkbox" name="ss_link_ping_fake" value="" style="margin-left:10;" onclick="click_ss_link_ping(this);" <% nvram_match_x("", "ss_link_ping", "1", "checked"); %>/>停止更新订阅后 ping 节点</label>
												<label id="app_99_tr" class="checkbox inline"><input type="checkbox" name="app_99_fake" value="" style="margin-left:10;" onclick="click_app_99(this);" <% nvram_match_x("", "app_99", "1", "checked"); %>/>更新订阅后自动切换节点（优选 + 匹配关键词）
</label></div>
										</tr>
									</table>
									<table style="margin-bottom: 0px;" width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<td colspan="3">
												<i class="icon-hand-right"></i><input class="btn btn-primary" style="" type="button" name="button_app_24_script_code"  value="点击按钮显示 批量导入链接节点 (ss://、ssr://)" onclick="spoiler_toggle('app_24')" tabindex="24">
												<div id="app_24" style="display:none;">
													<textarea id="app_24_txt" rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.app_24.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_24.sh",""); %></textarea>
												</div>
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list" id="link_Block" style="margin-bottom: 0px;">
										<tr>
											<th>SS 节点名称 [👉说明:<a href="https://shadowsocks.org/en/config/quick-guide.html" target="blank_ss"> ss </a>、<a href="https://github.com/shadowsocksr-rm/shadowsocks-rss/blob/master/ssr.md" target="blank_ssr"> ssr </a>]</th>
											<th width="10%">协议</th>
											<th width="20%">服务器地址</th>
											<th width="25%" colspan="2">链接
												<select name="markGroupLink_re" id="markGroupLink_re" class="input" style="width: 100px;" onchange="change_markGroupLink_re();">
													<option value="0">生成配置</option>
													<option value="1">删除节点</option>
												</select>
											</th>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list" id="LinkList_Block2" style="margin-bottom: 0px;">
									</table>
									<table class="table" style="margin-bottom: 0px;">
										<tr>
											<td width="50%" style="margin-top: 10px; border-top: 0 none;">
											   <input class="btn btn-success" type="button" value="ping" onclick="button_ping();">
											&nbsp;<input class="btn btn-primary" type="button" value="自动选用节点" onclick="button_swap();">
											</td>
											<td style="border-top: 0 none;">
												<input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" />
											</td>
										</tr>
									</table>

<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list">

</table>
								</div>
</form>

</body>
</html>
