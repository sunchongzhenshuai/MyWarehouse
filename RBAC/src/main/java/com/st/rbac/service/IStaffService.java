package com.st.rbac.service;
import java.util.HashMap;
import java.util.List;

import com.st.rbac.pojo.Staff;
import com.st.rbac.pojo.User;
import com.st.rbac.util.Page;

public interface IStaffService {
	//登录
	Staff login(Staff staff);

	List<HashMap<String, Object>> selectStaff(Page page2,Staff staff);

	Integer getRows(Staff staff);

	Integer addStaff(Staff staff);
}
