package service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mapper.MaterialMapper;
import pojo.Material;
import service.MaterialService;
@Service("materialService")
@Transactional
public class MaterialServiceImpl implements MaterialService {
	// 注入 MaterialDao
	@Autowired
	private MaterialMapper mapper;
	
	@Override
	public Material getMaterial(int id) {
		// TODO Auto-generated method stub
		return this.mapper.selectByPrimaryKey(id);
	}

}
