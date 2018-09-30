package com.st.rbac.pojo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Returnuser {
	private Integer id, userid, staid, staffdid;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm", timezone="GMT+8")
	private Date returntime;
	private String returndecbe, remark;
	
	public Integer getStaffdid() {
		return staffdid;
	}
	public void setStaffdid(Integer staffdid) {
		this.staffdid = staffdid;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getStaid() {
		return staid;
	}
	public void setStaid(Integer staid) {
		this.staid = staid;
	}
	
	public Date getReturntime() {
		return returntime;
	}
	public void setReturntime(String returntime) {
		  SimpleDateFormat aDate= new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
		  Date date;
		try {
			date = aDate.parse(returntime);
			this.returntime =date;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String getReturndecbe() {
		return returndecbe;
	}
	public void setReturndecbe(String returndecbe) {
		this.returndecbe = returndecbe;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
