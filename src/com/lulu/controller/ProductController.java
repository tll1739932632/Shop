package com.lulu.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lulu.model.Cart;
import com.lulu.model.Categorysecond;
import com.lulu.model.Orders;
import com.lulu.model.Product;
import com.lulu.service.IProductService;
import com.lulu.util.PageUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class ProductController {
	
	@Autowired
	private IProductService productService;
	
	@RequestMapping("/class.do")//跳转到分类页面
	public String SPclass(){
		return "SPclassification";
	}
	
	@RequestMapping("/deatil.do")//跳转到分类页面
	public String deatil(){
		return "deatil";
	}
	
	//商品详细页面
	@RequestMapping("/deatilInfo.do")//
	@ResponseBody
	public JSONArray deatilInfo(int pid){
		List<Product> list=productService.getInfoByPid(pid);
		JSONArray jsonArray=new JSONArray();
		jsonArray.add(list);
		return jsonArray;
	}
	
	@RequestMapping("/goCategory.do")
	@ResponseBody
	public JSONArray goCategory(int cid,PageUtil page,int current){
		//1.查询二级菜单
		List<Categorysecond> list=productService.getSeByCid(cid);
		
		//2.根据一级菜单查询商品查询商品的总个数
		page.setTotalCount(productService.getCountByCid(cid));
		page.setCuurentPage(current);
		int beginIndex=(page.getCuurentPage()-1)*page.getPageSize();
		
		//3.根据一级菜单查询商品
		List<Product> list2=productService.getProductByCid(cid, beginIndex, page.getPageSize());
	
		JSONArray jsonArray=new JSONArray();
		jsonArray.add(list);
		jsonArray.add(list2);
		jsonArray.add(page);
		
		return jsonArray;
		
		
	}
	
	@RequestMapping("/fenye.do")
	@ResponseBody
	public JSONArray fenye(int cid,int current,PageUtil page){
		page.setTotalCount(productService.getCountByCid(cid));
		page.setCuurentPage(current);
		int beginIndex=(page.getCuurentPage()-1)*page.getPageSize();
		List<Product> list=productService.getProductByCid(cid, beginIndex, page.getPageSize());
		JSONArray jsonArray=new JSONArray();
		jsonArray.add(list);
		jsonArray.add(page);
		return jsonArray;
	}
	
	@RequestMapping("/goCart.do")//去购物车
	public String goCart(){
		return "cart";
	}
	
	//根据二级菜单查询商品
	@RequestMapping("/getProductByCsid.do")
	@ResponseBody
	public JSONArray getProductByCsid(int csid,PageUtil page){
		
		//1.查询csid的总数量
		page.setTotalCount(productService.getCountByCsid(csid));
		//计算起始索引
		int beginIndex=(page.getCuurentPage()-1)*page.getPageSize();
		
		//2.查询结果到界面
		List<Product> list=productService.getProductByCsid(csid, beginIndex, page.getPageSize());
		
		JSONArray jsonArray=new JSONArray();
		jsonArray.add(list);
		jsonArray.add(page);
		return jsonArray;
	}
	
	//添加数据到购物车
	@RequestMapping("/insertCart.do")
	@ResponseBody
	public int insertCart(int pid,String image,String pname,double price,
			int count,Cart cart,HttpSession session){
		Date date=new Date();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<Cart> list=productService.getIsHavedByPid(pid);
		int success=0;
		if(list.size()==0){
			cart.setDate(format.format(date));
			cart.setUsername(session.getAttribute("username").toString());
			cart.setPid(pid);
			success=productService.insertProductToCart(cart);
		}else{
			success=productService.updateCartByPid(pid, count);
		}
		return success;
	}
	
	//查看购物车
	@RequestMapping("/lookCart.do")
	@ResponseBody
	public JSONArray lookCart(HttpSession session){
		String username="";
		if(session.getAttribute("username")!=null){
			username=session.getAttribute("username").toString();
		}
		
		List<Cart> list=productService.getCartByUsername(username);
		JSONArray jsonArray=new JSONArray();
		jsonArray.add(list);
		return jsonArray;
	}
	
	
	//清除购物车
	@RequestMapping("/removeCart.do")
	@ResponseBody
	public int removeCart(HttpSession session){
		String username=session.getAttribute("username").toString();
		int success=productService.removeCart(username);
		
		return success;
	}
	
	//删除购物车 某一条数据
	@RequestMapping("/deletCartByPid.do")
	@ResponseBody
	public int deletCartByPid(int pid){
		int success=productService.deleteCartByPid(pid);
		return success;
	}
	
	//跳转到订单页面
	@RequestMapping("/goOrder.do")
	public String goOrder(){
		return "order";
	}
	@RequestMapping("/submitOrder.do")
	@ResponseBody
	public int submitOrder(Orders orders,double total,HttpSession session){
		Date date=new Date();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM--dd hh:MM:ss");
		orders.setOrdertime(format.format(date));
		orders.setTotal(total);
		orders.setUsername(session.getAttribute("username").toString());
		int success=productService.submitOrder(orders);
		
		return success;
	}


}
