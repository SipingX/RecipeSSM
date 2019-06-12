package service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mapper.StepMapper;
import pojo.Step;
import pojo.StepExample;
import service.StepService;
@Service("stepService")
@Transactional
public class StepServiceImpl implements StepService {
	@Autowired
	private StepMapper mapper;
	
	@Override
	public List<Step> getStep(Integer recipeId) {
		// TODO Auto-generated method stub
		List<Step> list = new ArrayList<Step>();
		StepExample example = new StepExample();
		StepExample.Criteria criteria = example.createCriteria();
		
		criteria.andRecipeEqualTo(recipeId);
		list = this.mapper.selectByExample(example);
		
		return list;
	}

	@Override
	public int upload(Step step) {
		// TODO Auto-generated method stub
		int r = 0;
		
		r = this.mapper.insertSelective(step);
		if(r == 1){
	        System.out.println("您成功插入了 "+r+" 个食谱步骤！");
	    }else{
	        System.out.println("执行插入食谱步骤操作失败！！！");
	    }
		
		return r;
	}

}
