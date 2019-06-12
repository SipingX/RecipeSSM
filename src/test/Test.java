package test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import pojo.RPicture;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<RPicture> pictures = new ArrayList<RPicture>();
		for(int i=0; i<4; i++) {
			RPicture picture = new RPicture();
			picture.setUrl("/" + i + "/images/recipeThumb-04.jpg"); 
			pictures.add(picture);
		}
		Iterator<RPicture> picturesIte = pictures.iterator();
		while(picturesIte.hasNext()) {
			System.out.println("pictureIte:" + picturesIte.next().getUrl());
//			picturesIte.next().setUrl("/RecipeSSM" + picturesIte.next().getUrl());
		}
/*		for(int i=0; i<pictures.size(); i++) {
			pictures.get(i).setUrl("/RecipeSSM" + pictures.get(i).getUrl());
		}*/
		
		// 说明生成的一个迭代器只能遍历一次；但一个 List 可以生成多个迭代器，其间互不干扰
		Iterator<RPicture> picturesIte2 = pictures.iterator();
		while(picturesIte2.hasNext()) {
			System.out.println("pictureIte2:" + picturesIte2.next().getUrl());
		}
	}

}
