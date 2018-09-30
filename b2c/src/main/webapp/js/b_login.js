//alert($)
$(document).ready(function(){//页面加载完成再加载脚本
	$('input[name="button"]').click(function(event){
		var $name = $('input[name="managername"]');
		var $password = $('input[name="password"]'); 
		var $text = $(".text");

		if(managername==''){
			$text.text('请输入用户名');
			$name.focus();
			return;
		}
		if(password==''){
			$text.text('请输入密码');
			$name.focus();
			return;
		}
		/*if(_name=="admin" &&_password=="admin"){
			$text.text("登陆成功，请稍后...");
		    window.location.href = "content.html";
		}else{
			$text.text("用户名或密码错误.");
		}*/
		

	});

});