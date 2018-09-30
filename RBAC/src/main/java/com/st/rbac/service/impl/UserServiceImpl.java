package com.st.rbac.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.UserMapper;
import com.st.rbac.pojo.Returnuser;
import com.st.rbac.pojo.User;
import com.st.rbac.service.IUserService;
import com.st.rbac.util.Page;

@Service
public class UserServiceImpl implements IUserService {

	
	@Autowired
	UserMapper userMapper;
	
	@Override
	public List<HashMap<String, Object>> selectuser(Page page2,User user) {
		
		return userMapper.selectuser(page2,user);
	}

	@Override
	public Integer getRows(User user) {
		
		return userMapper.getRows(user);
	}

	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return userMapper.addUser(user);
	}

	@Override
	public List<Map<String, Object>> getuser(Integer sfaid) {
		// TODO Auto-generated method stub
		return userMapper.getuser(sfaid);
	}

	@Override
	public Integer modifyuser(User user) {
		// TODO Auto-generated method stub
		return userMapper.modifyuser(user);
	}

}
