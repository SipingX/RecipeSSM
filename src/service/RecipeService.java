package service;

import java.util.List;

import com.github.pagehelper.PageInfo;

import pojo.Recipe;

public interface RecipeService {

	// 获取最大 Id 号
	public int getMaxId();
	
	// 初始化一份食谱
	public int initiateOneRecipe();
	
	// 上传一份食谱
	public int upload(Recipe recipe);
	
	// 通过 Id 删除一份食谱
	public boolean delete(Integer id);
	
	// 通过 Id 获取一份食谱的详细页面信息
	public Recipe getRecipeInfoById(Integer id);
	
	// 通过页码和页面大小获取食谱分页显示信息
	public PageInfo<Recipe> getRecipeList(int page,int pagesize);
	
	// 通过
	public List<Recipe> searchRecipe(String nameKeyword);
	
}
