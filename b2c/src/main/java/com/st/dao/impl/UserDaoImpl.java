package com.st.dao.impl;

import java.util.List;



import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.st.dao.IUserDao;
import com.st.pojo.User;

@Repository //表示持久层的Bean
public class UserDaoImpl implements IUserDao {
	
	@Autowired
	private HibernateTemplate template;
	
	//用户登录
	@Override
	public User login(User user) {
		//查询数据库 登录操作
		System.out.println(user.getUsername());
		System.out.println(user.getPassword());
		String hql = "FROM User where username=? and password = ?";
		Object[] params = {user.getUsername(),user.getPassword()};
		List<User> list = (List<User>) template.find(hql, params);
		
		if (list != null && list.size() > 0) {
			System.out.println();
			return list.get(0);
		}else {
			return null;
		}
	}
	
	//根据账号查询用户
	@Override
	public List<User> selectUserName(User user) {
		System.out.println(user.getUsername());
		String hql = "FROM User where username=?";
		Object params = user.getUsername();
		List<User> list = (List<User>) template.find(hql, params);
		
		return list;
	}
	
	//注册
	@Override
	public int register(User user) {
		
		Integer res = (Integer) template.save(user);
		
		System.out.println(res);
		
		return res;
	}

}
