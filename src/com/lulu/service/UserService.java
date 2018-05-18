package com.lulu.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lulu.dao.UserMapper;
import com.lulu.model.User;

@Service
@Transactional
public class UserService implements IUserService {
	
	@Resource//自动注入  属于java容器 不是spring的注解 默认按照name来注入
	UserMapper userMapper;

	@Override
	public User getByUserName(String username) {
		
		return userMapper.getByUserName(username);
	}

	@Override
	public int addUser(User user) {
		
		return userMapper.addUser(user);
	}

	@Override
	public int activeUser(String code) {
		
		return userMapper.activeUser(code);
	}

	@Override
	public User getUserName(String username) {
		
		return userMapper.getUserName(username);
	}

	@Override
	public User getUsernameAndPassword(String username, String password) {
		
		return userMapper.getUsernameAndPassword(username, password);
	}

	@Override
	public int updatePwdByUsername(String username, String password) {
		
		return userMapper.updatePwdByUsername(username, password);
	}


}
