<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
	String path = request.getContextPath();   
	String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   
 
 <style>
.img-parent{
	float: left;
	position : relative;
}
.img-parent .img-delete{
	background-color: #00000051;
	cursor:pointer;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 92px;
	height: 92px;
	line-height: 90px;
	text-align: center;
	color: #FFF;
	display: none;
}
.img-parent .layui-upload-img {
	width: 92px;
	height: 92px;
	margin: 0 10px 10px 0;
}
.img-parent:hover .img-delete{
	display: block;
}
</style>
      
<blockquote class="layui-elem-quote layui-text">
添加产品
</blockquote>
              
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>添加产品 </legend>
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
					<input name="protime" type="text" class="layui-input" id="test5"
						placeholder="yyyy-MM-dd HH:mm:ss">
				</div>
			</div>
		</div>
  
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">标价</label>
      <div class="layui-input-inline" style="width: 100px;">
        <input type="text" name="sdprice" placeholder="￥" autocomplete="off" class="layui-input">
      </div>
      <div class="layui-form-mid">底价</div>
      <div class="layui-input-inline" style="width: 100px;">
        <input type="text" name="lowprice" placeholder="￥" autocomplete="off" class="layui-input">
      </div>
           <div class="layui-form-mid">商品数量</div>
      <div class="layui-input-inline" style="width: 100px;">
        <input type="text" name="stock" placeholder="" autocomplete="off" class="layui-input">
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
      <textarea placeholder="请输入内容" name="details" class="layui-textarea" style="height: 120px; width: 600px"></textarea>
    </div>
  </div>
	
	<div class="layui-form-item">
		<div class="layui-input-block">
			<div class="layui-upload-drag" id="test10">
				<i class="layui-icon"></i>
				<p>点击上传，或将文件拖拽到此处</p>
			</div>
				<div class="layui-upload">
					<blockquote class="layui-elem-quote layui-quote-nm"
						style="margin-top: 10px; display: table">
						预览图：
						<div class="layui-upload-list" id="demo2"></div>
					</blockquote>
				</div>
				
			</div>
	</div>
	<div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" id="myForm" lay-submit lay-filter="add">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
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
			 form.render("select");
		 }
	 });
})

layui.use(['form','upload', 'layedit','layer', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate
  ,upload = layui.upload;
  form.render();
	var form = layui.form;
	var staffid = ${sessionScope.staff.roleid };
	if(staffid == 1 || staffid == 2){
		form.on('submit(add)',function(data){
			
			//添加产品
			var prname = data.field.prname;
			var protime = data.field.protime;
			var sdprice = data.field.sdprice
			var lowprice = data.field.lowprice;
			var dclassid = data.field.dclassid;
			var xclassid = data.field.xclassid;
			var details = data.field.details;
			var stock = data.field.stock;
			var pics = new Array();
			
			//选择所有图片
			$(".layui-upload-img").each(function(){
				pics.push($(this).attr("src"));
			});
			
	 		$.ajax({
				url : "role/Product/prodadd.action",
				type : "post",
				data :{"prname": prname, "protime": protime, "sdprice": sdprice, "lowprice": lowprice, "dclassid": dclassid, "xclassid": xclassid, "details": details,"stock":stock, "pics" :pics},
				traditional : true,
				dataType : "JSON",
				success : function(data){
					if (data.code == -1){
						layer.msg(data.msg);
					} else {
						layer.msg("添加产品成功!");
						form.render();
						var viewurl = "role/Product/addproduct.action";
						updateView(viewurl);
					}
				}
			}); 
			return false;
			
		})
	} else {
		layer.msg("没有权限进行操作!");
	}
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
  //日期时间选择器
  laydate.render({
    elem: '#test5'
    ,type: 'datetime'
  });
  
  //拖拽上传
  upload.render({
    elem: '#test10'
    ,url: 'role/Product/uploadPic.action'
    ,multiple: true
    ,before: function(obj){ //obj参数包含的信息 ,跟choose回调完全一致,可参见上文
    	layer.load();//上传loading
    }
  	,allDone : function(obj){  //所有文件完成后触发
  		layer.closeAll("loading");//关闭loading
  		layer.msg("上传完成!");
  	}
    ,done: function(res){  //每个文件提交完成都会触发
      console.log(res)
      
		var imgDiv = $("<div class=\"img-parent\">" +
				"	<img src=\"" + res.data.prdpic + "\" class=\"layui-upload-img\">" +
				"	<div class=\"img-delete\">点击删除</div>"+
				"</div>");
		
		
		$("#demo2").append(imgDiv);
		
		imgDiv.click(function(){
			$(this).remove();
		});
      
    }
    ,error: function(index,upload){
    	layer.msg("上传失败!");
    }
  });
  
});
</script>