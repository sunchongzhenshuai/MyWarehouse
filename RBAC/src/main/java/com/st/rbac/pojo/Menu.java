package com.st.rbac.pojo;

public class Menu {
	private Integer mid;
	private String mname;
	private String murl;
	private Integer pmid;
	private String tubiao;
	
	public String getTubiao() {
		return tubiao;
	}
	public void setTubiao(String tubiao) {
		this.tubiao = tubiao;
	}
	public Integer getMid() {
		return mid;
	}
	public void setMid(Integer mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMurl() {
		return murl;
	}
	public void setMurl(String murl) {
		this.murl = murl;
	}
	public Integer getPmid() {
		return pmid;
	}
	public void setPmid(Integer pmid) {
		this.pmid = pmid;
	}
	
}
