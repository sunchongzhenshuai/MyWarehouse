package com.st.rbac.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.StaffMapper;
import com.st.rbac.pojo.Staff;
import com.st.rbac.pojo.User;
import com.st.rbac.service.IStaffService;
import com.st.rbac.util.Page;

@Service
public class StaffServiceImpl implements IStaffService {
	
	@Autowired
	StaffMapper staffMapper;
	
	//登录
	@Override
	public Staff login(Staff staff) {
		
		return staffMapper.login(staff);
	}

	@Override
	public List<HashMap<String, Object>> selectStaff(Page page2,Staff staff) {
		// TODO Auto-generated method stub
		return staffMapper.selectStaff(page2,staff);
	}

	@Override
	public Integer getRows(Staff staff) {
		// TODO Auto-generated method stub
		return staffMapper.getRows(staff);
	}

	@Override
	public Integer addStaff(Staff staff) {
		// TODO Auto-generated method stub
		return staffMapper.addStaff(staff);
	}

}
