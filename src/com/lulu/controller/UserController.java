package com.lulu.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ObjectUtils.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lulu.model.User;
import com.lulu.service.IUserService;
import com.lulu.util.CodeUtil;
import com.lulu.util.EmailUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired//是spring的注解 被注入的对象 必须不为空，必须存在
	private IUserService userserivce;
	
	@RequestMapping("/checkUsername.do")
	@ResponseBody//把返回值 放在response中，而不是解析成界面
	public String checkUsername(String username) {
		User user=userserivce.getByUserName(username);
		
		if(user==null){
			return "yes";//用户名可用
		}else{
			return "no";//用户名不可用
		}
	}
	
	@RequestMapping("/check.do")
	@ResponseBody//把返回值 放在response中，而不是解析成界面
	public  JSONArray check(String username,User user) {
		 user=userserivce.getByUserName(username);
		JSONArray jsonArray=new JSONArray();
		 if(user!=null){
			 jsonArray.add(user);	
			
		 }
		 return jsonArray;
		
		
	}
	
	@RequestMapping("/register.do")
	@ResponseBody//把返回值 放在response中，而不是解析成界面
	public String register(User user,String captcha,HttpSession session){
		//获取session中的验证码
		String vcode=(String) session.getAttribute("VCODE");
		
		//字符串比较 忽略大小写
		if(!vcode.equalsIgnoreCase(captcha)){
			return "no";
		}else{
			//为用户生成新的激活码
			String code=CodeUtil.getActiveCode();
			user.setCode(code);
			int count=userserivce.addUser(user);
			if(count>0){//注册成功，发送邮件
				EmailUtil.sendEmail(user.getEmail(), code);
			}else{//注册失败
				return "defeat";
			}
			return "yes";
		}
	}
	
	@RequestMapping("/active.do")//激活路径
	public String activeUser(String code,Map<String, Object> map){
		int count=userserivce.activeUser(code);
		if(count>0){
			map.put("message", "yes");
		}else{
			map.put("message", "no");
		}
		return "message";
		
	}
	
	@RequestMapping("/login.do")
	@ResponseBody
	public String loginUser(String isRe,String username,String password,String captcha,HttpSession session) {
		//1.用户名是否存在
		//2.用户名是否激活
		//3.用户名和密码是否匹配
		//4.验证码是否正确
		User user=userserivce.getByUserName(username);
		User isUser=userserivce.getUserName(username);
		User isUserPassword=userserivce.getUsernameAndPassword(username, password);
		String vcode=(String) session.getAttribute("VCODE");
		if(user==null){
			return "0";//用户名不存在
		}else{		
			
			 if(isUser==null){
				 return "1";//用户名没有激活
			 }else{
				
				 if(isUserPassword==null){
					 return "2";//密码不正确
				 }else{
					 if(!captcha.equalsIgnoreCase(vcode)){
						 return "3";//验证码不正确
					 }else{
						 session.setAttribute("username", username);
						 session.setAttribute("password", password);
						 System.out.println(isRe);
						 if(isRe==null){
							 return "4";
						 }
						 else{ //记住密码
							 return session.getAttribute("username").toString();//登陆成功
						 }
						 
						 
					 }
				 }
				
			 }			
		}	
		
	}
	
	
	//显示欢迎名称
	@RequestMapping("/nameShow.do")
	@ResponseBody
	public String nameShow(HttpSession session) {
		String name=(String) session.getAttribute("username");
		if (name==null) {
			return "0";//session为空
		}else{
			return name;//session已存入，表示成功登陆
		}
		
	}
	
	//用户退出
	@RequestMapping("/loginOut.do")
	@ResponseBody
	public String loginOut(HttpSession session){
		session.removeAttribute("username");
		session.removeAttribute("password");
		return "1";
	}
	
	//忘记密码
	@RequestMapping("/forgetPwd.do")
	@ResponseBody
	public int updatePwd(String username,String password){
		int count=userserivce.updatePwdByUsername(username, password);
		return count;
	}
	
	

}
