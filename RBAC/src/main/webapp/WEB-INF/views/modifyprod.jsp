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
修改产品
</blockquote>
              
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>修改产品 </legend>
</fieldset>
 
<form class="layui-form" action="">
  <div class="layui-form-item">
    <label class="layui-form-label">商品名</label>
    <div class="layui-input-inline">
      <input value="${param.prname }" type="text" name="prname" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">上架时间</label>
				<div class="layui-input-inline">
					<input value="${param.protime }" name="protime" type="text" class="layui-input" id="test5"
						placeholder="yyyy-MM-dd HH:mm:ss">
				</div>
			</div>
		</div>
  
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">标价</label>
      <div class="layui-input-inline" style="width: 100px;">
        <input value="${param.sdprice }" type="text" name="sdprice" placeholder="￥" autocomplete="off" class="layui-input">
      </div>
      <div class="layui-form-mid">底价</div>
      <div class="layui-input-inline" style="width: 100px;">
        <input value="${param.lowprice }" type="text" name="lowprice" placeholder="￥" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">一级分类</label>
      <div class="layui-input-inline">
        <select lay-verify="type" lay-filter="dclassid" name="dclassid" id="Yiji">
        	<option>一级分类</option>
        </select>
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">二级分类</label>
      <div class="layui-input-inline">
        <select name="xclassid" id="Erji">
			<option value="0">二级分类</option>
        </select>
      </div>
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">商品描述</label>
    <div class="layui-input-block">
      <textarea placeholder="请输入内容" name="details" class="layui-textarea">${param.details }</textarea>
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

	$.ajax({
		 url : "../../Category/getDclass.action",
		 type : "post",
		 data : {},
		 dataType : "JSON",
		 success : function(dclass){
			 var html ="<option value='0'>一级分类</option>";
			 $.each(dclass, function(index, item){
				html += "<option value='"+item.id+"'>"+item.cname+"</option>";
					
			 });
			 $("#Yiji").html(html);
		 }
	});
function modifyduct(){
	var id = ${param.id };
	var prname = $("input[name='prname']").val();
	var protime = $("input[name='protime']").val();
	var sdprice = $("input[name='sdprice']").val();
	var lowprice = $("input[name='lowprice']").val();
	var dclassid = $("select[name='dclassid']").val();
	var xclassid = $("select[name='xclassid']").val();
	var details = $("textarea").val();
	
	$.ajax({
		url : "../../role/Product/modifyduct.action",
		type : "post",
		data : {"id": id, "prname":prname, "protime":protime, "sdprice":sdprice, "lowprice":lowprice, "dclassid":dclassid, "xclassid":xclassid, "details":details},
		dataType : "JSON",
		success : function(tips){
			
			if(tips.code == 0){
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
	return false;
}

layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  form.on('select(dclassid)', function(data){
	  	var cid = data.value;
	  	if(cid != 0){
			 $.ajax({
				url : "../../Category/getXclass.action",
				type : "post",
				data : {"cid" :cid},
				dataType : "JSON",
				success : function(xclass){
					var html ="";
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
  //日期时间选择器
  laydate.render({
    elem: '#test5'
    ,type: 'datetime'
  });
  
  
});
</script>

</body>
</html>