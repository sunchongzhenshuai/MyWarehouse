<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>

<form class="layui-form" lay-filter="example">
	<div class="layui-form-item">

		<div class="layui-inline">
			<select name="id" lay-filter="dclassid" id="user" lay-search>
			</select>
		</div>
		<div class="layui-inline">
			<select name="sfid" id="staff">
				<option value="">二级分类</option>
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
		url : "User/selectuser.action?limit=0&page=0",
		type : "post",
		data : {},
		dataType : "JSON",
		success : function(product){
			var html = "<option value='0'>搜索选择客户</option>";
			$.each(product.data , function(index, item){
				
				html += "<option value='"+item.id+"'>"+item.username+"</option>";
				
			});
			$("#user").html(html);
			form.render('select');
		}
	});
	
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
	 form.render('select');
});
 
 
layui.use(['laydate', 'laypage', 'layer', 'table',  'element','form'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  layer = layui.layer //弹层
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
	    ,url: 'User/selectuser.action' //数据接口
	    ,where :data.field
	    ,page: true //开启分页
	    ,cols: [[ //表头
	      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'username', title: '客户姓名', width:120}
	      ,{field: 'zname', title: '所属员工', width:120}
	      ,{field: 'sex', title: '性别', width:80} 
	      ,{field: 'age', title: '年龄', width: 80}
	      ,{field: 'uphone', title: '联系电话', width: 160, sort: true}
	      ,{field: 'cname', title: '意向类', width: 100, sort: true}
	      ,{field: 'prname', title: '意向产品', width:100}
	      ,{field: 'likestate', title: '意向状态', width:120}
	      ,{field: 'returnstate', title: '回访状态', width:120}
	      ,{field: 'likestate', title: '意向状态', width:120}
	      ,{field: 'remarks', title: '备注', width:220}
	      ,{fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}
	    ]]
	  });
	  return false;
  });
  
  
  //执行一个 table 实例
  table.render({
    elem: '#test'
    //,height: 332
    ,url: 'User/selectuser.action' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'username', title: '客户姓名', width:120}
      ,{field: 'zname', title: '所属员工', width:120}
      ,{field: 'sex', title: '性别', width:80} 
      ,{field: 'age', title: '年龄', width: 80}
      ,{field: 'uphone', title: '联系电话', width: 160, sort: true}
      ,{field: 'likeclass', title: '意向类', width: 100, sort: true}
      ,{field: 'likeprod', title: '意向产品', width:100}
      ,{field: 'likestate', title: '意向状态', width:120}
      ,{field: 'returnstate', title: '回访状态', width:120}
      ,{field: 'likestate', title: '意向状态', width:120}
      ,{field: 'remarks', title: '备注', width:220}
      ,{fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}
    ]]
  });
  
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

</script>
    