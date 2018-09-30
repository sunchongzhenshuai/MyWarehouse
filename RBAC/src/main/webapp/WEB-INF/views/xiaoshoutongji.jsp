<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   
	<form  style="margin: auto;" class="layui-form" action="">	
	<div class="layui-inline">
		<label class="layui-form-label">时间范围</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="test5"
				placeholder="yyyy-MM-dd HH:mm:ss">
		</div>
	</div>
	--  --
	<div class="layui-inline">
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="test6"
				placeholder="yyyy-MM-dd HH:mm:ss">
		</div>
	</div>
	<div class="layui-input-inline">
		<button class="layui-btn" onclick="return timeselect()" lay-submit lay-filter="formDemo">查询</button>
	</div>
</form>
	<div id="main" style="width: 1300px; height: 600px; margin: auto;"></div>
<script  type="text/javascript">
	
	xiaoliang();
	
	function xiaoliang(){
		
		//基于准备好的dom，初始化ECharts实例
		var myChart = echarts.init(document.getElementById('main'));
		
		var beginning = $("#test5").val();
		var end = $("#test6").val();
		
		$.ajax({
			url : "Sell/timeselect.action",
			type : "post",
			data : {"beginning": beginning, "end":end},
			dataType : "JSON",
			success : function (data){
				
				var cnames = new Array();
				var salesvs = new Array();
				var maps = new Array();
				 
				$.each(data, function(index, item){

						cnames.push(item.sid);
						salesvs.push(item.sellprice);
						var name = item.sid;
						var value = item.sellprice;
						var map = {value,name};
						maps.push(map);
					
				});
				if(maps != '' ){
					
					// 显示标题，图例和空的坐标轴
					var option = {
						    title : {
						        text: '销售额一览表',
						        subtext: '纯属虚构',
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
						            radius : '55%',
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
				} else{
					// 显示标题，图例和空的坐标轴
					var option = {
						    title : {
						        text: '此时间段没有订单',
						        subtext: '此时间段没有订单',
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
						            radius : '55%',
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
				}
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
			}
			
		});
		
		
	
		// 处理点击事件
		myChart.on('click', function (params) {
			var cname = params.name;
			//alert(cname);
			
		});
		
	}
	
	
	function timeselect(){
		  xiaoliang();
		 return false;
	}
	
	layui.use('laydate', function(){
		  var laydate = layui.laydate;
		  
	  //日期时间选择器
	  laydate.render({
	    elem: '#test5'
	    ,theme: '#393D49'
	    ,type: 'datetime'
	  });
	 
	  //日期时间选择器
	  laydate.render({
	    elem: '#test6'
	    ,theme: '#393D49'
	    ,type: 'datetime'
	  });
	  
	});
</script>
