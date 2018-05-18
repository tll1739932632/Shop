package com.lulu.service;

import org.apache.ibatis.annotations.Param;

import com.lulu.model.User;

public interface IUserService {

	public User getByUserName(String username);
	
	public int addUser(User user);
	
	public int  activeUser(String code);
	
	//登陆用户，查询用户的state是否激活
	public User getUserName(String username);
	
	//登陆用户，查询用户和密码是否匹配
	public User getUsernameAndPassword(@Param("username")String username,
									   @Param("password")String password);
	
	
	//根据用户名更新密码
	public int updatePwdByUsername(@Param("username")String username,
				   					   @Param("password")String password);
}
