package com.lulu.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lulu.model.Cart;
import com.lulu.model.Category;
import com.lulu.model.Categorysecond;
import com.lulu.model.Orders;
import com.lulu.model.Product;

public interface IProductService {
	
	//查询一级菜单并显示在页面
		public List<Category> getCategorys();
		
		//查询热门商品并显示在页面上
		public List<Product> getHotProducts();
		
		//查询最新商品并显示在页面上
		public List<Product> getNewProducts();
		
		//根据一级菜单查询二级菜单
		public List<Categorysecond> getSeByCid(int cid);
		
		//根据一级菜单查询商品信息,并分页显示
		public List<Product> getProductByCid(@Param("cid")int cid,
											@Param("beginIndex")int beginIndex,
											@Param("pageSize")int pageSize);
		
		//根据二级菜单查询商品信息，并分页显示
		public List<Product> getProductByCsid(@Param("csid")int csid,
											@Param("beginIndex")int beginIndex,
											@Param("pageSize")int pageSize);
		
		//根据一级菜单查询商品信息的总数量
		public int getCountByCid(int cid);
		//根据二级菜单查询商品信息的总数量
		public int getCountByCsid(int csid);
		
		//根据pid查询某一个商品
		public List<Product> getInfoByPid(int pid);
		
		//添加数据到购物车
		public int insertProductToCart(Cart cart);
		
		//查看购物商品
		public List<Cart> getCartByUsername(String username);
		
		//查看购物车商品是否重复
		public List<Cart> getIsHavedByPid(int pid);
		
		//更新购物车重复的值 增加数量
		public int updateCartByPid(@Param("pid")int pid,
									@Param("count")int count);
		
		//清空购物车
		public int removeCart(String username);
		
		//删除购物车某一行的数据
		public int deleteCartByPid(int pid);
		
		//提交订单
		public int submitOrder(Orders orders);

}
