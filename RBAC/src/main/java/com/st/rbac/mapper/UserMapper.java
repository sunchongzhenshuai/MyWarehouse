package com.st.rbac.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.st.rbac.pojo.User;
import com.st.rbac.util.Page;

public interface UserMapper {
	
	Integer getRows(User user);
	
	List<HashMap<String, Object>> selectuser(Page page2, User user);

	int adduser(User user);

	int addUser(User user);

	List<Map<String, Object>> getuser(Integer sfaid);

	Integer modifyuser(User user);
}
