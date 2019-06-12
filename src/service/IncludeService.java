package service;

import java.util.List;

import pojo.Include;

public interface IncludeService {
	
	// 通过食谱 Id 获取相应的食材
	public List<Include> getInclude(Integer recipeId);
	
	// 上传一份食谱的食材信息
	public int upload(Include include); 
}
