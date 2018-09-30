package com.st.rbac.pojo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Sell {
	private Integer sid;
	private Integer uid;
	private Integer staffid;
	private Integer pid;
	private Integer sellcount;
	private Double sellprice;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm", timezone="GMT+8")
	private Date selltime;
	private Integer dclassid;
	private Integer xclassid;
	private Integer stafid;
	
	
	public Integer getStafid() {
		return stafid;
	}
	public void setStafid(Integer stafid) {
		this.stafid = stafid;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Integer getStaffid() {
		return staffid;
	}
	public void setStaffid(Integer staffid) {
		this.staffid = staffid;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getSellcount() {
		return sellcount;
	}
	public void setSellcount(Integer sellcount) {
		this.sellcount = sellcount;
	}
	public Double getSellprice() {
		return sellprice;
	}
	public void setSellprice(Double sellprice) {
		this.sellprice = sellprice;
	}
	public Date getSelltime() {
		return selltime;
	}
	public void setSelltime(String selltime) {
		  SimpleDateFormat aDate= new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
		  Date date;
		try {
			date = aDate.parse(selltime);
			this.selltime =date;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public Integer getDclassid() {
		return dclassid;
	}
	public void setDclassid(Integer dclassid) {
		this.dclassid = dclassid;
	}
	public Integer getXclassid() {
		return xclassid;
	}
	public void setXclassid(Integer xclassid) {
		this.xclassid = xclassid;
	}
	
	
}
