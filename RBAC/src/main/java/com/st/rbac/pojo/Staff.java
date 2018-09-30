package com.st.rbac.pojo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Staff {

	private Integer id;
	private String stname;
	private String stpassword;
	private String zname;
	private String stsex;
	private Date stbday;
	private String stphone;
	private Integer roleid;
	private Integer stleader;
	private Integer ststate;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStname() {
		return stname;
	}
	public void setStname(String stname) {
		this.stname = stname;
	}
	public String getStpassword() {
		return stpassword;
	}
	public void setStpassword(String stpassword) {
		this.stpassword = stpassword;
	}
	public String getZname() {
		return zname;
	}
	public void setZname(String zname) {
		this.zname = zname;
	}
	public String getStsex() {
		return stsex;
	}
	public void setStsex(String stsex) {
		this.stsex = stsex;
	}
	public Date getStbday() {
		return stbday;
	}
	public void setStbday(String stbday) {
		 SimpleDateFormat aDate= new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
		  Date date;
		try {
			date = aDate.parse(stbday);
			this.stbday =date;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String getStphone() {
		return stphone;
	}
	public void setStphone(String stphone) {
		this.stphone = stphone;
	}
	public Integer getRoleid() {
		return roleid;
	}
	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
	public Integer getStleader() {
		return stleader;
	}
	public void setStleader(Integer stleader) {
		this.stleader = stleader;
	}
	public Integer getStstate() {
		return ststate;
	}
	public void setStstate(Integer ststate) {
		this.ststate = ststate;
	}
	
	
}
