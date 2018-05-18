package com.lulu.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lulu.dao.ProductMapper;
import com.lulu.model.Cart;
import com.lulu.model.Category;
import com.lulu.model.Categorysecond;
import com.lulu.model.Orders;
import com.lulu.model.Product;

@Service
@Transactional
public class ProductService implements IProductService {
	
	@Resource
	ProductMapper productMapper;

	@Override
	public List<Category> getCategorys() {
		
		return productMapper.getCategorys();
	}

	@Override
	public List<Product> getHotProducts() {
		
		return productMapper.getHotProducts();
	}

	@Override
	public List<Product> getNewProducts() {
		
		return productMapper.getNewProducts();
	}

	@Override
	public List<Categorysecond> getSeByCid(int cid) {
		
		return productMapper.getSeByCid(cid);
	}

	@Override
	public List<Product> getProductByCid(int cid, int beginIndex, int pageSize) {
		
		return productMapper.getProductByCid(cid, beginIndex, pageSize);
	}

	@Override
	public List<Product> getProductByCsid(int csid, int beginIndex, int pageSize) {
		
		return productMapper.getProductByCsid(csid, beginIndex, pageSize);
	}

	@Override
	public int getCountByCid(int cid) {
		
		return productMapper.getCountByCid(cid);
	}

	@Override
	public int getCountByCsid(int csid) {
		
		return productMapper.getCountByCsid(csid);
	}

	@Override
	public List<Product> getInfoByPid(int pid) {
		
		return productMapper.getInfoByPid(pid);
	}

	@Override
	public int insertProductToCart(Cart cart) {
		
		return productMapper.insertProductToCart(cart);
	}

	@Override
	public List<Cart> getCartByUsername(String username) {
		
		return productMapper.getCartByUsername(username);
	}

	@Override
	public List<Cart> getIsHavedByPid(int pid) {
		
		return productMapper.getIsHavedByPid(pid);
	}

	@Override
	public int updateCartByPid(int pid, int count) {
		
		return productMapper.updateCartByPid(pid, count);
	}

	@Override
	public int removeCart(String username) {
		
		return productMapper.removeCart(username);
	}

	@Override
	public int deleteCartByPid(int pid) {
		
		return productMapper.deleteCartByPid(pid);
	}

	@Override
	public int submitOrder(Orders orders) {
		
		return productMapper.submitOrder(orders);
	}

}
