<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<link rel="shortcut icon" href="img/jd.png" />
<title>京东首页</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>

<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css" />

<link rel="stylesheet" href="css/jdshouye.css" />

<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script>
	var inval;
	var count = 0;
	$(function() {

		$(".tupianad img").hide();
		$("img[src='img/meinv.png']").show();
		inval = setInterval("nextImg()", 3000);

		$(".tupianad").mouseover(function() {
			clearInterval(inval);
		});
		$(".tupianad").mouseout(function() {
			inval = setInterval("nextImg()", 3000);
		});
		//计算购物车商品数量
		getCartCount();
		
	});

	var index = 1;

	function lastImg() {

		index--;
		if (index < 1) {
			index = 5;
		}
		showImgByIndex(index)
	}

	function nextImg() {

		index++;

		if (index > 4) {
			index = 1
		}

		showImgByIndex(index)
	}

	function showImgByIndex(i) {
		$(".tupianad img").fadeOut(1000);

		if (i == 1) {
			$("img[src='img/meinv.png']").fadeIn(1000);
		}
		if (i == 2) {
			$("img[src='img/lanyaerji.jpg']").fadeIn(1000);
		}

		if (i == 3) {
			$("img[src='img/longxia.jpg']").fadeIn(1000);
		}

		if (i == 4) {
			$("img[src='img/lvxing.jpg']").fadeIn(1000);
		}

		if (i == 5) {
			$("img[src='img/shoubiao.jpg']").fadeIn(1000);
		}
	}
	function jdq() {
		$(".jiayongdianqi").css("display", "block");
	}
	function jdq1() {
		$(".jiayongdianqi").css("display", "none");
	}

	var intDiff = parseInt(7200); //倒计时总秒数量
	function timer(intDiff) {
		window.setInterval(function() {
			var day = 0, hour = 0, minute = 0, second = 0; //时间默认值
			if (intDiff > 0) {
				hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
				minute = Math.floor(intDiff / 60) - (day * 24 * 60)
						- (hour * 60);
				second = Math.floor(intDiff) - (day * 24 * 60 * 60)
						- (hour * 60 * 60) - (minute * 60);
			}
			if (minute <= 9)
				minute = '0' + minute;
			if (second <= 9)
				second = '0' + second;
			$('#shi').html(hour);
			$('#fen').html(minute);
			$('#miao').html(second);
			intDiff--;
		}, 1000);
	}
	$(function() {
		timer(intDiff);
	});

	function zuoImg() {
		if (count == 0) {
			$(".pian1").animate({
				"left" : "800px"
			}, 0)
			$(".tu1").animate({
				"left" : "-800px"
			}, 1000);
			$(".pian1").animate({
				"left" : "0px"
			}, 1000);
			$(".tu1").animate({
				"left" : "800px"
			}, 0);
		}
		if (count == 1) {
			$(".tu1").animate({
				"left" : "800px"
			}, 0)
			$(".tu1").animate({
				"left" : "0px"
			}, 1000);
			$(".pian1").animate({
				"left" : "-800px"
			}, 1000);
			$(".pian1").animate({
				"left" : "800px"
			}, 0);
		}
		count++;
		if (count > 1)
			count = 0;
	}
	function youImg() {

		if (count == 0) {
			$(".pian1").animate({
				"left" : "800px"
			}, 0)

			$(".tu1").animate({
				"left" : "800px"
			}, 1000);
			$(".pian1").animate({
				"left" : "-800px"
			}, 0);
			$(".pian1").animate({
				"left" : "0px"
			}, 1000);
			$(".tu1").animate({
				"left" : "-800px"
			}, 0);
		}
		if (count == 1) {
			$(".tu1").animate({
				"left" : "-800px"
			}, 0)

			$(".tu1").animate({
				"left" : "0px"
			}, 1000);
			$(".pian1").animate({
				"left" : "800px"
			}, 1000);
			$(".pian1").animate({
				"left" : "-800"
			}, 0);
		}
		count++;
		if (count > 1)
			count = 0;
	}
	
	function getCartCount(){
		//先取Cookie
		var ckiCart = $.cookie("cart");
		
		var cart;
		//判断cookie中是否有数据
		if(ckiCart == undefined){
			//当没有购物车信息时,设置显示数量为0
			$("#cartNum").text(0);
		} else{
			//当已有购物信息时,获取已有的信息,生成数组
			cart = JSON.parse(ckiCart);
			
			//计算数量
			var sum = 0;
			for(var i=0; i<cart.length; i++){
				sum += parseInt(cart[i].count);
			}
			
			$("#cartNum").text(sum);
		}
	}
	
