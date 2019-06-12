package service;

import com.github.pagehelper.PageInfo;

import pojo.User;

/*
 * 用户 Service 层接口
 */
public interface UserService {

	// 注册用户
	public int register(User user);
	
	// 通过用户 ID 获取用户信息
	public User getUser(String id);
	
	// 分页获取用户信息
	public PageInfo<User> getUserList(int page,int pagesize);
	
}
