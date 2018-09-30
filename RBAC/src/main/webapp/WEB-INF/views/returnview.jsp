<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   
 <form class="layui-form" lay-filter="example">
	  <div class="layui-form-item">
	    <div class="layui-inline">
	      <input type="text" name="uname" placeholder="请输入客户名" class="layui-input">	   
	    </div>
 
	  <div class="layui-inline">
			<button class="layui-btn" onclick="return selectproduct()">查询</button>
	</div>
	</div>
</form>

<table class="layui-hide" id="test" lay-filter="demo"></table>
 
<script type="text/html" id="barDemo">
 	  <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">

 selectproduct();

function selectproduct(){ 


layui.use(['laypage', 'layer', 'table',  'element', 'form'], function(){
  var laypage = layui.laypage //分页
  layer = layui.layer //弹层
  ,table = layui.table //表格
  ,element = layui.element //元素操作
  ,form =layui.form;
  form.render();
  //执行一个 table 实例
  	 var uname = $("input[name='uname']").val();
	  
  table.render({
    elem: '#test'
    //,height: 332
    ,url: 'role/User/selectReturn.action' //数据接口
    ,where: {"uname":uname}
    ,page: true //开启分页
    ,id:"tab"
    ,cols: [[ //表`头
      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'username', title: '顾客姓名', width:170}
      ,{field: 'zname', title: '所属员工', width:120}
      ,{field: 'returndecbe', title: '回访描述', width:220} 
      ,{field: 'remark', title: '备注', width:120}
      ,{field: 'uphone', title: '顾客电话', width: 150}
      ,{field: 'returntime', title: '回访时间', width: 260, sort: true, templet:'<div>{{ Format(d.returntime,"yyyy-MM-dd hh:mm")}}</div>'}
      ,{fixed: 'right', width: 200, align:'center', toolbar: '#barDemo'}
    ]]
  });
  
  //监听工具条
  table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
    var data = obj.data //获得当前行数据
    ,layEvent = obj.event; //获得 lay-event 对应的值
    var tr = obj.tr; //获得当前行 tr 的DOM对象
   
    if(layEvent === 'detail'){
	    var id = data.id;
	    layer.open({
	    	type: 2,
	    	title :'查看商品',
	    	shade: 0.8,
	        maxmin: true,
	        closeBtn: 1,
	    	area: ['1200px', '800px'],
	    	content: 'Product/lookproduct.action?id='+id+'',
	        end: function () {
	        	
	        	table.reload("tab" ,{
	        	});
	          },
	    });
    } else if(layEvent === 'del'){
      layer.confirm('确认删除', function(index){
 
    	var staffid = ${sessionScope.staff.id };
        if(staffid == 1 || staffid == 2){
    	
        obj.del(); //删除对应行（tr）的DOM结构
        layer.close(index);
        //向服务端发送删除指令
        var id = data.id;
        	
	        $.ajax({
	        	url : "role/Product/deleteprod.action",
	        	type : "post",
	        	data : {"id" : id},
	        	dataType : "JSON",
	        	success : function (result){
	        		layer.msg(result.msg);
	        	}
	        	
	        });
        }else{
        	layer.msg("没有权限 无法删除");
        }

      });
    } else if(layEvent === 'edit'){
    	var staffid = ${sessionScope.staff.roleid };
        if(staffid == 1 || staffid == 2){
		    var id = data.id;
		    layer.open({
		    	type: 2,
		    	title :'修改回访',
		    	shade: 0.8,
		        maxmin: true,
		        closeBtn: 1,
		    	area: ['800px', '600px'],
		    	content: 'role/User/modifyhuifangview.action?id='+id+'&returndecbe='+data.returndecbe+'&remark='+data.remark+'',
		        end: function () {
		        	
		        	table.reload("tab" ,{
		        	});
		          },
		    });
        }else{
        	layer.msg("没有权限 无法修改");
        }
	  }
	});
  
	  	
	});
		return false;
}	

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
