package com.st.service;

import com.st.pojo.User;

public interface IUserService {

	User login(User user);

	int register(User user, String password2);

}
