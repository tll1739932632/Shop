package com.lulu.dao;



import org.apache.ibatis.annotations.Param;

import com.lulu.model.User;

public interface UserMapper {


	//根据用户名查询 是否存在该用户
	public User getByUserName(String username);
	
	//根据email查询
	
	//根据表单数据内容，添加用户信息
	public int addUser(User user);
	
	//更新用户的激活状态
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
