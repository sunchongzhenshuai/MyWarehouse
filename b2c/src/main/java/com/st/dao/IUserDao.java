package com.st.dao;

import java.util.List;

import com.st.pojo.User;

public interface IUserDao {
	User login(User user);

	List<User> selectUserName(User user);

	int register(User user);
}
