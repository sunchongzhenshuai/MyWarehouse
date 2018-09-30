package com.st.action;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.st.pojo.User;
import com.st.service.IUserService;

@Controller
@Scope("prototype")//多例模式
@Namespace("/user")
@ParentPackage("struts-default")
public class UserAction {
	


	@Autowired
	private IUserService iUserService;
	
	
	private User user;
	private String error;
	private String password2;
	
	
	public void setError(String error) {
		this.error = error;
	}
	public String getError() {
		return error;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	
	
	
	
	@Action(value="login", results= {
			@Result(name="success", location="/index.jsp"),
			@Result(name="error", location="/login.jsp")
	})
	public String login() {
		// 验证用户登录
		System.out.println(user.getUsername());
		System.out.println(user.getPassword());
		User loginUser = iUserService.login(user);
		
		if (loginUser == null) {
			return "error";
		} else {
			error = "登录失败!账号或密码错误!";
			return "success";
		}
	}
	@Action(value="register",results= {
			@Result(name="success", location="/login.jsp"),
			@Result(name="error", location="/register.jsp")
	})
	public String register() {
		//注册
		System.out.println(password2);
		int res = iUserService.register(user,password2);
		
		if (res > 0) {
			//注册成功转跳到登录yemian
			return "success";
		} else if (res == -100) {
			error = "两次输入密码不一致";
			return "error";
		} else if (res == -200) {
			error = "密码不能为空";
			return "error";
		} else if (res == -300) {
			error = "账号已存在";
			return "error";
		} else {
			//注册失败未知错误
			error = "注册失败";
			return "error";
		}
		
		
	}
}
