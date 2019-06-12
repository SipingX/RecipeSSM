package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import mapper.UserMapper;
import pojo.User;
import pojo.UserExample;
import service.UserService;
/*
 * 用户 Service 接口实现类
 */
@Service("userService")
@Transactional // 使用了 @Transactional注解来标识类中的所有方法都纳入 Spring 的事务管理
/* 小提示：@Transactional 注解主要是针对数据的增加、修改、删除进行事务管理，该类中
的查询方法并未使用该注解，此处的作用就是告知读者该注解在实际开发中应该如何使用。 */
public class UserServiceImpl implements UserService {
	// 注入 UserDao
	@Autowired
	private UserMapper mapper;

	@Override
	public int register(User user) {
		// TODO Auto-generated method stub
		return this.mapper.insertSelective(user);
	}

	@Override
	public User getUser(String id) {
		// TODO Auto-generated method stub
		User user = this.mapper.selectByPrimaryKey(id);
		user.setPortrait("/RecipeSSM/" + user.getPortrait());
		return user;
	}

	@Override
	public PageInfo<User> getUserList(int page, int pagesize) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, pagesize);
		UserExample userExample = new UserExample();
		List<User> users = this.mapper.selectByExample(userExample);
		PageInfo<User> pageInfo = new PageInfo<User>(users);
		return pageInfo;
	}

}
