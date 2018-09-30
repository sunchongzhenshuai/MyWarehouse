package com.st.rbac.mapper;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.st.rbac.pojo.Sell;
import com.st.rbac.util.Page;

public interface SellMapper {
	List<HashMap<String, Object>> selectsell(Page page2, Sell sell);

	Integer getRows(Sell sell);

	List<Sell> timeselect(Date date, Date date2);

	int addsell(Sell sell);
}
