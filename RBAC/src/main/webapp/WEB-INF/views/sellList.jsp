<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   

 <form class="layui-form" lay-filter="example">
	  <div class="layui-form-item">

		 <div class="layui-inline">
		  	<select name="pid"  lay-filter="dclassid" id="product" lay-search>
			</select>
		</div>	 
		<div class="layui-inline">	    
			<select name="sfid" id="staff" lay-search>
			</select> 
		</div>   
	  <div class="layui-inline">
			<button class="layui-btn" lay-submit lay-filter="*">查询</button>
	</div>
	</div>
</form>
<table class="layui-hide" id="test" lay-filter="demo"></table>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">


layui.use('form', function(){
	var form = layui.form;
	$.ajax({
		url : "Product/selectprod.action?limit=0&page=0",
		type : "post",
		data : {},
		dataType : "JSON",
		success : function(product){
			var html = "<option value='0'>搜索选择商品</option>";
			$.each(product.data , function(index, item){
				
				html += "<option value='"+item.id+"'>"+item.prname+"</option>";
				
			});
			$("#product").html(html);
			form.render('select');
		}
	});
	
	var staffid = ${sessionScope.staff.id };
	if(staffid != 3){
		$.ajax({
			url : "Staff/selectStaff.action?limit=0&page=0",
			type : "post",
			data : {},
			dataType : "JSON",
			success : function(staff){
				var html = "<option value='0'>搜索选择员工</option>";
				$.each(staff.data , function(index, item){
					
					if(item.id != 1){
						html += "<option value='"+item.id+"'>"+item.zname+"</option>";
					}
					
				});
				$("#staff").html(html);
				form.render('select');
			}
		});
	}else{
		var html = "<option value='0'>无权限使用</option>";
		$("#staff").html(html);
		form.render('select');
	}

		 form.render('select');
});
 
 
layui.use(['laydate', 'laypage', 'layer', 'table',  'element','form'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  ,layer = layui.layer //弹层
  ,table = layui.table //表格
  ,element = layui.element //元素操作
  ,form = layui.form;
  
  //向世界问个好
  //layer.msg('Hello World');
  
  //监听Tab切换
  element.on('tab(demo)', function(data){
    layer.msg('切换了：'+ this.innerHTML);
    console.log(data);
  });
  
  form.on('submit(*)', function(data){
	  console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
	  console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
	  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
	  //执行一个 table 实例
	  table.render({
	    elem: '#test'
	    //,height: 332
	    ,url: 'Sell/selectsell.action' //数据接口
	    ,where :data.field
	    ,page: true //开启分页
	    ,cols: [[ //表头
	      {field: 'sid', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'prname', title: '产品名称', width:280}
	      ,{field: 'zname', title: '出售员工', width:150}
	      ,{field: 'username', title: '购买用户', width:120} 
	      ,{field: 'sellprice', title: '订单总价格', width: 160}
	      ,{field: 'sellcount', title: '购买数量', width: 100, sort: true}
	      ,{field: 'selltime', title: '出售时间', width: 260, sort: true, templet:'<div>{{ Format(d.selltime,"yyyy-MM-dd hh:mm:ss")}}</div>'}
	      ,{fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}
	    ]]
	  });
	  return false;
  });
  
  //执行一个 table 实例
  table.render({
    elem: '#test'
    //,height: 332
    ,url: 'Sell/selectsell.action' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
      {field: 'sid', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'prname', title: '产品名称', width:280}
      ,{field: 'zname', title: '出售员工', width:150}
      ,{field: 'username', title: '购买用户', width:120} 
      ,{field: 'sellprice', title: '订单总价格', width: 160}
      ,{field: 'sellcount', title: '购买数量', width: 100, sort: true}
      ,{field: 'selltime', title: '出售时间', width: 260, sort: true, templet:'<div>{{ Format(d.selltime,"yyyy-MM-dd hh:mm:ss")}}</div>'}
      ,{fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}
    ]]
  });
  
  form.render('select');
  
  //监听工具条
  table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
    var data = obj.data //获得当前行数据
    ,layEvent = obj.event; //获得 lay-event 对应的值
    var tr = obj.tr; //获得当前行 tr 的DOM对象
   
    if(layEvent === 'detail'){
      layer.msg('查看操作');
    } else if(layEvent === 'del'){
      layer.confirm('确认删除', function(index){
        obj.del(); //删除对应行（tr）的DOM结构
        layer.close(index);
        //向服务端发送删除指令
        var id = data.id;
        
        $.ajax({
        	url : "Product/deleteprod.action",
        	type : "post",
        	data : {"id" : id},
        	dataType : "JSON",
        	success : function (result){
        		layer.msg(result.msg);
        	}
        	
        });

        
      });
    } else if(layEvent === 'edit'){
    	layer.msg('编辑操作');
    }
  });

});


//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//Format("2016-10-04 8:9:4.423","yyyy-MM-dd hh:mm:ss.S") ==> 2016-10-04 08:09:04.423   
//Format("1507353913000","yyyy-M-d h:m:s.S")      ==> 2017-10-7 13:25:13.0  
function Format(datetime,fmt) {
if (parseInt(datetime)==datetime) {
 if (datetime.length==10) {
   datetime=parseInt(datetime)*1000;
 } else if(datetime.length==13) {
   datetime=parseInt(datetime);
 }
}
datetime=new Date(datetime);
var o = {
"M+" : datetime.getMonth()+1,                 //月份   
"d+" : datetime.getDate(),                    //日   
"h+" : datetime.getHours(),                   //小时   
"m+" : datetime.getMinutes(),                 //分   
"s+" : datetime.getSeconds(),                 //秒   
"S"  : datetime.getMilliseconds()             //毫秒   
};   
if(/(y+)/.test(fmt))   
fmt=fmt.replace(RegExp.$1, (datetime.getFullYear()+"").substr(4 - RegExp.$1.length));   
for(var k in o)   
if(new RegExp("("+ k +")").test(fmt))   
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
return fmt;
}
</script>
<script>
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

    