package com.st.rbac.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.rbac.pojo.Menu;
import com.st.rbac.pojo.Staff;
import com.st.rbac.service.IMenuService;

@Controller
@RequestMapping("/view")
public class ViewController {
	
	@Autowired
	IMenuService iMenuService;
	
	@RequestMapping("/index.action")
	public String index() {
		return "WEB-INF/views/index";
	}
	
	@RequestMapping("/getmenu.action")
	@ResponseBody
	public List<Menu> getmenu(HttpSession session, Staff staff2){
		//取当前用户信息
		Staff staff = (Staff) session.getAttribute("staff");
		
		staff2.setRoleid(staff.getRoleid());
		
		List<Menu> menu = iMenuService.selectRole(staff2);
		
		return menu;
	}
}
