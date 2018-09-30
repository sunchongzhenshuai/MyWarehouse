package com.st.rbac.pojo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Product {
	private Integer id;
	private String prname;
	private String details;
	private Double sdprice;
	private Double lowprice;
	private Integer stock;
	private Integer dclassid;
	private Integer xclassid;
	private Integer picture;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm", timezone="GMT+8")
	private Date protime;
	private Integer xiaoliang;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPrname() {
		return prname;
	}
	public void setPrname(String prname) {
		this.prname = prname;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public Double getSdprice() {
		return sdprice;
	}
	public void setSdprice(Double sdprice) {
		this.sdprice = sdprice;
	}
	public Double getLowprice() {
		return lowprice;
	}
	public void setLowprice(Double lowprice) {
		this.lowprice = lowprice;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public Integer getPicture() {
		return picture;
	}
	public void setPicture(Integer picture) {
		this.picture = picture;
	}
	public Date getProtime() {
		return protime;
	}
	public void setProtime(String protime) {
		  SimpleDateFormat aDate= new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
		  Date date;
		try {
			date = aDate.parse(protime);
			this.protime =date;
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
	public Integer getXiaoliang() {
		return xiaoliang;
	}
	public void setXiaoliang(Integer xiaoliang) {
		this.xiaoliang = xiaoliang;
	}
	
}
