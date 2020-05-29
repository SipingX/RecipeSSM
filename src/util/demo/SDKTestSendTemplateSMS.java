package util.demo;

import java.util.HashMap;
import java.util.Random;

import util.sdk.CCPRestSDK;

public class SDKTestSendTemplateSMS {
	
	/**
	 * 生成指定位数随机数
	 * @return 
	 */
	static Random random = new Random();
	public static String randNum(int number){
		String result = "";
		for(int i=0;i<number;i++){
			result += random.nextInt(10);
		}
		return result;
	}

	/**
	 * 发送指定位数短信验证码
	 */
	public static String send(String phone,int length){
		String num = randNum(length);
		return execute(phone,num)? num : "0";
	}
	
	/**
	 * 发送6位数短信验证码
	 */
	public static String send(String phone){
		return send(phone,6);
	}
	
	/**
	 * @param args
	 */
	public static boolean execute(String phone,String num) {
		HashMap<String, Object> result = null;

		CCPRestSDK restAPI = new CCPRestSDK();
		restAPI.init("app.cloopen.com", "8883");// 初始化服务器地址和端口，格式如下，服务器地址不需要写https://
		restAPI.setAccount("8aaf070870e20ea101710b8a95bc16fd", "573130260498452c919de1979ce974cc");// 初始化主帐号和主帐号TOKEN
		restAPI.setAppId("8aaf070870e20ea101710b8a96171703");// 初始化应用ID
		result = restAPI.sendTemplateSMS(phone,"1" ,new String[]{num,"5"});

//		System.out.println("SDKTestSendTemplateSMS result=" + result);
		
		if("000000".equals(result.get("statusCode"))){
			//正常返回输出data包体信息（map）
/*			HashMap<String,Object> data = (HashMap<String, Object>) result.get("data");
			Set<String> keySet = data.keySet();
			for(String key:keySet){
				Object object = data.get(key);
				System.out.println(key +" = "+object);
			}*/
			return true;
		}else{
			//异常返回输出错误码和错误信息
			System.out.println("错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
			return false;
		}
	}

}
