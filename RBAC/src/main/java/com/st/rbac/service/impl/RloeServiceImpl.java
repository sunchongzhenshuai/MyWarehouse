package com.st.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.RoleMapper;
import com.st.rbac.pojo.Role;
import com.st.rbac.service.IRoleService;

@Service
public class RloeServiceImpl implements IRoleService{
	
	@Autowired
	RoleMapper roleMapper;
	
	@Override
	public List<Role> selectRole() {
		// TODO Auto-generated method stub
		return roleMapper.selectRole();
	}

}
