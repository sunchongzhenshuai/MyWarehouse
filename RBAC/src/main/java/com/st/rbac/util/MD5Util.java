package com.st.rbac.util;

import java.security.MessageDigest;

import sun.misc.BASE64Encoder;

public class MD5Util {

	// MD5加密
	public static String getMD5(String str) {
		
		String newstr = null;
		try {
			//确定计算方法
			MessageDigest md5=MessageDigest.getInstance("MD5");
			BASE64Encoder base64en = new BASE64Encoder();
			//加密后的字符串
			newstr=base64en.encode(md5.digest(str.getBytes("utf-8")));
		
		} catch (Exception e) {
			// TODO: handle exception
		}

		return newstr; 
	}
	
	public static void main(String[] args) {
		String string = "Sunchong@666";
		String str2 = getMD5(string);
		/*
		 * 1. 改变顺序
		 * 		倒序
		 * 		奇偶位调换
		 * 2. 字符替换
		 * 		1->A
		 * 		2->3
		 * 		
		 * 26*26*10*10
		 */
		
		
		
		
		System.out.println(str2);
		
	}
}
