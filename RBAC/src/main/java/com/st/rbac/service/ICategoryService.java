package com.st.rbac.service;

import java.util.List;
import java.util.Map;

import com.st.rbac.pojo.Category;
import com.st.rbac.util.Page;

public interface ICategoryService {
	List<Category> getDclass();

	List<Category> getXclass(Integer cid);

	List<Map<String, Object>> selectsales();

	List<Category> selectClass(Page page2, Category category);

	Integer getRow(Category category);

	Integer modifyClassview(Category category);

	Integer deleteClass(Integer id);

	Integer addClass(Category category);

	//Category selectcname(String cname);
}
