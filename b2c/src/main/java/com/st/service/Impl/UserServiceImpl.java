package com.st.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.IUserDao;
import com.st.pojo.User;
import com.st.service.IUserService;

@Service
public class UserServiceImpl implements IUserService{
	
	@Autowired
	private IUserDao iUserDao;

	@Override
	public User login(User user) {
		//用户登录
		return iUserDao.login(user);
	}

	@Override
	public int register(User user, String password2) {
		
		//判断密码是否为空
		if ("".equals(user.getPassword()) && "".equals(password2)) {
			return -200;
		}else {
			
			//查询账号是否已存在
			List<User> list = iUserDao.selectUserName(user);
			//判断账号是否已存在
			if (list != null) {
				//判断两次密码是否相同
				if (password2.equals(user.getPassword())) {
					//向数据库储存用户信息
					System.out.println("123");
					int res = iUserDao.register(user);
					return res;	
				}else {
					//两次密码输入不一致
					return -100;
				}
			} else {
				//账号已存在
				return -300;
			}
		}
		
	}

}
