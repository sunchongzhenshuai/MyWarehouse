package com.st.rbac.service;

import java.util.List;

import com.st.rbac.pojo.Menu;
import com.st.rbac.pojo.Staff;

public interface IMenuService {
	List<Menu> selectRole(Staff staff2);
}
