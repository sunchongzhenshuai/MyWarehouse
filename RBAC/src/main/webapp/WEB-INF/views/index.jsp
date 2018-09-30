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
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>公司管理系统</title>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="css/yulantu.css">
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/echarts.js"></script>
	<script src="layui/layui.js"></script>
<script type="text/javascript">
	$(function() {

		$.ajax({
			url : "view/getmenu.action",
			tyep : "psot",
			dataType : "JSON",
			success : function(menus) {
				$.each(menus, function(index, menu) {

					if (menu.pmid == 0) {
						//构造一级菜单
						var p = $(".menu_parent").clone();
						//防止叠加生成
						p.removeClass("menu_parent");
						
						p.find(".menuname").text(menu.mname);
						p.find(".tubiao").addClass(menu.tubiao);

						//生成二级菜单
						$.each(menus, function(index, child) {

							if (child.pmid == menu.mid) {
								var c = $(".menu_child").clone();

								c.removeClass("menu_child");

								c.find(".menuname").text(child.mname);
								c.find(".tubiao").addClass(child.tubiao);
								
								c.find("a").attr("onclick","updateView('"+child.murl+"')");

								p.find(".layui-nav-child").append(c);
							}

						})

						$(".menu_context").append(p);
					}

				});

			}
		});

	});
	
	function updateView(viewurl){
		
		$.ajax({
			url : viewurl,
			type : "post",
			dataType : "HTML",
			success : function(h){
				$("#jsp_context").html(h);
			}
		});
		
		
	}
	
</script>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<a href="view/index.action" class="layui-logo">后台管理</a>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="view/index.action">首界面</a></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <img
						> ${sessionScope.staff.zname }
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">基本资料</a>
						</dd>
						<dd>
							<a href="">安全设置</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="Staff/logout.action">退出</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree menu_context" lay-filter="test">


				</ul>
			</div>
		</div>

		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="jsp_context" style=" padding: 15px; width: 100%; height: 100%;">

					
	<div id="main" style="width: 1600px; height: 800px; margin: auto;"></div>
