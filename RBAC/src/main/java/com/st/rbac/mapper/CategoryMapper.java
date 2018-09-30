package com.st.rbac.mapper;

import java.util.List;
import java.util.Map;

import com.st.rbac.pojo.Category;
import com.st.rbac.util.Page;

public interface CategoryMapper {
	List<Category> getDclass();

	List<Category> getXclass(Integer cid);

	List<Map<String, Object>> selectsales();

	void addsalesv(Integer id, Double sellprice2);

	Integer getRow(Category category);

	List<Category> selectClass(Page page2, Category category);

	Integer modifyClassview(Category category);

	Integer deleteClass(Integer id);
	
	Integer addClass(Category category);

	
	//Category selectcname(String cname);
}
