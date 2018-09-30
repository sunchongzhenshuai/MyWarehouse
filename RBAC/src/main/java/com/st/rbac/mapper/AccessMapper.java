package com.st.rbac.mapper;

import java.util.List;

import com.st.rbac.pojo.Access;

public interface AccessMapper {
	
	List<Access> selectByRoleid(Integer roleid);
	
}