<script  type="text/javascript">
	
	xiaoliang();
	
	function xiaoliang(){
		
		//基于准备好的dom，初始化ECharts实例
		var myChart = echarts.init(document.getElementById('main'));
	
		$.ajax({
			url : "Category/selectsales.action",
			type : "post",
			data : {},
			dataType : "JSON",
			success : function (data){
				
				var cnames = new Array();
				var salesvs = new Array();
				var maps = new Array();
				 
				$.each(data, function(index, item){
					
					if(item.cid == 0){
						
						cnames.push(item.cname);
						salesvs.push(item.salesv);
						var name = item.cname;
						var value = item.salesv;
						var map = {value,name};
						maps.push(map);
					}
					
				});
				
				// 显示标题，图例和空的坐标轴
				var option = {
					    title : {
					        text: '一级分类总销量概览',
					        subtext: '@涵宝宝',
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        orient: 'vertical',
					        left: 'left',
					        data: cnames
					    },
					    series : [
					        {
					            name: '访问来源',
					            type: 'pie',
					            radius : '66%',
					            center: ['50%', '50%'],
					            data:
					                maps
					            ,
					            itemStyle: {
					                emphasis: {
					                    shadowBlur: 10,
					                    shadowOffsetX: 0,
					                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					                }
					            }
					        }
					    ]
					};
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
			}
			
		});
		
		
	
		// 处理点击事件
		myChart.on('click', function (params) {
			var cname = params.name;
			//alert(cname);
			
			$.ajax({
				url : "Category/selectsales.action",
				type : "post",
				data : {},
				dataType : "JSON",
				success : function (data){
					
					var cnames = new Array();
					var salesvs = new Array();
					var maps = new Array();
					$.each(data, function(index, item){
						
						if(cname == item.cname){
							var cid = item.id;
							$.each(data, function(index, ite){
								
								if(cid == ite.cid){
									
									cnames.push(ite.cname);
									salesvs.push(ite.salesv);
									var name = ite.cname;
									var value = ite.salesv;
									var map = {value,name};
									maps.push(map);
								}
							});

						}
					});
					
					
					
					// 显示标题，图例和空的坐标轴
					var option = {
						    title : {
						        text: '二级分类总销量概览',
						        subtext: '@啊冲',
						        x:'center'
						    },
						    tooltip : {
						        trigger: 'item',
						        formatter: "{a} <br/>{b} : {c} ({d}%)"
						    },
						    legend: {
						        orient: 'vertical',
						        left: 'left',
						        data: cnames
						    },
						    series : [
						        {
						            name: '访问来源',
						            type: 'pie',
						            radius : '66%',
						            center: ['50%', '50%'],
						            data:
						                maps
						            ,
						            itemStyle: {
						                emphasis: {
						                    shadowBlur: 10,
						                    shadowOffsetX: 0,
						                    shadowColor: 'rgba(0, 0, 0, 0.5)'
						                }
						            }
						        }
						    ]
						};
			
						// 使用刚指定的配置项和数据显示图表。
						myChart.setOption(option); 
				}
			});
				// 处理点击事件并且跳转到相应的百度搜索页面
				myChart.on('click', function (params) {
					
					var cname = params.name;
					//alert(cname);
					
					$.ajax({
						url : "Category/selectsales.action",
						type : "post",
						data : {},
						dataType : "JSON",
						success : function (data){

							var limit = 0;
							var page = 0;
							var xclassid = 0;
							$.each(data, function(index, item){
								
								if(cname == item.cname){
									xclassid = item.id;

									$.ajax({
										url : "Product/selectprod.action?limit=0&page=0&xclassid="+xclassid+"",
										type : "post",
										data : {},
										dataType : "JSON",
										success : function(product){
											var cnames = new Array();
											var salesvs = new Array();
											var maps = new Array();
											$.each(product.data , function(index, item){
												
												cnames.push(item.prname);
												salesvs.push(item.xiaoliang);
												var name = item.prname;
												var value = item.xiaoliang;
												var map = {value,name};
												maps.push(map);
												
											});
											
											// 显示标题，图例和空的坐标轴
											var option = {
												    title : {
												        text: '产品总销量',
												        subtext: '@啊冲',
												        x:'center'
												    },
												    tooltip : {
												        trigger: 'item',
												        formatter: "{a} <br/>{b} : {c} ({d}%)"
												    },
												    legend: {
												        orient: 'vertical',
												        left: 'left',
												        data: cnames
												    },
												    series : [
												        {
												            name: '访问来源',
												            type: 'pie',
												            radius : '66%',
												            center: ['50%', '60%'],
												            data:
												                maps
												            ,
												            itemStyle: {
												                emphasis: {
												                    shadowBlur: 10,
												                    shadowOffsetX: 0,
												                    shadowColor: 'rgba(0, 0, 0, 0.5)'
												                }
												            }
												        }
												    ]
												};
												// 使用刚指定的配置项和数据显示图表。
												myChart.setOption(option); 
										}
									});
									// 处理点击事件并且跳转到相应的百度搜索页面
									myChart.on('click', function (params) {
										window.location = 'view/index.action';
										/* var viewurl = "view/index.action";
										updateView(viewurl); */
										
									});
								}
							});
							
						}
					});
				});
		});
		
	}
</script>

			</div>
		</div>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			© layui.com - 底部固定区域
		</div>
	</div>

	<!-- 一级菜单样式 -->
	<li class="layui-nav-item layui-nav-itemed menu_parent"><a
		class="" href="javascript:;"> <i class="layui-icon tubiao"
			style="font-size: 16px; color: white"></i> <span class="menuname"></span>
	</a>
		<dl class="layui-nav-child">

		</dl></li>

	<!-- 二级菜单样式 -->
	<dd class="menu_child">
		<a href="javascript:;" class="child_action"> <i
			class="layui-icon tubiao"
			style="font-size: 16px; color: white"></i> <span class="menuname"></span>
		</a>
	</dd>


	<script type="text/javascript">
		//JavaScript代码区域

	</script>

</body>
</html>