package com.lulu.util;

public class StringUtil {

	public String StringReplace(String str){
		
		String s="";
		s=str.substring(2, str.length()-2);
		String replacement="";
		for(int i=0;i<s.length();i++){
			replacement+='*';
		}
		
		s=str.replaceAll(s, replacement);
		return s;
		}
	
	public static void main(String[] args) {
		String str="1739932632";
		str=new StringUtil().StringReplace(str);
		System.out.println(str);
	}

}
