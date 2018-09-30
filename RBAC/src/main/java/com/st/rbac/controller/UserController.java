package com.st.rbac.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.rbac.pojo.ResponseResult;
import com.st.rbac.pojo.Returnuser;
import com.st.rbac.pojo.Staff;
import com.st.rbac.pojo.User;
import com.st.rbac.service.IReturnuserService;
import com.st.rbac.service.IUserService;
import com.st.rbac.util.Page;

@Controller
public class UserController {
	
	@Autowired
	IUserService iUserService;
	
	@Autowired
	IReturnuserService iReturnuserService;
	
	@RequestMapping("/User/userList.action")
	public String userList() { 
		return "WEB-INF/views/userList";
	}
	@RequestMapping("role/User/adduserview.action")
	public String adduserview() {
		return "WEB-INF/views/adduserview";
	}
	@RequestMapping("role/User/returnuserview.action")
	public String returnuserview() {
		return "WEB-INF/views/returnuserview";
	}
	@RequestMapping("role/User/huifangbeizhu.action")
	public String huifangbeizhu() {
		return "WEB-INF/views/huifangview";
	}
	@RequestMapping("role/User/modifyhuifangview.action")
	public String modifyhuifangview() {
		return "WEB-INF/views/modifyhuifangview";
	}
	
	@RequestMapping("role/User/xiugaihuifang.action")
	@ResponseBody
	public ResponseResult xiugaihuifang(Returnuser returnuser,HttpSession session) {
		
		Staff staff = (Staff) session.getAttribute("staff");
		
		returnuser.setStaffdid(staff.getId());
		Integer res = iReturnuserService.xiugaihuifang(returnuser);
		User user = new User();
		user.setReturnstate("已回访");
		user.setId(returnuser.getId());
		Integer res2 = iUserService.modifyuser(user);
		ResponseResult result = new ResponseResult();
		if (res > 0) {
			if (res2 > 0) {
				result.setCode(2);
				result.setMsg("回访成功");
			}else {
				result.setCode(-2);
				result.setMsg("回访失败");
			}
		}else {
			result.setCode(-3);
			result.setMsg("回访失败");
		}

		return result;
	}
	
	@RequestMapping("role/User/huifangview.action")
	@ResponseBody
	public ResponseResult huifanguserview(HttpSession session) {
		
		Staff staff = (Staff) session.getAttribute("staff");
		Integer staid = staff.getId();
		List<Map<String, Object>> list = iUserService.getuser(staid);
		
		ResponseResult result = new ResponseResult();
		
		result.setCode(0);
		result.setCount(10);
		result.setMsg("");
		result.setData(list);
		return result;
	}
	
	@RequestMapping("role/User/selectReturn.action")
	@ResponseBody
	public ResponseResult selectReturn(Integer limit, Integer page,Returnuser returnuser, String uname,HttpSession session) {
		
		Page page2 = new Page();
		
		page2.setPagerows(limit);
		page2.setCurpage(page);
		
		Staff staff = (Staff) session.getAttribute("staff");
		
		List<HashMap<String, Object>> list;
		Integer count;
		if (staff.getRoleid() == 1) {
			list = iReturnuserService.selectReturn(page2, returnuser, uname);
			
			count = iReturnuserService.selectRows(returnuser, uname);
		}else if (staff.getRoleid() ==2) {
			returnuser.setStaffdid(staff.getId());
			list = iReturnuserService.selectReturn(page2, returnuser, uname);
			
			count = iReturnuserService.selectRows(returnuser, uname);
		}else {
			returnuser.setStaid(staff.getId());
			list = iReturnuserService.selectReturn(page2, returnuser, uname);
			
			count = iReturnuserService.selectRows(returnuser, uname);
		}
		
		ResponseResult result = new ResponseResult();
		result.setCode(0);
		result.setCount(count);
		result.setMsg("");
		result.setData(list);
		return result;
	}
	
	@RequestMapping("/User/selectuser.action")
	@ResponseBody
	public ResponseResult selectuser(Integer limit, Integer page, User user, HttpSession session) {
		
		Staff staff = (Staff) session.getAttribute("staff");
		
		Page page2 = new Page();
		page2.setPagerows(limit);
		page2.setCurpage(page);
		
		System.out.println(user.getSfid());
		List<HashMap<String, Object>> list;
		Integer count;
		if (staff.getRoleid() == 2) {
			user.setSfaid(staff.getId());
			user.setSfid(staff.getId());
			 list = iUserService.selectuser(page2,user);
			
			count = iUserService.getRows(user);
		}else if (staff.getRoleid() == 3) {
			user.setSfaid(staff.getStleader());
			user.setSfid(staff.getId());
			 list = iUserService.selectuser(page2,user);
			
			count = iUserService.getRows(user);
		}else {
			
			list = iUserService.selectuser(page2,user);
			
			count = iUserService.getRows(user);
		}

		
		ResponseResult result = new ResponseResult();
		
		result.setCode(0);
		result.setCount(count);
		result.setData(list);
		
		
		return result;
		
	}
	
	@RequestMapping("role/User/addUser.action")
	@ResponseBody
	public ResponseResult addUser(User user, HttpSession session) {
		
		Staff staff = (Staff) session.getAttribute("staff");
		
		user.setSfid(staff.getId());
		user.setSfaid(staff.getStleader());
		int res;
		if (staff.getRoleid() == 2) {
			user.setSfid(staff.getId());
			user.setSfaid(staff.getId());
			res = iUserService.addUser(user);
		}else {
			user.setSfid(staff.getId());
			user.setSfaid(staff.getStleader());
			res = iUserService.addUser(user);
		}

		
		ResponseResult result = new ResponseResult();
		
		if(res > 0) {
			result.setCode(2);
			result.setMsg("添加成功");
		}else {
			result.setCode(-2);
			result.setMsg("添加失败");
		}
		
		return result;
	}
	@RequestMapping("User/returnview.action")
	public String returnview() {
		return "WEB-INF/views/returnview";
	}
}
