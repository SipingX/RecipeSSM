package service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mapper.IncludeMapper;
import pojo.Include;
import pojo.IncludeExample;
import service.IncludeService;
@Service("includeService")
@Transactional
public class IncludeServiceImpl implements IncludeService {
	@Autowired
	private IncludeMapper mapper;
	
	@Override
	public List<Include> getInclude(Integer recipeId) {
		// TODO Auto-generated method stub
		List<Include> list = new ArrayList<Include>();
		IncludeExample example = new IncludeExample();
		IncludeExample.Criteria criteria = example.createCriteria();
		
		criteria.andRecipeEqualTo(recipeId);
		list = this.mapper.selectByExample(example);
		
		return list;
	}

	@Override
	public int upload(Include include) {
		// TODO Auto-generated method stub
		int r = 0;
		
		r = this.mapper.insertSelective(include);
		if(r == 1){
	        System.out.println("您成功插入了 "+r+" 份食谱Include！");
	    }else{
	        System.out.println("执行插入食谱Include操作失败！！！");
	    }
		
		return r;
	}

}
