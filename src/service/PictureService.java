package service;

import java.util.List;

import pojo.RPicture;

public interface PictureService {

	// 通过食谱 id 获取相应的食谱图片
	public List<RPicture> getPictures(Integer recipeId);
	
	// 上传一份食谱的图片信息
	public int upload(RPicture picture);
}
