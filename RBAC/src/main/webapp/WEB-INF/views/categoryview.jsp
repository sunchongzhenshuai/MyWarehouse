<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>  
 <form class="layui-form" lay-filter="example">
	  <div class="layui-form-item">
	    <div class="layui-inline">
	      <input type="text" name="cname" placeholder="请输入分类名" class="layui-input">	   
	    </div>
  
	  <div class="layui-inline">
			<button class="layui-btn" onclick="return selectproduct()">查询</button>
	</div>
	</div>
</form>

<table class="layui-hide" id="test" lay-filter="demo"></table>
  <form class="layui-form" lay-filter="example">
	  <div class="layui-form-item">
	    <div class="layui-inline">
	      <input type="text" name="cname" placeholder="请输入分类名" lay-verify="required" class="layui-input">	   
	    </div>
  
	  <div class="layui-inline">
			<button class="layui-btn" lay-submit lay-filter="tianjia"">添加一级分类</button>
	</div>
	</div>
</form>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看下级分类</a>
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
		
	  var cname = $("input[name='cname']").val();
	  table.render({
	    elem: '#test'
	    //,height: 332
	    ,url: 'Category/selectClass.action' //数据接口
	    ,where: {"cname": cname}
	    ,page: true //开启分页
	    ,id:"tab"
	    ,cols: [[ //表`头
	      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'cname', title: '类别名', width:150}
	      ,{field: 'salesv', title: '销售总额', width:150,sort: true}
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
		    	title :'查看下级分类',
		    	shade: 0.8,
		        maxmin: true,
		        closeBtn: 1,
		    	area: ['1200px', '800px'],
		    	content: 'Category/lookXclass.action?id='+id+'',
		        end: function () {
		        	
		        	table.reload("tab" ,{
		        	});
		          },
		    });
	    } else if(layEvent === 'del'){
	      layer.confirm('确认删除', function(index){
	 
	    	var staffid = ${sessionScope.staff.roleid };
	        if(staffid == 1 || staffid == 2){
	    	
	        obj.del(); //删除对应行（tr）的DOM结构
	        layer.close(index);
	        //向服务端发送删除指令
	        var id = data.id;
	        	
		        $.ajax({
		        	url : "role/Category/deleteClass.action",
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
			    	title :'修改商品',
			    	shade: 0.8,
			        maxmin: true,
			        closeBtn: 1,
			    	area: ['800px', '600px'],
			    	content: 'role/Category/modifyClassview.action?id='+id+'&cname='+data.cname+'',
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
	  
		  form.on('submit(tianjia)', function(data){
	
				
			   	var staffid = ${sessionScope.staff.roleid };
			    if(staffid == 1){
				  	var cid = 0;
				  	var cname = data.field.cname;
			    
			        $.ajax({
			        	url : "role/Category/addClass.action",
			        	type : "post",
			        	data : {"cname" : cname, "cid": cid},
			        	dataType : "JSON",
			        	success : function (result){
			        		layer.msg(result.msg);
				        	table.reload("tab" ,{
				        	});
			        	}
			        	
			        });
			    }else{
			    	layer.msg("没有权限 无法添加");
			    }
				
				return false;
			  	
			});
	})
	  	
}	
</script>
