package service;

import java.util.List;

import pojo.Step;

public interface StepService {

	// 通过食谱 id 获取相应的步骤信息
	public List<Step> getStep(Integer recipeId);
	
	// 上传一份食谱的步骤信息
	public int upload(Step step);
}
