package com.st.rbac.mapper;

import java.util.List;

import com.st.rbac.pojo.Menu;
import com.st.rbac.pojo.Staff;


public interface MenuMapper {
	
	List<Menu> selectRole(Staff staff2);
}
