<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<blockquote class="layui-elem-quote layui-text">添加员工</blockquote>
<div style="margin: auto; height: 900px; width: 500px;">
	<form class="layui-form" action="">
		<div class="layui-form-item">
			<label class="layui-form-label">员工账号</label>
			<div class="layui-input-inline">
				<input style="width: 290px;" type="text" name="stname" lay-verify="required"
					autocomplete="off" placeholder="请输员工账号" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">员工密码</label>
			<div class="layui-input-inline">
				<input style="width: 290px;" type="password" name="stpassword" lay-verify="required"
					autocomplete="off" placeholder="请输员工密码" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">员工姓名</label>
			<div class="layui-input-inline">
				<input style="width: 290px;" type="text" name="zname" lay-verify="required"
					autocomplete="off" placeholder="请输员工姓名" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">员工手机</label>
				<div class="layui-input-inline">
					<input style="width: 290px;" type="tel" name="stphone" lay-verify="phone"
						autocomplete="off"placeholder="请输员工电话"  class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">出生日期</label>
				<div class="layui-input-inline">
					<input style="width: 290px;" name="stbday" type="text" class="layui-input" id="test5"
						placeholder="yyyy-MM-dd HH:mm:ss">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">员工性别</label>
			<div class="layui-input-block">
				<input type="radio" name="stsex" value="男" title="男" checked="">
				<input type="radio" name="stsex" value="女" title="女">
			</div>
		</div>
	
		<div class="layui-form-item">
			<div class="layui-form-item" style="width: 390px;">
				<label class="layui-form-label">所属职位</label>
				<div class="layui-input-block">
					<select style="width: 390px;" name="roleid" id="Erji"
						 lay-filter="dclassid">
						<option value="0">请选择</option>
					</select>
				</div>
			</div>
			<div style="width: 390px;" class="layui-inline">
				<label class="layui-form-label">所属领导</label>
				<div class="layui-input-block">
					<select style="width: 390px;" lay-verify="type" name="stleader"
						id="Yiji">
						<option>请选择</option>
					</select>
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
</div>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
	layui.use("form", function() {
		var form = layui.form;
		$.ajax({
			url : "Staff/selectRole.action",
			type : "post",
			data : {},
			dataType : "JSON",
			success : function(result) {
				var html = "";
				$.each(result.data, function(index, item) {
					html += "<option value='"+item.id+"'>" + item.rolename+ "</option>";

				});
				$("#Erji").html(html);
				form.render("select");
			}
		});
	})


	layui.use([ 'form', 'upload', 'layedit', 'layer', 'laydate' ],function() {
		var form = layui.form
		, layer = layui.layer
		, layedit = layui.layedit
		, laydate = layui.laydate
		, upload = layui.upload;
		
		form.on('submit(add)',function(data){
 			$.ajax({
				url : "role/Staff/addStaff.action",
				type : "post",
				data : data.field,
				dataType : "JSON",
				success : function(tips){
					layer.msg(tips.msg);
					var viewurl = "role/Staff/addstaffview.action";
					updateView(viewurl);
				}
				
			}); 
			return false;
		});
		
		form.render('radio');
		
		form.on('select(dclassid)',function(data) {
			var roleid = data.value;
			if (roleid != 0) {
				$.ajax({
					url : "Staff/selectStaff.action?limit=0&page=0",
					type : "post",
					data : {"roleid" : roleid},
					dataType : "JSON",
					success : function(xclass) {
						var html = "";
						$.each(xclass.data,function(index,item) {
							html += "<option value='"+item.id+"'>"+ item.zname+ "</option>";
	
						});
							$("#Yiji").html(html);
							form.render('select');
					}
				});

			} else {
				
					var html = "<option value='0'>二级分类</option>";
					$("#Erji").html(html);
					form.render('select');
					
			}
	
		});
						//日期时间选择器
	laydate.render({
		elem : '#test5',
		type : 'datetime'
	});
});
</script>