package com.st.rbac.service;

import java.util.Map;


public interface IAccessService {
	Map<String, String> selectByRoleid(Integer roleid);
}
