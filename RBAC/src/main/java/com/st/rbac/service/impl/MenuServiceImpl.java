package com.st.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.MenuMapper;
import com.st.rbac.pojo.Menu;
import com.st.rbac.pojo.Staff;
import com.st.rbac.service.IMenuService;

@Service
public class MenuServiceImpl implements IMenuService {
	
	@Autowired
	MenuMapper menuMapper;
	
	@Override
	public List<Menu> selectRole(Staff staff2) {
		
		
		return menuMapper.selectRole(staff2);
	}

}
