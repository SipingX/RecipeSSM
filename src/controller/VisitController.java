package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/*
 * 访问页面控制器
 */
@Controller
@RequestMapping("/visit")
public class VisitController {
	
	// 访问登录注册页面
	@RequestMapping("/login")
	public String login() {
		System.out.println("经过 /visit/login");
		return "login";
	}
	
	// 访问用户主页面
	@RequestMapping("/user")
	public String user() {
		System.out.println("经过 /visit/user");
		return "user";
	}
	
	// 访问主页面
	@RequestMapping("/index")
	public String index() {
		System.out.println("经过/visit/index");
		return "forward:/recipe/initIndex.action";
	}
	
	// 访问食谱详细页面
	@RequestMapping("/recipe_page")
	public String recipe_page() {
		System.out.println("经过/visit/recipe_page");
		return "forward:/recipe/getRecipeInfo.action";
	}
	
	// 访问食谱上传页面
	@RequestMapping("/recipe_upload")
	public String recipe_upload() {
		System.out.println("经过/visit/recipe_upload");
		return "recipe_upload";
	}
	
	// 访问食谱页面
	@RequestMapping("/recipe")
	public String recipe() {
		System.out.println("经过/visit/recipe");
		return "forward:/recipe/initRecipe.action";
	}
	
	// 访问联系页面
	@RequestMapping("/contact")
	public String contact() {
		System.out.println("经过/visit/contact");
		return "contact";
	}
	
	// 访问食材组页面
	@RequestMapping("/material_group")
	public String material_group() {
		System.out.println("经过/visit/material_group");
		return "material_group";
	}
	
	// 访问食材详细页面
	@RequestMapping("/material_page")
	public String material_page() {
		System.out.println("经过/visit/material_page");
		return "material_page";
	}
	
	// 访问食材页面
	@RequestMapping("/material")
	public String material() {
		System.out.println("经过/visit/material");
		return "material";
	}
	
	// 访问食谱导航页面
	@RequestMapping("/navigation")
	public String navigation() {
		System.out.println("经过/visit/navigation");
		return "navigation";
	}
	
	// 访问产品详细页面
	@RequestMapping("/product_page")
	public String product_page() {
		System.out.println("经过/visit/product_page");
		return "product_page";
	}
	
	// 访问购物页面
	@RequestMapping("/shop")
	public String shop() {
		System.out.println("经过/visit/shop");
		return "shop";
	}
	
	// 访问食谱管理页面
	@RequestMapping("/recipe_manage")
	public String recipe_manage() {
		System.out.println("经过/visit/recipe_manage");
		return "forward:/recipe/manageRecipe.action";
	}
	
}
