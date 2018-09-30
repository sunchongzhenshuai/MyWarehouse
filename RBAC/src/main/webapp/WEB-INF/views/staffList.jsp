<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   
    
    
<table class="layui-hide" id="test" lay-filter="demo"></table>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">
 
layui.use(['laydate', 'laypage', 'layer', 'table',  'element'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  layer = layui.layer //弹层
  ,table = layui.table //表格
  ,element = layui.element; //元素操作
  
  //向世界问个好
  //layer.msg('Hello World');
  
  //监听Tab切换
  element.on('tab(demo)', function(data){
    layer.msg('切换了：'+ this.innerHTML);
    console.log(data);
  });
  
  //执行一个 table 实例
  table.render({
    elem: '#test'
    //,height: 332
    ,url: 'Staff/selectStaff.action' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'stname', title: '账号', width:80}
      ,{field: 'zname', title: '姓名', width: 80}
      ,{field: 'stsex', title: '性别', width:80} 
      ,{field: 'stphone', title: '联系电话', width: 200, sort: true}
      ,{field: 'rolename', title: '职位', width: 100, sort: true}
      ,{field: 'stleader', title: '领导', width:100}
      ,{field: 'ststate', title: '任职状态', width:120}
      ,{field: 'achievement', title: '销售业绩', width:120}
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
    