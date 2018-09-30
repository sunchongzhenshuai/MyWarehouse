package com.st.rbac.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.rbac.pojo.Access;
import com.st.rbac.pojo.ResponseResult;
import com.st.rbac.pojo.Role;
import com.st.rbac.pojo.Staff;
import com.st.rbac.pojo.User;
import com.st.rbac.service.IAccessService;
import com.st.rbac.service.IRoleService;
import com.st.rbac.service.IStaffService;
import com.st.rbac.util.Page;

@Controller
public class StaffController {
	
	@Autowired
	IAccessService iAccessService;
	
	@Autowired
	IStaffService iStaffService;
	
	@Autowired
	IRoleService iRoleService;
	
	@RequestMapping("/Staff/staffList.action")
	public String staffList() {
		return "WEB-INF/views/staffList";
	}
	@RequestMapping("role/Staff/addstaffview.action")
	public String addstaffview() {
		return "WEB-INF/views/addstaffview";
	}
	
	@RequestMapping("role/Staff/addStaff.action")
	@ResponseBody
	public ResponseResult addStaff(Staff staff) {
		
		Integer res = iStaffService.addStaff(staff);
		
		ResponseResult result = new ResponseResult();
		if (res > 0) {
			result.setCode(2);
			result.setMsg("添加成功");
		}else {
			
			result.setCode(-2);
			result.setMsg("添加失败");
		}
		
		return result;
	}
	
	@RequestMapping("/Staff/selectRole.action")
	@ResponseBody
	public ResponseResult selectRole() {
		
		List<Role> list = iRoleService.selectRole();
		
		ResponseResult result = new ResponseResult();
		
		result.setCode(0);
		result.setCount(0);
		result.setData(list);
		result.setMsg("");
		return result;
	}
	
	@RequestMapping("/Staff/login.action")
	public ModelAndView login(Staff staff, HttpSession session) {
		
		Staff staff2 = iStaffService.login(staff);
		
		ModelAndView mv = new ModelAndView();
		
		if (staff2 != null) {
			session.setAttribute("staff", staff2);
			//用户登录成功
			Map<String, String> accesses = iAccessService.selectByRoleid(staff2.getRoleid());
			//将其对应角色下的权限全部取出,放在Session中 
			//String url = "role/Product/addview.action";
			//System.out.println(accesses.get(url));
			session.setAttribute("accesses", accesses);
			mv.setViewName("redirect:../view/index.action");
		}else {
			mv.addObject("error", "登陆失败，账号或密码错误！");
			mv.setViewName("login");
		}
		
		return mv;
	}
	
	//用户退出
	@RequestMapping("/Staff/logout.action")
	public String logout(HttpSession session) {
		//清楚session中的数据
		session.removeAttribute("staff");
		
		return "redirect:../login.jsp";
	}
	
	@RequestMapping("/Staff/selectStaff.action")
	@ResponseBody
	public ResponseResult selectStaff(Integer limit,Integer page, Staff staff, HttpSession session) {
		
		Page page2 = new Page();
		page2.setPagerows(limit);
		page2.setCurpage(page);
		Staff staff2 = (Staff) session.getAttribute("staff");
		System.out.println(staff.getRoleid());
		List<HashMap<String, Object>> list;
		Integer count;
		if (staff2.getRoleid() != 1) {
			staff.setStleader(staff2.getId());
			list = iStaffService.selectStaff(page2 ,staff);
			
			count = iStaffService.getRows(staff);
		}else {
			list = iStaffService.selectStaff(page2 ,staff);
			
			count = iStaffService.getRows(staff);
		}
		
		ResponseResult result = new ResponseResult();
		
		result.setCode(0);
		result.setCount(count);
		result.setData(list);
		
		return result;
		
	}
	
}
