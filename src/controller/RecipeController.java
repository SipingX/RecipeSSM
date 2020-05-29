package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageInfo;

import net.sf.json.JSONArray;
import pojo.Include;
import pojo.Material;
import pojo.RPicture;
import pojo.Recipe;
import pojo.Step;
import pojo.User;
import service.IncludeService;
import service.MaterialService;
import service.PictureService;
import service.RecipeService;
import service.StepService;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	// 依赖注入 
	@Autowired  //(实践：必须对每一个成员变量加上 @Autowired,否则报错（空指针异常）：sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method))
	private RecipeService recipeService;
	@Autowired
	private PictureService pictureService;
	@Autowired
	private IncludeService includeService;
	@Autowired
	private StepService stepService;
	@Autowired
	private MaterialService materialService;
	
	/*
	 * 初始化主页
	 */
	@GetMapping("/initIndex.action")
	public String initIndex(HttpServletRequest request) {
	// 获取推荐食谱
		List<Recipe> recipes_rec = new ArrayList<Recipe>();
		List<List<RPicture>> pictures_rec = new ArrayList<List<RPicture>>();
		
		for(int i=1;i<=5;i++) {
			Recipe recipe = new Recipe();
			recipe = recipeService.getRecipeInfoById(i);
			
			recipes_rec.add(recipe);
			pictures_rec.add(pictureService.getPictures(recipe.getId()));
		}
		
	// 分页食谱
		int page=1;
		int pagesize = 6;
		int pagecount = 0;
		List<Recipe> recipes_page = new ArrayList<Recipe>();
		List<List<RPicture>> pictures_page = new ArrayList<List<RPicture>>();
		
		//读取客户端传递过来的要显示的页码
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		PageInfo<Recipe> pageInfo = new PageInfo<Recipe>();
		
		try {
			pageInfo = recipeService.getRecipeList(page, pagesize);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		page = pageInfo.getPageNum();
		pagecount = pageInfo.getPages();
		recipes_page = pageInfo.getList();
		
		// 亦可直接用recipes_page.size()获取其大小进行遍历
		Iterator<Recipe> recipes_pageIterator = recipes_page.iterator();
		while(recipes_pageIterator.hasNext()) {
			// while 一次循环中，迭代器只能用一次 next 方法，否则第二个 next 将取下一个对象
//			System.out.println("------分页食谱:"+recipes_pageIterator.next().toString()); 
			
			pictures_page.add(pictureService.getPictures(recipes_pageIterator.next().getId()));
		}
		
	// 获取最新食谱
		if(page == 1) {
			List<Recipe> recipes_lat = new ArrayList<Recipe>();
			List<List<RPicture>> pictures_lat = new ArrayList<List<RPicture>>();
			int maxId = recipeService.getMaxId();
			
			int ii = 0;
			for(int i=0;i<3;) {
				Recipe recipe = new Recipe();
				recipe = recipeService.getRecipeInfoById(maxId-ii);
				if(recipe != null) {
					recipes_lat.add(recipe);
					pictures_lat.add(pictureService.getPictures(recipe.getId()));
					i++;
				}
				ii++;
			}
			
			request.setAttribute("recipes_latest", recipes_lat);
			request.setAttribute("pictures_latest", pictures_lat);
		}
		
		request.setAttribute("recipes_recommended", recipes_rec);
		request.setAttribute("pictures_recommended", pictures_rec);
		
		// 传递总页数及当前页至index.jsp页面
		request.setAttribute("page", page);
		request.setAttribute("pagecount",pagecount);
		request.setAttribute("recipes_page", recipes_page);
		request.setAttribute("pictures_page", pictures_page);
		
		return "index";
	}

	/*
	 * 删除食谱
	 */
	@GetMapping("/deleteRecipe.action")
	public String deleteRecipe(HttpServletRequest request) {
		int recipeId = Integer.parseInt(request.getParameter("recipeId"));
		if(recipeId >= 1 && recipeId <= 10) {
			System.out.println("RecipeController.deleteRecipe():不能删除该食谱！");
			request.setAttribute("msg", "不能删除该食谱！");
			return "forward:/recipe/manageRecipe.action";
		}
		boolean bool = recipeService.delete(recipeId);
		if(bool) {
			return "forward:/recipe/manageRecipe.action";
		}else {
			return "forward:/recipe/manageRecipe.action";
		}
	}
	
	/*
	 * 获取食谱详细信息
	 */
	@GetMapping("/getRecipeInfo.action")
	public String getRecipeInfo(HttpServletRequest request) {
		Recipe recipe = new Recipe();
		recipe.setId(Integer.parseInt(request.getParameter("recipeId")));
//		System.out.println("RecipeController:/visit/getRecipeInfo:请求食谱Id："+recipe.getId());
		recipe = recipeService.getRecipeInfoById(recipe.getId());
		
		List<Include> includeList = includeService.getInclude(recipe.getId());
		Iterator<Include> includes = includeList.iterator();
		
		Iterator<Step> steps = stepService.getStep(recipe.getId()).iterator();
		
		Iterator<RPicture> pictures = pictureService.getPictures(recipe.getId()).iterator();
		
		List<Material> materialList = new ArrayList<Material>();
		Iterator<Include> includeIte = includeList.iterator();
		while(includeIte.hasNext()) {
			Material material = new Material();
		    material = materialService.getMaterial(includeIte.next().getMaterial());
		    materialList.add(material);
		}	
		Iterator<Material> materials = materialList.iterator();
	
		request.setAttribute("recipe", recipe);
		request.setAttribute("include", includes);
		request.setAttribute("material", materials);
		request.setAttribute("step", steps);
		request.setAttribute("picture", pictures);
		
		return "recipe_page";
	}
	
	/*
	 * 上传食谱
	 */
	@PostMapping("/uploadRecipe.action")
	public void uploadRecipe(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		
		int result = 0;
		
		Recipe recipe = new Recipe();
		recipe.setId(recipeService.initiateOneRecipe());
		if(recipe.getId() == 0) {
			System.out.println("上传食谱初始化失败!");
			String html = "上传食谱初始化失败！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
			response.getWriter().write(html);
			return;
		}
		
		List<Step> steps = new ArrayList<Step>();
		
		List<String> materials = new ArrayList<String>();
		List<String> Mquantities = new ArrayList<String>();
		
		List<String> picUrls = new ArrayList<String>();
		
		//上传图片
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart) {//判断前台的form是否有multipart属性
//			FileItemFactory factory = new DiskFileItemFactory();
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			//通过parseRequest解析form中的所有请求字段，并保存到items集合中
			try {
				//设置上传文件时用到的临时文件的大小DiskFileItemFactory
				factory.setSizeThreshold(10485760);//设置临时文件缓冲区大小为10MB(单位为字节B)
				factory.setRepository(new File("D:\\Course\\Java\\workplace\\RecipeSSM\\uploadtemp"));//设置临时文件的目录
				
				//控制上传单个文件的大小  此处为100MB
				upload.setSizeMax(104857600);
				
				List<FileItem> items = upload.parseRequest(request);
				//遍历items中的数据(item=XXX)
				Iterator<FileItem> iter = items.iterator();
				int picNo = 0;
				while(iter.hasNext()) {
					FileItem item = iter.next();
					String itemName = item.getFieldName();
					//判断前台字段，是普通form表单字段，还是文件字段
					
					//request.getParameter()   --iter.getString
					if(item.isFormField()) {//普通form表单字段上传
						if(itemName.equals("recipe_name")) {
							recipe.setName(item.getString("utf-8"));
						}else if(itemName.equals("category")) {
							recipe.setCategory(item.getString("utf-8"));
						}else if(itemName.equals("complexity")) {
							recipe.setComplexity(item.getString("utf-8"));
						}else if(itemName.equals("minute")) {
							recipe.setMinute(Integer.parseInt(item.getString("utf-8")));
						}else if(itemName.equals("tasty")) {
							recipe.setTasty(item.getString("utf-8"));
						}else if(itemName.equals("method")) {
							recipe.setMethod(item.getString("utf-8"));
						}else if(itemName.equals("summary")) {
							recipe.setDescription(item.getString("utf-8"));
						}else if(itemName.equals("directions")) {
							recipe.setAddress(item.getString("utf-8"));
						}else if(itemName.equals("step")) {
							Step step = new Step();
							step.setDescription(item.getString("utf-8"));
							steps.add(step);
						}else if(itemName.equals("ingredient_name")) {
							String ingredient_name = item.getString("utf-8");
							materials.add(ingredient_name);
						}else if(itemName.equals("ingredient_note")) {
							String ingredient_note = item.getString("utf-8");
							Mquantities.add(ingredient_note);
						}else {
							System.out.println("其它字段");
						}
					}else {
						if(itemName.equals("picture")) {
							//file 文件上传
							//getFieldName是获取普通表单字段name值
							//getName是获取文件名
							String fileName = item.getName();
							
							//控制文件类型
							String ext = fileName.substring(fileName.lastIndexOf(".")+1);
							if(!ext.equals("jpg")) {
								System.out.println("图片类型有误！图片只能是jpg");
								if(recipeService.delete(recipe.getId())) {
									System.out.println("初始食谱已被删除！");
								}else {
									System.out.println("初始食谱删除失败！");
								}
								String html = "文件（此处为图片）上传失败！<br>图片类型有误！图片只能是jpg！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
								response.getWriter().write(html);
								return ;
							}
							
							if(fileName.contains("\\")) {
		                        //如果包含则截取字符串
								fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
		                    }
							System.out.println("原始文件名："+fileName);
							//获取文件内容并上传
							//定义文件路径：指定上传的位置（服务器路径），这里放到workplace下本工程的一个文件夹
							String path = "D:\\Course\\Java\\workplace\\RecipeSSM\\WebContent\\upload\\recipe\\picture";
							System.out.println("文件保存路径："+path);
							//获取不包含路径的文件名
							ext = fileName.substring(fileName.lastIndexOf("."));
							fileName = "recipePhoto-" + recipe.getId() + "-" + picNo+ext;
							picNo++;
							
							picUrls.add(fileName);
							
							File file = new File(path,fileName);
							item.write(file);//上传
							System.out.println(fileName+"上传成功！");
						}
					}
				}
			} catch(FileUploadBase.SizeLimitExceededException e) {
				System.out.println("上传文件大小超过限制！最大100MB");
				if(recipeService.delete(recipe.getId())) {
					System.out.println("初始食谱已被删除！");
				}else {
					System.out.println("初始食谱删除失败！");
				}
				String html = "文件（此处为图片）上传失败！<br>上传文件大小超过限制！最大100MB!<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
				response.getWriter().write(html);
				return;
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			System.out.println("前台的form无multipart属性！");
			System.out.println("食谱上传失败！");
			if(recipeService.delete(recipe.getId())) {
				System.out.println("初始食谱已被删除！");
			}else {
				System.out.println("初始食谱删除失败！");
			}
			String html = "食谱上传失败！<br>前台的form无multipart属性！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
			response.getWriter().write(html);
			return ;
		}

		int i = 0;
		
		//上传食谱基本信息
		
		recipe.setAuthor(((User)request.getSession().getAttribute("user")).getId());
		System.out.println("作者id：" + ((User)request.getSession().getAttribute("user")).getId());
		
		result = recipeService.upload(recipe);
		if(result == 1) {
			System.out.println("食谱基本信息上传成功！");
		}else {
			if(recipeService.delete(recipe.getId())) {
				System.out.println("初始食谱已被删除！");
			}else {
				System.out.println("初始食谱删除失败！");
			}
			String html = "食谱基本信息上传失败！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
			response.getWriter().write(html);
			return ;
		}
		
		//上传步骤
		Iterator<Step> listStep = steps.iterator();
		Step step = new Step();
		i = 0;
		while(listStep.hasNext()) {
			result = 0;
			step = listStep.next();
			step.setRecipe(recipe.getId());
			step.setSequence(i+1);
			i++;
			result = stepService.upload(step);
			if(result == 1) {
				System.out.println("步骤  "+i+"  上传成功！");
			}else {
				if(recipeService.delete(recipe.getId())) {
					System.out.println("初始食谱已被删除！");
				}else {
					System.out.println("初始食谱删除失败！");
				}
				String html = "步骤上传失败！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
				response.getWriter().write(html);
				return ;
			}
		}
		
		//上传食材
		Iterator<String> listMate = materials.iterator();
		Iterator<String> Mquantity = Mquantities.iterator();
		Include include = new Include();
		while(listMate.hasNext()) {
			result = 0;
			include.setRecipe(recipe.getId());
			include.setMaterial(Integer.parseInt(listMate.next()));
			include.setQuantity(Mquantity.next());
			result = includeService.upload(include);
			if(result == 1) {
				System.out.println("食材  "+include.getMaterial()+"  上传成功！");
			}else {
				if(recipeService.delete(recipe.getId())) {
					System.out.println("初始食谱已被删除！");
				}else {
					System.out.println("初始食谱删除失败！");
				}
				String html = "食材上传失败！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
				response.getWriter().write(html);
				return ;
			}
		}
		
		//上传图片
		Iterator<String> listPic = picUrls.iterator();
		RPicture picture = new RPicture();
		i = 0;
		while(listPic.hasNext()) {
			result = 0;
			picture.setRecipe(recipe.getId());
			picture.setNumber(i);
			i++;
			picture.setUrl("upload/recipe/picture/"+listPic.next());
			result = pictureService.upload(picture);
			if(result == 1) {
				System.out.println("图片  "+picture.getNumber()+"  录入数据库成功！");
			}else {
				if(recipeService.delete(recipe.getId())) {
					System.out.println("初始食谱已被删除！");
				}else {
					System.out.println("初始食谱删除失败！");
				}
				String html = "图片录入数据库失败！<br><a href='/RecipeSSM/visit/recipe_upload'>重新上传</a><br>";
				response.getWriter().write(html);
				return ;
			}
		}
		
		String html = "您的食谱上传成功！请耐心等待审核...<br><a href='/RecipeSSM/visit/recipe_upload'>返回上传页面</a><br>";
		response.getWriter().write(html);
	}

	/*
	 * 初始化食谱页面
	 */
	@GetMapping("/initRecipe.action")
	public String initRecipe(HttpServletRequest request) {
		int state = 0;	// 状态为0，表示请求初始页面信息（相对于请求食谱搜索页面信息）
		
	// 分页食谱
		int page = 1;
		int pagesize = 8;
		int pagecount = 0;
		List<Recipe> recipes_page = new ArrayList<Recipe>();
		List<List<RPicture>> pictures_page = new ArrayList<List<RPicture>>();
		
		//读取客户端传递过来的要显示的页码
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		PageInfo<Recipe> pageInfo = new PageInfo<Recipe>();
		
		try {
			pageInfo = recipeService.getRecipeList(page, pagesize);
		} catch (Exception e) {
			e.printStackTrace();
		}

		page = pageInfo.getPageNum();
		pagecount = pageInfo.getPages();
		recipes_page = pageInfo.getList();
		
		Iterator<Recipe> recipes_pageIterator = recipes_page.iterator();
		while(recipes_pageIterator.hasNext()) {
			pictures_page.add(pictureService.getPictures(recipes_pageIterator.next().getId()));
		}
		
		request.setAttribute("state", state);
		request.setAttribute("page", page);
		request.setAttribute("pagecount",pagecount);
		request.setAttribute("recipes_page", recipes_page);
		request.setAttribute("pictures_page", pictures_page);
		
		return "recipe";
	}
	
	/*
	 * 搜索食谱名称
	 */
	@GetMapping("/searchRecipeName.action")
	public void searchRecipeName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String keyword = request.getParameter("keyword").trim();
		List<Recipe> recipeList  =recipeService.searchRecipe(keyword);
		
		//只查询名称
        List<String> NameList = new ArrayList<>();
		for(int i = 0; i < recipeList.size(); i++) {
			NameList.add(recipeList.get(i).getName());
		}
        //返回json格式
//	    System.out.println("RecipeController:searchRecipe:" + JSONArray.fromObject(NameList));
        response.getWriter().write(JSONArray.fromObject(NameList).toString());
	}
	
	/*
	 * 搜索食谱
	 */
	@GetMapping("/searchRecipe.action")
	public String searchRecipe(HttpServletRequest request, HttpServletResponse response) {
		// 查询相关食谱
		String keyword = request.getParameter("keyword").trim();
		List<Recipe> recipeList  =recipeService.searchRecipe(keyword);
        if(keyword == "" || keyword == null) {
        	return "redirect:/visit/recipe";
        }else {
        	int state = 1;	// 状态为1，表示请求食谱搜索页面信息（相对于请求食谱初始页面信息）
            // 分页显示搜索结果
    		int page = 1;
    		int pagesize = 4;
    		int recordcount = 0;
    		int pagecount = 0;
    		
    		if(request.getParameter("page")!=null){
    			page=Integer.parseInt(request.getParameter("page"));
    		}
    		recordcount = recipeList.size();
    		pagecount = recordcount/pagesize+(recordcount%pagesize==0?0:1);
    		
    		List<Recipe> RecipePageList = new ArrayList<Recipe>();
    		Iterator<Recipe> recipeIterator = recipeList.iterator();
    		List<List<RPicture>> picturesPage = new ArrayList<List<RPicture>>();
    		int i = (page-1)*pagesize+1;
    		int j = 0;
    		while(i <= page*pagesize && recipeIterator.hasNext()) {
//   			System.out.println("----------------SearchRecipe.java:" + recipeIterator.next().getName());
    			recipeIterator.next();	// 只有调用了next（）方法，迭代器才会往下挪一步
				j++;	
//				System.out.println("----------------SearchRecipe.java:i,j=" + i + ",  " + j);
    			if(i == j) {
        			RecipePageList.add(recipeList.get(i-1));
        			picturesPage.add(pictureService.getPictures(recipeList.get(i-1).getId()));
        			i++;
    			}
    		}
    		
    		request.setAttribute("state", state);
    		request.setAttribute("keyword", keyword);
    		request.setAttribute("page", page);
    		request.setAttribute("pagecount",pagecount);
    		request.setAttribute("recipes_page", RecipePageList);
    		request.setAttribute("pictures_page", picturesPage);
    		
    		return "recipe";
        }
	}
	
	/*
	 * 管理食谱
	 */
	@RequestMapping("/manageRecipe.action")
	public String manageRecipe(HttpServletRequest request) {
		List<Recipe> recipeList = new ArrayList<Recipe>();
		int page = 1;
		int pagesize = 5;
		int pagecount = 0;
		
		if(request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		
		PageInfo<Recipe> pageInfo = recipeService.getRecipeList(page, pagesize);
		
		page = pageInfo.getPageNum();
		pagecount = pageInfo.getPages();
		recipeList = pageInfo.getList();
		
		request.setAttribute("page", page);
		request.setAttribute("pagecount",pagecount);
		request.setAttribute("recipeList", recipeList);
		
		return "recipe_manage";
	}
	
}
