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
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="../layui/css/layui.css" media="all">
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
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
	left: 200px;
	width: 92px;
	height: 40px;
	line-height: 38px;
	text-align: center;
	color: #FFF;
	display: none;
}
.img-parent .layui-upload-img {
	
}
.img-parent .layui-upload-img-a {
	margin: 0 10px 10px 200px;
}
.img-parent:hover .img-delete{
	display: block;
}
.addpic{
	margin: 0 10px 10px 230px;
}
</style>
</head>
<body>
	<div class="layui-form" action="">
		<div class="addpic">
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
					
				</div>
			</div>
		</div>
	</div>	
	<div style="margin: auto;" id="pic">
		
	</div>

	<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
	<script src="../layui/layui.js" charset="utf-8"></script>

	<script>
	
	selectpic();
	
	function selectpic(){
		
		layui.use(['form', 'layedit', 'laydate'], function(){
			
			 var layer = layui.layer
			var prdid = ${param.id};
			$.ajax({
				url : "selectPic.action",
				type : "post",
				data : {"prdid": prdid},
				dataType : "JSON",
				success : function(pic){
					$.each(pic, function(index, item){
	
						var imgDiv = $("<div style='margin: auto;' class=\"img-parent\">" +
								"	<img class='layui-upload-img-a'  src=\"../" + item.prdpic +  "\">" +
								"	<div class=\"img-delete\">点击删除</div>"+
								"</div>");
						
						
						$("#pic").append(imgDiv);
						
						
						imgDiv.click(function(){
							
							
							var staff = ${sessionScope.staff.id};
							if(staff == 1 || staff == 2){
								$(this).remove();
								$.ajax({
									url : "../role/Product/deletepic.action",
									type : "post",
									data : {"prdpic": item.prdpic, "prdid": item.prdid},
									dataType : "JSON",
									success : function(res){
										
										if(res > 0){
											layer.msg("删除成功!");
										}else{
											layer.msg("删除失败!");
										}
										
									}
								});
							}else{
								layer.msg("没有权限!")
							}
								
						});
					      
					});
					
				}
			});
			
		});
	}
	layui.use(['form','upload', 'layedit','layer'], function(){
		  var form = layui.form
		  ,layer = layui.layer
		  ,layedit = layui.layedit
		  ,upload = layui.upload;
		  form.render();
			var form = layui.form;

		var staffid = ${sessionScope.staff.id };
		if(staffid == 1 || staffid == 2){
		  //拖拽上传
		  upload.render({
		    elem: '#test10'
		    ,url: '../role/Product/uploadPic.action'
		    ,multiple: true //开启多个文件上传
		    ,auto: false
		    ,bindAction:  '#myForm'
	    	,before: function(obj){ //obj参数包含的信息 ,跟choose回调完全一致,可参见上文
	        	layer.load();//上传loading
	        }
    	    ,choose: function(obj){
    		    //将每次选择的文件追加到文件队列
    		    var files = obj.pushFile();
    		    
    		    //预读本地文件，如果是多文件，则会遍历。(不支持ie8/9)
    		    obj.preview(function(index, file, result){
	    		      console.log(index); //得到文件索引
	    		      console.log(file); //得到文件对象
	    		      console.log(result); //得到文件base64编码，比如图片
	    		      var imgDiv = $('<img src="'+ result +'" alt="'+ file.name +'"  style="height: 100px;">');
	    		      $('#demo2').append(imgDiv)
	    		      //obj.resetFile(index, file, '123.jpg'); //重命名文件名，layui 2.3.0 开始新增
	    		      
	    		      imgDiv.click(function(){
	  					$(this).remove();
	  				});

    		    });
    	    }
    	    ,done: function(res){  //每个文件提交完成都会触发
    	        console.log(res)
    	        
    	  		var imgDiv = $("<div class=\"img-parent\"  >" +
    	  				"	<img style='display: none' src=\"" + res.data.prdpic + "\" class=\"layui-upload-img\">" +
    	  				"	<div class=\"img-delete\">点击删除</div>"+
    	  				"</div>");
    	  		
    	  		
    	  		$("#demo2").append(imgDiv);
    	  		
    	  		
    	      }
		  	,allDone: function(obj){ //当文件全部被提交后，才触发
			    console.log(obj.total); //得到总文件数
			    console.log(obj.successful); //请求成功的文件数
			    console.log(obj.aborted); //请求失败的文件数
			    layer.closeAll('loading'); //关闭loading
			    
			    

					//form.on('submit(add)',function(data){
						
						//添加图片
						var picture = ${param.id};
						var pics = new Array();
						
						//选择所有图片
						$(".layui-upload-img").each(function(){
							pics.push($(this).attr("src"));
						});
						
						
				 		$.ajax({
							url : "../role/Product/addpic.action",
							type : "post",
							data :{"pics" :pics, "picture":picture},
							traditional : true,   //开启后传到后台就是一个数组了  不开启每个都是字符串的数组
							dataType : "JSON",
							success : function(data){
								if (data.code == -1){
									layer.msg(data.msg);
								} else {
									layer.msg("上传成功!");
									form.render();
									selectpic();
								}
							}
						}); 
						
					//})
				
					$("#myForm").submit();
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					setTimeout(function () {
					  parent.layer.close(index); // 关闭layer
					},1500);
					
			  }
		    ,error: function(index,upload){
		    	layer.msg("上传失败!");
		    }
		  });
		} else {
			layer.msg("没有权限进行操作!");
		}

		});
		
	</script>

</body>
</html>