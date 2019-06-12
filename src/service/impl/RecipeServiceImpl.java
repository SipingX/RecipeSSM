package service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import mapper.RecipeMapper;
import pojo.Recipe;
import pojo.RecipeExample;
import service.RecipeService;
@Service("recipeService")
@Transactional
public class RecipeServiceImpl implements RecipeService {
	// 注入 RecipeDao
	@Autowired
	private RecipeMapper mapper;
	
	@Override
	public int getMaxId() {
		// TODO Auto-generated method stub
		return this.mapper.selectRecipeMaxId();
	}

	@Override
	public int initiateOneRecipe() {
		// TODO Auto-generated method stub
		int r = 0;
		
		Recipe recipe = new Recipe();
		recipe.setAuthor("init");
		recipe.setName("init");
		recipe.setCategory("init");
		recipe.setComplexity("init");
		recipe.setMinute(0);
		recipe.setTasty("init");
		recipe.setMethod("init");

		r = this.mapper.insertSelective(recipe);
		
		if(r > 0){
	        System.out.println("您成功初始化了 " + r + "份食谱！食谱id："+recipe.getId());
	        return recipe.getId();
	    }else{
	        System.out.println("执行初始化食谱操作失败！！！");
	        return 0;
	    }
		
	}

	@Override
	public int upload(Recipe recipe) {
		// TODO Auto-generated method stub
		int r = 0;
		r = this.mapper.updateByPrimaryKeySelective(recipe);
		if(r == 1){
	        System.out.println("您成功更新了 "+r+" 份食谱！");
	        System.out.println(recipe.toString());
	    }else{
	        System.out.println("执行更新食谱操作失败！！！");
	    }
		
		return r;
	}

	@Override
	public boolean delete(Integer id) {
		// TODO Auto-generated method stub
		boolean bool = false;
		int r = 0;
		r = mapper.deleteByPrimaryKey(id);
		if(r == 1){
	        System.out.println("您成功删除了 "+r+" 份食谱！");
	        bool = true ;
	    }else{
	        System.out.println("执行删除食谱操作失败！！！");
	    }
		
		return bool;
	}

	@Override
	public Recipe getRecipeInfoById(Integer id) {
		// TODO Auto-generated method stub
		return this.mapper.selectByPrimaryKey(id);
	}

	@Override
	public PageInfo<Recipe> getRecipeList(int page, int pagesize) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, pagesize);
		
		RecipeExample recipeExample = new RecipeExample();
		List<Recipe> recipes = this.mapper.selectByExample(recipeExample);
		
		PageInfo<Recipe> pageInfo = new PageInfo<Recipe>(recipes);
		
		return pageInfo;
	}

	@Override
	public List<Recipe> searchRecipe(String nameKeyword) {
		// TODO Auto-generated method stub
		List<Recipe> RecipeList = new ArrayList<>();
		RecipeExample example = new RecipeExample();
		
		RecipeExample.Criteria criteria = example.createCriteria();
		nameKeyword = "%" + nameKeyword + "%";
		criteria.andNameLike(nameKeyword);
		RecipeList = mapper.selectByExample(example);
		
		return RecipeList;
	}

}
