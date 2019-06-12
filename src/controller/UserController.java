package controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;

import pojo.User;
import service.UserService;
/*
 * 用户控制器类
 */
@Controller
@RequestMapping("/user")
public class UserController {
	// 依赖注入
	@Autowired
	private UserService userService;
	
	/*
	 * 用户登录
	 */
	@RequestMapping(value="/login.action", method=RequestMethod.POST)
	public String login(@RequestParam(value="userId")String id, @RequestParam(value="userPsd")String password, Model model, HttpSession session) {
		User user = userService.getUser(id);
		if(user != null) {
			if(user.getPassword().equals(password)) {
				session.setAttribute("user", user);
				return "redirect:/visit/index";
			}else {
				model.addAttribute("msg", "密码错误，请重新输入！");
				return "login";
			}
		}else {
			model.addAttribute("msg", "该账号不存在，请先进行注册！");
			return "login";
		}
	}
	
	@RequestMapping("/logout.action")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "login";
	}
	
	@PostMapping("/register.action")
	public String register(String vali, String userId_2, String userPsd, Model model, HttpSession session){
		User user = new User();
		int rs = 0;
		
		if(vali.equals(session.getAttribute("valiNum"))){
			System.out.println("号码验证通过！");
			
			user.setId(userId_2.trim());
			user.setPassword(userPsd.trim());
			System.out.println("注册用户ID："+user.getId()+"  密码："+user.getPassword());
			
			rs = userService.register(user);
			if(rs == 1) {
				model.addAttribute("msg", "注册成功，请登录！");
				return "login";
			}else {
				model.addAttribute("msg", "注册失败！");
				return "login";
			}
		}else{
			model.addAttribute("msg", "号码验证失败！");
			return "login";
		}
	}
	
	@GetMapping("/manageUser.action")
	public String manageUser(HttpServletRequest request, Model model) {
		int page = 1;
		if(request.getParameter("page") != null) 
			page = Integer.parseInt(request.getParameter("page"));
		int pagesize = 2;
		int pagecount = 0;
		User users[] = new User[2];
		
		PageInfo<User> pageInfo = new PageInfo<User>();
		
		try {
			pageInfo = userService.getUserList(page, pagesize);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		page = pageInfo.getPageNum();
		pagecount = pageInfo.getPages();
		List<User> userlist = pageInfo.getList();
		Iterator<User> user = userlist.iterator();
		// 将列表转换为数组
		int i = 0;
		while(user.hasNext()) {
			users[i] = user.next();
		}
		// 传递总页数及当前页至user.jsp页面
		model.addAttribute("page", page);
		model.addAttribute("userlist", userlist);
		model.addAttribute("pagecount",pagecount);

		return "user_manage";
	}
	
}
