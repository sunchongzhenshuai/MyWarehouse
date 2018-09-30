package com.st.rbac.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.rbac.pojo.Category;
import com.st.rbac.pojo.ResponseResult;
import com.st.rbac.service.ICategoryService;
import com.st.rbac.util.Page;

@Controller
public class CategoryController {

	@Autowired
	ICategoryService iCategoryService;
	
	@RequestMapping("/Category/categoryview.action")
	public String categoryview() {
		return "WEB-INF/views/categoryview";
	}
	
	@RequestMapping("role/Category/addcategoryview.action")
	public String addcategory() {
		return "WEB-INF/views/addcategoryview";
	}
	
	@RequestMapping("/Category/lookXclass.action")
	public String lookXclass() {
		return "WEB-INF/views/lookXclass";
	}
	
	@RequestMapping("role/Category/modifyClassview")
	public String modifyClassview() {
		return "WEB-INF/views/modifyClassview";
	}
	
	@RequestMapping("/Category/getDclass.action")
	@ResponseBody
	public List<Category> getDclass(){
		
		List<Category> list = iCategoryService.getDclass();
		
		return list;
		
	}
	@RequestMapping("role/Category/modifyClass.action")
	@ResponseBody
	public ResponseResult modifyClassview(Category category) {
		
		Integer res = iCategoryService.modifyClassview(category);
		
		ResponseResult result = new ResponseResult();
		if (res > 0) {
			result.setCode(1);
			result.setMsg("修改成功!");
		}else {
			result.setCode(-2);
			result.setMsg("修改失败!");
		}

		return result;
	}
	
	@RequestMapping("role/Category/deleteClass.action")
	@ResponseBody
	public ResponseResult deleteClass(Integer id){
		
		Integer res = iCategoryService.deleteClass(id);
		
		ResponseResult result = new ResponseResult();
		
		if (res > 0 ) {
			result.setCode(1);
			result.setMsg("删除成功");
		}else {
			result.setCode(-1);
			result.setMsg("删除失败");
		}
		
		return result;
	}
	
	@RequestMapping("role/Category/addClass.action")
	@ResponseBody
	public ResponseResult addClass(Category category) {
		
		Integer res = iCategoryService.addClass(category);
		
		ResponseResult result = new ResponseResult();
		
		if (res > 0) {
			result.setCode(1);
			result.setMsg("添加成功!");
		}else {
			result.setCode(-1);
			result.setMsg("添加失败!");
		}

		
		return result;
	}
	
	@RequestMapping("/Category/selectClass.action")
	@ResponseBody
	public ResponseResult selectClass(Integer limit, Integer page, Category category){
		
		Page page2 = new Page();
		
		page2.setPagerows(limit);
		page2.setCurpage(page);
		System.out.println(category.getCname());
		List<Category> list = iCategoryService.selectClass(page2,category);
		
		Integer count = iCategoryService.getRow(category);
		
		ResponseResult result = new ResponseResult();
		
		result.setCount(count);
		result.setData(list);
		result.setMsg("");
		result.setCode(0);
		return result;
		
	}
	
	@RequestMapping("/Category/getXclass.action")
	@ResponseBody
	public List<Category> getXclass(Integer cid){
		
		List<Category> list = iCategoryService.getXclass(cid);
		
		return list;
		
	}
	@RequestMapping("/Category/selectsales.action")
	@ResponseBody
	public List<Map<String, Object>> selectsales(){
		
		
		List<Map<String, Object>> list = iCategoryService.selectsales();
		
		return list;
	}
/*	@RequestMapping("/Category/selectX.action")
	@ResponseBody
	public List<Map<String, Object>> selectX(String cname){
		
		System.out.println(cname);
		
		Category category = iCategoryService.selectcname(cname);
		
		List<Map<String, Object>> select
		
		return null;
	}*/
}
