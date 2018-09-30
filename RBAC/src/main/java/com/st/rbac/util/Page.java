package com.st.rbac.util;


/**
 * 辅助分页查询
 * @author mi
 *
 */
public class Page {
	
	// 1. 每页显示的记录数
	private Integer pagerows;
	
	// 2. 当前页
	private Integer curpage; 
	
	// 6. 查询起点
	private Integer start;
	

	public Integer getPagerows() {
		return pagerows;
	}

	public void setPagerows(Integer pagerows) {
		this.pagerows = pagerows;
	}

	public Integer getCurpage() {
		return curpage;
	}

	public void setCurpage(Integer curpage) {
		this.curpage = curpage;
		
		// 计算查询起点 
		/*
		 * 第一页面, 0
		 * 第二页面, 10
		 * 第三页面, 20
		 */
		this.start = (curpage-1) * this.pagerows;
	}

	
	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}
	
}
