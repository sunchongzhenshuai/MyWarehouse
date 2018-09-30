package com.st.rbac.mapper;

import java.util.List;

import com.st.rbac.pojo.Product;
import com.st.rbac.util.Page;

public interface ProductMapper {
	List<Product> selectprod(Page page2, Product product2);

	Integer getRows(Page page2, Product product2);

	int deleteprod(Integer id);

	int modifyduct(Product product);

	int prodadd(Product product);

	Product selectprodByid(Integer pid);

	void reducecount(Integer pid, Integer sellcount);

	void addxiaoliang(Integer pid, Integer sellprice2);

}
