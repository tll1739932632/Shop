package com.lulu.util;

public class PageUtil {
	
	private int cuurentPage=1;//当前页数 默认为第一页
	private int PageSize=12;//每页显示的数量
	private int totalCount=0;//总个数
	private int totalPage=0;//总页数
	public int getCuurentPage() {
		return cuurentPage;
	}
	public void setCuurentPage(int cuurentPage) {
		this.cuurentPage = cuurentPage;
	}
	public int getPageSize() {
		return PageSize;
	}
	public void setPageSize(int pageSize) {
		PageSize = pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		if(totalCount%PageSize==0){
			totalPage=totalCount/PageSize;
		}else{
			totalPage=totalCount/PageSize+1;
		}
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	
	

}
