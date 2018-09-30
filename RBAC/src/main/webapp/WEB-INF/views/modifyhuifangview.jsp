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
回访备注
</blockquote>
 
<form class="layui-form" action="">
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">回访描述</label>
    <div class="layui-input-block">
      <textarea placeholder="${param.returndecbe }" name="returndecbe" class="layui-textarea" style="height: 120px; width: 600px"></textarea>
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">回访备注</label>
    <div class="layui-input-block">
      <textarea placeholder="${param.remark }" name="remark" class="layui-textarea" style="height: 120px; width: 600px"></textarea>
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
	var staid = ${param.staid }
	var returndecbe = $("textarea[name='returndecbe']").val();
	var remark = $("textarea[name='remark']").val();

	layui.use(['form', 'layedit', 'laydate'], function(){
		  var form = layui.form
		  ,layer = layui.layer
		  ,layedit = layui.layedit
		  ,laydate = layui.laydate;
		$.ajax({
			url : "../../role/User/xiugaihuifang.action",
			type : "post",
			data : {"id": id, "returndecbe":returndecbe, "remark": remark, "staid": staid},
			dataType : "JSON",
			success : function(tips){
				
				if(tips.code == 2){
					layer.msg(tips.msg);
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