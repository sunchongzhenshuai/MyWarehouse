package com.st.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.ProductMapper;
import com.st.rbac.pojo.Product;
import com.st.rbac.service.IProductService;
import com.st.rbac.util.Page;

@Service
public class ProductServiceImpl implements IProductService {
	
	@Autowired
	ProductMapper productMApper;
	
	@Override
	public List<Product> selectprod(Page page2,Product producr2) {
		
		return productMApper.selectprod(page2, producr2);
	}

	@Override
	public Integer getRows(Page page2, Product product2) {
		
		return productMApper.getRows(page2,product2);
	}

	@Override
	public int delectprod(Integer id) {
		
		return productMApper.deleteprod(id);
	}

	@Override
	public int modifyduct(Product product) {
		
		return productMApper.modifyduct(product);
	}

	@Override
	public int prodadd(Product product) {
		
		return productMApper.prodadd(product);
	}

}
