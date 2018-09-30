package com.st.rbac.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.ReturnuserMapper;
import com.st.rbac.pojo.Returnuser;
import com.st.rbac.service.IReturnuserService;
import com.st.rbac.util.Page;

@Service
public class ReturnuserServiceImpl implements IReturnuserService {

	@Autowired
	ReturnuserMapper returnuserMapper;
	
	@Override
	public Integer selectRows(Returnuser returnuser, String uname) {
		// TODO Auto-generated method stub
		return returnuserMapper.selectRows(returnuser,uname);
	}

	@Override
	public List<HashMap<String, Object>> selectReturn(Page page2, Returnuser returnuser, String uname) {
		// TODO Auto-generated method stub
		return returnuserMapper.selectReturn(page2,returnuser, uname);
	}

	@Override
	public Integer xiugaihuifang(Returnuser returnuser) {
		// TODO Auto-generated method stub
		return returnuserMapper.xiugaihuifang(returnuser);
	}

}
