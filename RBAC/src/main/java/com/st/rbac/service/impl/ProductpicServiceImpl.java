package com.st.rbac.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.ProductpicMapper;
import com.st.rbac.pojo.Productpic;
import com.st.rbac.service.IProductpicService;
	
@Service
public class ProductpicServiceImpl implements IProductpicService {
	
	@Autowired
	ProductpicMapper productpicMapper;
	
	@Override
	public int insertBatch(String[] pics, Integer picture) {
		
		return productpicMapper.insertBatch(pics, picture);
	}

	@Override
	public List<Productpic> selectPic(Integer prdid) {
		// TODO Auto-generated method stub
		return productpicMapper.selectPic(prdid);
	}

	@Override
	public int deletepic(Productpic productpic) {
		
		return productpicMapper.deletepic(productpic);
	}


}
