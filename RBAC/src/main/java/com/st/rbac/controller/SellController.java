package com.st.rbac.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;
import com.st.rbac.pojo.ResponseResult;
import com.st.rbac.pojo.Sell;
import com.st.rbac.pojo.Staff;
import com.st.rbac.pojo.User;
import com.st.rbac.service.ISellService;
import com.st.rbac.util.Page;

@Controller
public class SellController {
	
	@Autowired
	ISellService iSellService;
	
	@RequestMapping("role/Sell/addsellview.action")
	public String addsellview() {
		return "WEB-INF/views/addsellview";
	}
	@RequestMapping("/Sell/sellList.action")
	public String sellList() {
		return "WEB-INF/views/sellList";
	}
	@RequestMapping("/Sell/countpic.action")
	public String countpic() {
		return "WEB-INF/views/xiaoshoutongji";
	}
	
	@RequestMapping("/Sell/selectsell.action")
	@ResponseBody
	public ResponseResult selectsell(Integer limit, Integer page,Sell sell, HttpSession session) {
		
		Page page2 = new Page();
		page2.setPagerows(limit);
		page2.setCurpage(page);
		System.out.println(sell.getPid());
		System.out.println(sell.getStaffid());
		
		Staff staff = (Staff) session.getAttribute("staff");
		
		List<HashMap<String, Object>> list;
		Integer count;
		if(staff.getRoleid() == 2) {
			sell.setStafid(staff.getId());
			list = iSellService.selectsell(page2,sell);
			
			count = iSellService.getRows(sell);
		} else if(staff.getRoleid() == 3){
			sell.setStaffid(staff.getId());
			list = iSellService.selectsell(page2,sell);
			
			count = iSellService.getRows(sell);
		}else {
			
			list = iSellService.selectsell(page2,sell);
			
			count = iSellService.getRows(sell);
		}
		
		ResponseResult result = new ResponseResult();
		
		System.out.println(count);
		result.setCode(0);
		result.setCount(count);
		result.setData(list);
		result.setMsg("xxx");
		
		return result;
		
	}
	
	@RequestMapping("/Sell/timeselect.action")
	@ResponseBody
	public List<Sell> timeselect(String beginning,String end){
		
		System.out.println(beginning);
		System.out.println(end);
		
		SimpleDateFormat aDate= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = null;
		Date date2 = null;
	
		if (beginning != null && end != null) {
			
			try {
				date = aDate.parse(beginning);
				date2 = aDate.parse(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return iSellService.timeselect(date,date2);
	}
	
	@RequestMapping("role/Sell/addSell.action")
	@ResponseBody
	public ResponseResult addSell(Sell sell, User user, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Staff staff = (Staff) session.getAttribute("staff");
		
		sell.setStaffid(staff.getId());
		
		if (staff.getRoleid() == 2) {
			sell.setStafid(staff.getId());
			user.setSfaid(staff.getId());
		}else {
			sell.setStafid(staff.getStleader());
			user.setSfaid(staff.getStleader());
		}
		user.setSfid(staff.getId());
		user.setLikeclass(sell.getDclassid());
		user.setLikeprod(sell.getPid());
		user.setLikestate("已购买");
		//添加销售订单
		ResponseResult result = new ResponseResult();
		int res;
		try {
			res = iSellService.addSell(sell,user);
			
			result.setCode(1);
			result.setMsg("添加成功!");
		} catch (Exception e) {
			// TODO: handle exception
			//向客户端返回错误信息
			result.setCode(-1);
			result.setMsg(e.getMessage());
		}
		
		return result;
	}
	
}
