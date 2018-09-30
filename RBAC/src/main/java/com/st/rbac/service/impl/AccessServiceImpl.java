package com.st.rbac.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.AccessMapper;
import com.st.rbac.pojo.Access;
import com.st.rbac.service.IAccessService;

@Service 
public class AccessServiceImpl implements IAccessService {
	
	@Autowired
	AccessMapper accessMapper;
	
	@Override
	public Map<String, String> selectByRoleid(Integer roleid) {
		
		List<Access> accesses = accessMapper.selectByRoleid(roleid);
		Map<String, String> map = new HashMap<>();
		//通过List 生成一个Map
		for (Access access : accesses) {
			System.out.println(access.getUrl());
			System.out.println(access.getUrlname());
			map.put(access.getUrl(), access.getUrlname());
		}
		
		return map;
	}
	
}
