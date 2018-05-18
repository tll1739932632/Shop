package com.lulu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lulu.model.Category;
import com.lulu.model.Product;
import com.lulu.service.IProductService;
import com.lulu.util.YZMUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class IndexController {

	@Autowired
	private IProductService productService;
	
	@RequestMapping("/index.do")//这个方法表示跳转到主页面
	public String index(){
		return "index";
	}
	
	@RequestMapping("/find.do")//这个方法
	public String find(){
		return "find";
	}
	
	@RequestMapping("/indexInit.do")//初始化主页
	@ResponseBody
	public JSONArray indexInit(){
		//1.显示一级菜单
		List<Category> cList=productService.getCategorys();
		//2.显示热门商品列表
		List<Product> hotList=productService.getHotProducts();
		//3.显示最新商品列表
		List<Product> newList=productService.getNewProducts();
		
		JSONArray jsonArray=new JSONArray();
		jsonArray.add(cList);
		jsonArray.add(hotList);
		jsonArray.add(newList);
		return jsonArray;
		
	}
	
	
	@RequestMapping("/login.do")//这个方法表示跳转到登陆页面
	public String login(){
		return "login";
	}
	
	@RequestMapping("/register.do")//这个方法表示跳转注册页面
	public String register(){
		return "register";
	}
	
	@RequestMapping("/getYZM.do")//
	public void getYZM(HttpServletRequest request,HttpServletResponse response){
		YZMUtil image=new YZMUtil();
		image.drawYZM(request, response);
	}
	
	@RequestMapping("/header.do")//加载头部
	public String header(){
		return "header";
	}
	
	@RequestMapping("/footer.do")//加载脚部
	public String footer(){
		return "footer";
	}
	
	
	
	
	
	
}
