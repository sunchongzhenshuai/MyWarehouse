<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<blockquote class="layui-elem-quote layui-text">添加订单</blockquote>

<fieldset class="layui-elem-field layui-field-title"
	style="margin-top: 20px;">
	<legend>添加订单 </legend>
</fieldset>

<form class="layui-form" action="">

	<div class="layui-form-item">
		<label class="layui-form-label">顾客姓名</label>
		<div class="layui-input-inline">
			<input type="text" name="username" lay-verify="required"
				autocomplete="off" placeholder="请输顾客姓名" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">用户手机</label>
			<div class="layui-input-inline">
				<input type="tel" name="uphone" lay-verify="phone"
					autocomplete="off"placeholder="请输顾客电话"  class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">顾客年龄</label>
		<div class="layui-input-inline">
			<input type="text" name="age" lay-verify="required"
				autocomplete="off" placeholder="请输顾客年龄" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">客户性别</label>
		<div class="layui-input-block">
			<input type="radio" name="sex" value="男" title="男" checked="">
			<input type="radio" name="sex" value="女" title="女">
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">购买时间</label>
			<div class="layui-input-inline">
				<input name="selltime" type="text" class="layui-input" id="test5"
					placeholder="yyyy-MM-dd HH:mm:ss">
			</div>
		</div>
	</div>

	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">购买数量</label>
			<div class="layui-input-inline" style="width: 100px;">
				<input type="text" name="sellcount" autocomplete="off"
					class="layui-input">
			</div>
			<div class="layui-form-mid">单价</div>
			<div class="layui-input-inline" style="width: 100px;">
				<input type="text" name="sellprice" placeholder="￥"
					autocomplete="off" class="layui-input">
			</div>
			<div class="layui-inline" id="price">
				<label class="layui-form-label" style="width: 100px;">商品价格区间</label>
				<div id="sdprice" class="layui-form-mid" style="color: #b61d1d;font-weight: 800">0</div>
				<div class="layui-form-mid" style="color: #b61d1d;">~ ~</div>
				<div id="lowprice" class="layui-form-mid" style="color: #b61d1d; font-weight: 800">0</div>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">一级分类</label>
			<div class="layui-input-inline">
				<select lay-verify="type" lay-filter="dclassid" name="dclassid"
					id="Yiji">
					<option>一级分类</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">二级分类</label>
			<div class="layui-input-inline">
				<select name="xclassid" id="Erji" lay-filter="xclassid">
					<option value="0">二级分类</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">选择产品</label>
			<div class="layui-inline">
				<select name="pid" lay-filter="product" id="product" lay-search>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</label>
		<div class="layui-input-block">
			<textarea placeholder="请输入内容" name="remarks" class="layui-textarea"
				style="height: 120px; width: 860px"></textarea>
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
	layui.use("form", function() {
		var form = layui.form;
		$.ajax({
			url : "Category/getDclass.action",
			type : "post",
			data : {},
			dataType : "JSON",
			success : function(dclass) {
				var html = "<option value='0'>一级分类</option>";
				$.each(dclass, function(index, item) {
					html += "<option value='"+item.id+"'>" + item.cname+ "</option>";

				});
				$("#Yiji").html(html);
				form.render("select");
			}
		});
		
		//查询所有所有商品
		form.on('select(xclassid)', function(data) {
			var dclassid = $("#Yiji").val();
			var xclassid = $("#Erji").val();
			if (xclassid != 0) {
			
				$.ajax({
					url : "Product/selectprod.action?limit=0&page=0",
					type : "post",
					data : {"dclassid" : dclassid,"xclassid" : xclassid},
					dataType : "JSON",
					success : function(product) {
						var html = "<option value='0'></option>";
						
							form.on('select(product)',function(data){
								var price2 = $("#product").val();
								$.each(product.data,function(index,item){
									if(item.id == price2){
										var price = 
											"<label class=\"layui-form-label\" style=\"width: 100px;\">商品价格区间</label>"+
											"<div id=\"sdprice\" class=\"layui-form-mid\" style=\"color: #b61d1d;font-weight: 800\">"+item.lowprice+"</div>"+
											"<div class=\"layui-form-mid\" style=\"color: #b61d1d;\">~ ~</div>"+
											"<div id=\"lowprice\" class=\"layui-form-mid\" style=\"color: #b61d1d; font-weight: 800\">"+item.sdprice+"</div>";
										$("#price").html(price);
									}
								});
								
							});
						
						
						$.each(product.data, function(index, item) {

							html += "<option value='"+item.id+"'>"+ item.prname + "</option>";
							
						});
						$("#product").html(html);
						form.render('select');
					}
				});
			} else {
				var html = "<option value='0'>请选择先分类</option>";
				$("#product").html(html);
				form.render('select');
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
				url : "role/Sell/addSell.action",
				type : "post",
				data : data.field,
				dataType : "JSON",
				success : function(tips){
					if(tips.code == 1){
						layer.msg(tips.msg);
						var viewurl = "role/Sell/addsellview.action";
						updateView(viewurl)
					}else{
						layer.msg(tips.msg);
					}
				}
				
			}); 
			return false;
		});
		
		form.render('radio');
		
		form.on('select(dclassid)',function(data) {
			var cid = data.value;
			if (cid != 0) {
				$.ajax({
					url : "Category/getXclass.action",
					type : "post",
					data : {"cid" : cid},
					dataType : "JSON",
					success : function(xclass) {
						var html = "<option value='0'>二级分类</option>";
						$.each(xclass,function(index,item) {
							html += "<option value='"+item.id+"'>"+ item.cname+ "</option>";
	
						});
							$("#Erji").html(html);
							form.render('select');
					}
				});
				
				var dclassid = $("#Yiji").val();
				var xclassid = $("#Erji").val();
				
					$.ajax({
						url : "Product/selectprod.action?limit=0&page=0",
						type : "post",
						data : {"dclassid" : dclassid,"xclassid" : xclassid},
						dataType : "JSON",
						success : function(product) {
							var html = "<option value='0'></option>";
							
							form.on('select(product)',function(data){
								var price2 = $("#product").val();
								$.each(product.data,function(index,item){
									$(price).remove();
									if(item.id == price2){
										
										var price = 
											"<label class=\"layui-form-label\" style=\"width: 100px;\">商品价格区间</label>"+
											"<div id=\"sdprice\" class=\"layui-form-mid\" style=\"color: #b61d1d;font-weight: 800\">"+item.lowprice+"</div>"+
											"<div class=\"layui-form-mid\" style=\"color: #b61d1d;\">~ ~</div>"+
											"<div id=\"lowprice\" class=\"layui-form-mid\" style=\"color: #b61d1d; font-weight: 800\">"+item.sdprice+"</div>";
										
									}
									$("#price").html(price);
								});
								
							});
							
							$.each(product.data, function(index, item) {

								html += "<option value='"+item.id+"'>"+ item.prname + "</option>";

							});
							$("#product").html(html);
							form.render('select');
						}
					});
				
			} else {
				
					var html = "<option value='0'>二级分类</option>";
					$("#Erji").html(html);
					form.render('select');
					var htm = "<option value='0'>请选择先分类</option>";
					$("#product").html(htm);
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