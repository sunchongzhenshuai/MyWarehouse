<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath %>">
<meta charset="UTF-8">
<link rel="shortcut icon" href="img/jd.png" />
<title>个人登录</title>
<link rel="stylesheet" href="css/zhuce.css" />
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script>
	function usernameFocus() {
		document.getElementById("zhanghaots").innerText = "账号由字母,数字,_组成,首字符必须是字母"
	}

	function usernameBlur() {
		document.getElementById("zhanghaots").innerText = "";
	}

	window.onload = function() {
		var password = document.getElementById("password");

		password.onfocus = function() {
			document.getElementById("pwdhint").innerText = "密码由字母，数字,_组成，必须包含字母";
		}

		password.onblur = function() {
			document.getElementById("pwdhint").innerText = "";
		}
	}
	function zhuce() {
		var username, paword, paword2, email;
		username = document.getElementById("zhanghao").value;
		paword = document.getElementById("password").value;
		paword2 = document.getElementById("password2").value;
		email = document.getElementById("email").value;
		var ch;

		ch = /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/;
		if (ch.test(username) == false) {
			document.getElementById("zhts").innerText = "账号必须是数字，字母_并且首字符必须是字母为开头";
			return false;
		}

		ch = /^[0-9a-zA-Z_+\-*]{6,16}$/;
		if (ch.test(paword) == false) {

			document.getElementById("zhanghaots").innerText = "密码必须是数字，字母，—+-*/";
			return false;
		}

		ch = /[a-zA-Z]/;
		if (ch.test(paword) == false) {
			document.getElementById("zhanghaots").innerText = "密码必须包含字母";
			return false;
		}

		

		return ture;
	}
	
	function refreshCode(){
		//修改图片属性
		$("#codeimg").removeAttr("src");
		$("#codeimg").attr("src","customer/getCode.action?t=" + new Date().getTime());
	}
</script>
</head>
<body>
	<%
		//取cookie
		Cookie[] cookies = request.getCookies();
	//先判断是否为空
	if (cookies != null){
		//遍历
		for (Cookie cookie: cookies){
			
			// 寻找名字叫username的cookie
			if ("username".equals(cookie.getName())){
				//取出这个cookie的值
				String value = cookie.getValue();
				//将值放到request中
				request.setAttribute("username", value);
			}
			if ("password".equals(cookie.getName())){
				String value = cookie.getValue();
				request.setAttribute("password", value);
			}
		}
	}
	%>
	
	<div class="top1">
		<div class="top">
			<a href="#"><img src="img/logo.png" /></a>
			<h2>欢迎登录</h2>
			<div>
				没有账号？ <a href="register.jsp">请注册</a>
			</div>

		</div>
		<div class="clear"></div>
	</div>
	<div class="zhongceng">
		<h1>用户登录</h1>
		<form action="user/login" method="post">
			<div id="zhts" class="tishi"></div>
			<div>
				<label>账号</label><input type="text" id="zhanghao"
					placeholder="请输入一个账号" onfocus="usernameFocus()"
					onblur="usernameBlur()" name="user.username" value="${username }"/>

			</div>
			<div id="zhanghaots" class="tishi"></div>
			<div>
				<label>密码</label><input type="password" name="user.password"
					id="password" value="${password }"/>
			</div>
			
			<div id="mimats" class="tishi"></div>
			
			<div>
				<label>验证码</label><input type="test" name="code" id="code" /><br/><br/>
				<img id="codeimg" src="customer/getCode.action"/>
				<a href="javascript:void(0)" onclick="refreshCode()" style="padding-bottom: 30px; display: inline-block; vertical-align: middle;">点击刷新</a>
				<input style="height: 20px; width: 20px;border: 1px solid #ddd;" type="checkbox" name="remember" value="true"/><span style="margin-bottom: 10px; display: inline-block; vertical-align: middle;">记住密码</span><br/>
			</div>
			<div class="error" >${error }</div>
			
			<div>
				<button class="zhuce" type="submit" onclick="return zhuce()">登录</button>
			</div>
		</form>
		<div class="zcfenlei">
			<i class="qiyeguoji"></i><a href="#">企业用户注册</a> <i class="qiyeguoji"></i><a
				href="#">国际站注册</a>
		</div>
	</div>
	<div class="diceng">
		<div>
			<a href="#">关于我们</a><span>|</span> <a href="#">联系我们</a><span>|</span>
			<a href="#">人才招聘</a><span>|</span> <a href="#">商家入驻</a><span>|</span>
			<a href="#">广告服务</a><span>|</span> <a href="#">手机京东</a><span>|</span>
			<a href="#">友情链接</a><span>|</span> <a href="#">销售联盟</a><span>|</span>
			<a href="#">京东社区</a><span>|</span> <a href="#">京东公益</a><span>|</span>
			<a href="#">京东公益</a><span>|</span>
		</div>
		<div>Copyright©2004-2018 京东JD.com 版权所有</div>
	</div>
</body>
</html>
