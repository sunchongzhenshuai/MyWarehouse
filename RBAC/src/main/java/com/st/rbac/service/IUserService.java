package com.st.rbac.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.st.rbac.pojo.Returnuser;
import com.st.rbac.pojo.User;
import com.st.rbac.util.Page;

public interface IUserService {
	List<HashMap<String, Object>> selectuser(Page page2, User user);

	Integer getRows(User user);

	int addUser(User user);

	List<Map<String, Object>> getuser(Integer staid);

	Integer modifyuser(User user);

}
