<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   
 <form class="layui-form" lay-filter="example">
	  <div class="layui-form-item">
	    <div class="layui-inline">
	      <input type="text" name="prname" placeholder="请输入商品名" class="layui-input">	   
	    </div>
		 <div class="layui-inline">
		  	<select name="dclassid"  lay-filter="dclassid" id="Yiji">
			  <option value="">一级分类</option>
			</select>
		</div>	 
		<div class="layui-inline">	    
			<select name="xclassid" id="Erji">
			  <option value="">二级分类</option>
			</select> 
		</div>   
	  <div class="layui-inline">
			<button class="layui-btn" onclick="return selectproduct()">查询</button>
	</div>
	</div>
</form>

<table class="layui-hide" id="test" lay-filter="demo"></table>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">商品图片</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">

 selectproduct();
layui.use("form",function(){
	var form = layui.form;
	 $.ajax({
		 url : "Category/getDclass.action",
		 type : "post",
		 data : {},
		 dataType : "JSON",
		 success : function(dclass){
			 var html ="<option value='0'>一级分类</option>";
			 $.each(dclass, function(index, item){
				html += "<option value='"+item.id+"'>"+item.cname+"</option>";
					
			 });
			 $("#Yiji").html(html);
			 form.render('select');
		 }
	 });

});
function selectproduct(){ 


layui.use(['laypage', 'layer', 'table',  'element', 'form'], function(){
  var laypage = layui.laypage //分页
  layer = layui.layer //弹层
  ,table = layui.table //表格
  ,element = layui.element //元素操作
  ,form =layui.form;
  form.render();
  //执行一个 table 实例
  	 var prname = $("input[name='prname']").val();
	 var dclassid = $("#Yiji").val();
	 var xclassid = $("#Erji").val();
	  
  table.render({
    elem: '#test'
    //,height: 332
    ,url: 'Product/selectprod.action' //数据接口
    ,where: {"prname":prname, "dclassid": dclassid, "xclassid": xclassid}
    ,page: true //开启分页
    ,id:"tab"
    ,cols: [[ //表`头
      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'prname', title: '产品名', width:170}
      ,{field: 'details', title: '产品介绍', width:280}
      ,{field: 'sdprice', title: '标准价格', width:120, sort: true} 
      ,{field: 'lowprice', title: '最低价格', width:120, sort: true}
      ,{field: 'stock', title: '库存', width: 80, sort: true}
      ,{field: 'protime', title: '上架时间', width: 260, sort: true}
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
 
    	var staffid = ${sessionScope.staff.roleid };
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
		    	title :'修改商品',
		    	shade: 0.8,
		        maxmin: true,
		        closeBtn: 1,
		    	area: ['1200px', '800px'],
		    	content: 'role/Product/modifyprod.action?id='+id+'&prname='+data.prname+'&protime='+data.protime+'&sdprice='+data.sdprice+'&lowprice='+data.lowprice+'&details='+data.details+'',
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
  
	  form.on('select(dclassid)', function(data){
		  	var cid = data.value;
		  	if(cid != 0){
				 $.ajax({
					url : "Category/getXclass.action",
					type : "post",
					data : {"cid" :cid},
					dataType : "JSON",
					success : function(xclass){
						var html ="<option value='0'>二级分类</option>";
						$.each(xclass, function(index, item){
							html += "<option value='"+item.id+"'>"+item.cname+"</option>";
							
						});
						$("#Erji").html(html);
						form.render('select');
					}
				}); 
		  	} else{
		  		var html = "<option value='0'>二级分类</option>";
		  		$("#Erji").html(html);
		  		form.render('select');
		  	}
		  	
		});
	  	
	});
		return false;
}	
</script>
