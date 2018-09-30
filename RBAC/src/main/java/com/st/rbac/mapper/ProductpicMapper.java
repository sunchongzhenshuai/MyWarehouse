package com.st.rbac.mapper;

import java.util.List;

import com.st.rbac.pojo.Productpic;

public interface ProductpicMapper {
	int insertBatch(String[] pics, Integer picture);

	List<Productpic> selectPic(Integer prdid);

	int deletepic(Productpic productpic);
	
}
