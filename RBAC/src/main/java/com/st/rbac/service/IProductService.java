package com.st.rbac.service;

import java.util.List;

import com.st.rbac.pojo.Product;
import com.st.rbac.util.Page;

public interface IProductService {

	List<Product> selectprod(Page page2, Product product2);

	Integer getRows(Page page2, Product product2);

	int delectprod(Integer id);

	int modifyduct(Product product);

	int prodadd(Product product);
}
