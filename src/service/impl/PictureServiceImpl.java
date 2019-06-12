package service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mapper.RPictureMapper;
import pojo.RPicture;
import pojo.RPictureExample;
import service.PictureService;
@Service("r_pictureService")
@Transactional
public class PictureServiceImpl implements PictureService {
	@Autowired
	private RPictureMapper mapper;
	
	@Override
	public List<RPicture> getPictures(Integer recipeId) {
		// TODO Auto-generated method stub
		List<RPicture> list = new ArrayList<RPicture>();
		RPictureExample example = new RPictureExample();
		RPictureExample.Criteria criteria = example.createCriteria();
		
		criteria.andRecipeEqualTo(recipeId);
		
		list = this.mapper.selectByExample(example);
		
		// 在每张图片的地址最前面加上 /RecipeSSM/
		for(int i=0; i<list.size(); i++) {
			list.get(i).setUrl("/RecipeSSM/" + list.get(i).getUrl());
		}
 		
		return list;
	}

	@Override
	public int upload(RPicture picture) {
		// TODO Auto-generated method stub
		int r = 0;
		
		r = this.mapper.insertSelective(picture);
		if(r == 1){
	        System.out.println("您成功插入了 "+r+" 张图片！");
	    }else{
	        System.out.println("执行插入图片操作失败！！！");
	    }
		
		return r;
	}

}
