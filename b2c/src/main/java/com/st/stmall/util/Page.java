package com.st.stmall.util;

import java.util.List;

/**
 * 辅助分页查询
 * @author mi
 *
 */
public class Page {
	
	// 1. 每页显示的记录数
	private Integer pagerows = 5;
	
	// 2. 当前页
	private Integer curpage; 
	
	// 3. 总页数
	private Integer pagecount;
	
	// 4. 查询到的所有的记录有多少条
	private Integer rows;
	
	// 5. 查询到的数据集合
	private List list;
	
	// 6. 查询起点
	private Integer start;
	
	//7.查询条件
	private Object where;

	public Integer getPagerows() {
		return pagerows;
	}

	public void setPagerows(Integer pagerows) {
		this.pagerows = pagerows;
		this.start = (curpage-1) * this.pagerows;
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

	public Integer getPagecount() {
		return pagecount;
	}

	public void setPagecount(Integer pagecount) {
		this.pagecount = pagecount;
		
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
		//计算页面数
		/**
		 * 0 => 0
		 * 1 => 1
		 * 2 => 1
		 * 3 => 2
		 * 4 => 2
		 * pagerows
		 */
		this.pagecount = (this.rows+this.pagerows-1) / this.pagerows;
	}

	public List<Object> getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Object getWhere() {
		return where;
	}

	public void setWhere(Object where) {
		this.where = where;
	}
	
}
