<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   
    
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layui</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../../layui/css/layui.css"  media="all">
  <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
          
<blockquote class="layui-elem-quote layui-text">
修改分类
</blockquote>
              
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>修改分类 </legend>
</fieldset>
 
<form class="layui-form" action="">
  <div class="layui-form-item">
    <label class="layui-form-label">分类名</label>
    <div class="layui-input-inline">
      <input value="${param.cname }" type="text" name="cname" lay-verify="title" autocomplete="off" placeholder="请输入类名" class="layui-input">
    </div>
  </div>

  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" id="myForm" type="submit" onclick="return modifyduct()">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>
 
<script type="text/javascript" src="../../js/jquery-3.1.1.min.js"></script>          
<script src="../../layui/layui.js" charset="utf-8"></script>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>

function modifyduct(){
	var id = ${param.id };
	var cname = $("input[name='cname']").val();

	layui.use(['form', 'layedit', 'laydate'], function(){
		  var form = layui.form
		  ,layer = layui.layer
		  ,layedit = layui.layedit
		  ,laydate = layui.laydate;
		$.ajax({
			url : "../../role/Category/modifyClass.action",
			type : "post",
			data : {"id": id, "cname":cname},
			dataType : "JSON",
			success : function(tips){
				
				if(tips.code == 1){
					layer.msg("修改成功");
					$("#myForm").submit();
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					setTimeout(function () {
					  parent.layer.close(index); // 关闭layer
					},1500);
				}else{
					
					layer.msg(tips.msg);
				} 
			}
			
		});
		
	});
	return false;
	}

  
</script>

</body>
</html>