</script>
</head>
<body>
	<div class="navbg">
		<div class="nav">
			<div class="navleft">
				<a href="#" id="#red"><i class="glyphicon glyphicon-map-marker"
					style="color: #f10215; padding-right: 5px; font-size: 14px;"></i>北京</a>
				<div class="dizhi">
					<button class="beijing">北京</button>
					<button>上海</button>
					<button>天津</button>
				</div>
			</div>
			<div class="navright">
				<c:if test="${sessionScope.customer  != null }">
					<a href="customer/cmdetails.action" style="padding: 0px;" class="zc">你好，${sessionScope.customer.username }</a>
					<a href="customer/logout.action">退出</a><span>︳</span>
				</c:if>
				<c:if test="${sessionScope.customer == null }">
					<a href="login.jsp" style="padding: 0px;">你好，请登录</a>
					<a href="register.jsp" class="zc">免费注册</a><span>︳</span>
				</c:if>
				<a href="customer/myOrder.action">我的订单</a><span>︳</span>
				<div class="wdjd">
					<a href="#" class="wdjd3">我的京东&nbsp;﹀</a>
					<div class="wdjd2">
						<a href="#">待处理订单</a> <a href="#">消息</a>
					</div>
				</div>
				<span>︳</span> <a href="#">京东会员</a><span>︳</span> <a href="#">企业采购&nbsp;﹀</a><span>︳</span>
				<a href="#">客户服务&nbsp;﹀</a><span>︳</span>
				<div class="wzdaohang0">
					<div class="wzdaohang">
						<div class="wzdaohang2" style="width: 360px;">
							<h6>特色主题</h6>
						</div>
						<div class="wzdaohang3" style="width: 270px;">
							<h6>行业频道</h6>
						</div>
						<div class="wzdaohang4" style="width: 270px;">
							<h6>生活服务</h6>
						</div>
						<div class="wzdaohang5" style="width: 270px;">
							<h6>更多精选</h6>
						</div>
					</div>
					<a href="#" class="wzdaoh">网站导航&nbsp;﹀</a><span>︳</span>
				</div>
				<div class="shoujijd">
					<a>手机京东</a><a class="glyphicon glyphicon-eject sjjd"></a> <i
						class="erweima"><img src="img/mobile_qrcode.png" /></i>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="dierceng">
		<div class="dierceng1">
			<a href="#" class="logo"></a>

			<div class="sousuo">
				<form action="search.action" target="_blank">
					<input name="cmdname" type="text" placeholder="手机" />
					<button class="glyphicon glyphicon-camera"></button>
					<button type="submit" class="glyphicon glyphicon-search ssanniu"></button>
				</form>
				<div class="sousuogg">
					<a href="#" style="color: #f10215;">最高减1200</a> <a href="#">三只松鼠</a>
					<a href="#">直降100</a> <a href="#">Find X</a> <a href="#">精选家电</a> <a
						href="#">家具钜惠</a> <a href="#">厨卫8折</a> <a href="#">每100-40</a> <a
						href="#">满减盛惠</a>
				</div>
			</div>
			<div class="gouwuche">
				<a class="glyphicon glyphicon-shopping-cart"></a> <a target="_blank" href="cart.jsp">我的购物车</a>
				<sup id="cartNum">0</sup>
			</div>
			<div class="guanggaofl">
				<a href="#">秒杀</a> <a href="#">优惠券</a> <a href="#">PLUS会员</a> <a
					href="#">闪购</a><span>︳</span> <a href="#">拍卖</a> <a href="#">京东服饰</a>
				<a href="#">京东超市</a> <a href="#">生鲜</a><span>︳</span> <a href="#">全球购</a>
				<a href="#">京东金融</a>
			</div>
		</div>
	</div>
	<div class="disanceng">
		<div class="disanceng1">
			<div class="caidanlan">
				<ul>
					<li onmouseover="jdq()" onmouseout="jdq1()"><a href="#">家用电器</a>
						<div></div></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
					<li><a href="#">手机</a><span>/</span> <a href="#">运营商</a><span>/</span>
						<a href="#">数码</a></li>
				</ul>
				<div class="jiayongdianqi" onmouseover="jdq()" onmouseout="jdq1()">
					<div>
						<div>
							<a href="#">家电馆</a> <a href="#">乡镇专卖店</a> <a href="#">家电服务</a> <a
								href="#">家电企业购</a>
						</div>
					</div>
				</div>
			</div>
			<div class="tupianad">
				<a href="#"><img src="img/meinv.png" /></a> <a href="#"><img
					src="img/lanyaerji.jpg" /></a> <a href="#"><img
					src="img/longxia.jpg" /></a> <a href="#"><img src="img/lvxing.jpg" /></a>
				<a href="#"><img src="img/shoubiao.jpg" /></a>
				<button onclick="lastImg()"
					class="anniuleft glyphicon glyphicon-chevron-left"></button>
				<button onclick="nextImg()"
					class="anniuright glyphicon glyphicon-chevron-right"></button>
				<div class="dian">
					<i onmouseover="showImgByIndex(1)"></i> <i
						onmouseover="showImgByIndex(2)"></i> <i
						onmouseover="showImgByIndex(3)"></i> <i
						onmouseover="showImgByIndex(4)"></i> <i
						onmouseover="showImgByIndex(5)"></i>
				</div>
			</div>
			<div class="ggtu">
				<a href="#"><img src="img/gg.jpg" /></a> <a href="#"><img
					src="img/ggg.jpg" /></a> <a href="#"><img src="img/gggg.jpg" /></a>
			</div>
			<div class="dengluzhuce">
				<div class="dlzc1">
					<div class="dlzcimg">
						<img src="img/no_login.jpg" class="img-circle" />
					</div>
					<div class="dlzcdlzc">
						<h6>Hi~欢迎来到京东！</h6>
						<a href="#">登陆</a> <a href="#">注册</a>
					</div>
					<div></div>
				</div>
				<div></div>
				<div></div>
				<div></div>
			</div>
		</div>
	</div>

	<div class="clear"></div>
	<div class="siceng">
		<div class="siceng2">
			<div class="miaosha">
				<a href="#">
					<div class="jdms">京东秒杀</div>
					<div class="flash">FLASH DEALS</div>
					<div class="glyphicon glyphicon-flash shandian"></div>
					<div class="jieshutishi">本场距离结束还剩</div>
					<div class="msshijian">
						<span id="shi"></span> <span id="fen"></span> <span id="miao"></span>
					</div>
				</a>
			</div>
			<div class="miaoshagunbo">
				<div class="miaoshabokuang">
					<div class="tu1">
						<a href="#"><img src="img/gunbo.jpg" /></a>
					</div>
					<div class="pian1">
						<a href="#"><img src="img/gunboo.jpg" /></a>
					</div>
				</div>
				<button onclick="zuoImg()"
					class="anniuleft glyphicon glyphicon-chevron-left zuoanniu"></button>
				<button onclick="youImg()"
					class="anniuleft glyphicon glyphicon-chevron-right youanniu"></button>
			</div>
			<div class="pinleimiaosha">
				<div class="pinleimiaosha2">
					<div class="plmst">
						<a href="#"><img src="img/5b34b0a4Nfcb37780.jpg" /></a>
					</div>
					<div class="plmst2">
						<a href="#"><img src="img/5b35c7daNf4c4cc9f.jpg" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
