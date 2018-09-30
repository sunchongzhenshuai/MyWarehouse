package com.st.rbac.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.CategoryMapper;
import com.st.rbac.pojo.Category;
import com.st.rbac.service.ICategoryService;
import com.st.rbac.util.Page;

@Service
public class CategoryServiceImpl implements ICategoryService {

	@Autowired
	CategoryMapper categoryMapper;
	
	@Override
	public List<Category> getDclass() {
		
		return categoryMapper.getDclass();
	}

	@Override
	public List<Category> getXclass(Integer cid) {
		// TODO Auto-generated method stub
		return categoryMapper.getXclass(cid);
	}

	@Override
	public List<Map<String, Object>> selectsales() {
		
/*		List<Category> categories = categoryMapper.selectsales(cid);
		
		List<Map<String, Object>> maps = new ArrayList<>();
		
		for (Category category : categories) {
			
			Map<String, Object> map = new HashMap<>();
			map.put(category.getCname(), category.getSalesv());
			
			maps.add(map);
		}*/
		
		return  categoryMapper.selectsales();
	}

	@Override
	public List<Category> selectClass(Page page2, Category category) {
		// TODO Auto-generated method stub
		return categoryMapper.selectClass(page2,category);
	}

	@Override
	public Integer getRow(Category category) {
		// TODO Auto-generated method stub
		return categoryMapper.getRow(category);
	}

	@Override
	public Integer modifyClassview(Category category) {
		// TODO Auto-generated method stub
		return categoryMapper.modifyClassview(category);
	}

	@Override
	public Integer deleteClass(Integer id) {
		// TODO Auto-generated method stub
		return categoryMapper.deleteClass(id);
	}

	@Override
	public Integer addClass(Category category) {
		// TODO Auto-generated method stub
		return categoryMapper.addClass(category);
	}


	/*@Override
	public Category selectcname(String cname) {
		// TODO Auto-generated method stub
		return categoryMapper.selectcname(cname);
	}*/

}
