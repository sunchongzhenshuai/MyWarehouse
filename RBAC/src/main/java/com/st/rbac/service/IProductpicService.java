package com.st.rbac.service;

import java.util.List;

import com.st.rbac.pojo.Productpic;

public interface IProductpicService {
	int insertBatch(String[] pics, Integer picture);

	List<Productpic> selectPic(Integer prdid);

	int deletepic(Productpic productpic);
}
