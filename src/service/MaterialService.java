package service;

import pojo.Material;

public interface MaterialService {
	
	// 通过食材 Id 获取食材信息
	public Material getMaterial(int id); 

}
