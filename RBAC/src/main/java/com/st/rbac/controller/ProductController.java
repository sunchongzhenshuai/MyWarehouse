package com.st.rbac.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.st.rbac.pojo.Product;
import com.st.rbac.pojo.Productpic;
import com.st.rbac.pojo.ResponseResult;
import com.st.rbac.service.IProductService;
import com.st.rbac.service.IProductpicService;
import com.st.rbac.util.Page;

@Controller
public class ProductController {
	
	@Autowired
	private IProductService iProductService;
	
	@Autowired
	private IProductpicService iProductpicService;
	
	@RequestMapping("/Product/productList.action")
	public String productList() {
		return "WEB-INF/views/productList";
	}
	@RequestMapping("/role/Product/modifyprod.action")
	public String modifyprod() {
		return "WEB-INF/views/modifyprod";
	}
	@RequestMapping("/role/Product/addproduct.action")
	public String addproduct() {
		return "WEB-INF/views/addproduct";
	}
	@RequestMapping("/Product/lookproduct.action")
	public String lookproduct() {
		return "WEB-INF/views/lookproduct";
	}
	
	@RequestMapping("/Product/selectPic.action")
	@ResponseBody
	public List<Productpic> selectPic(Integer prdid) {
		
		List<Productpic> pic = iProductpicService.selectPic(prdid);
		
		return pic;
	}
	
	@RequestMapping("/role/Product/prodadd.action")
	@ResponseBody
	public ResponseResult prodadd(Product product,String[] pics) {
		
		ResponseResult result = new ResponseResult();
		
		// 将产品信息插入数据库
		int res = iProductService.prodadd(product);
		
		if (res <= 0) {
			result.setCode(-1);
			result.setMsg("产品添加失败!");
		} else {
			
			//将图片信息插入数据库
			int res2 = iProductpicService.insertBatch(pics, product.getPicture());
			
			if (res2 <= 0) {
				result.setCode(-2);
				result.setMsg("图片添加失败!");
			} else {
				result.setCode(0);
				result.setMsg("图片添加成功");
			}
		}
		
		return result;
	}
	
	@RequestMapping("/Product/selectprod.action")
	@ResponseBody
	public ResponseResult selectprod(Integer limit, Integer page, Product product2){
		
		Page page2 = new Page();
		
		page2.setPagerows(limit);
		page2.setCurpage(page);
		List<Product> product = iProductService.selectprod(page2,product2);
		Integer count = iProductService.getRows(page2, product2);
		
		ResponseResult result = new ResponseResult();
		
		result.setCode(0);
		result.setCount(count);
		result.setData(product);
		result.setMsg("xxx");
		return result;
		
	}
	
	
	@RequestMapping("/role/Product/deleteprod.action")
	@ResponseBody
	public ResponseResult deleteprod(Integer id) {
		
		
		int res = iProductService.delectprod(id);
		
		ResponseResult result = new ResponseResult();
		
		
		if (res > 0) {
			result.setMsg("删除成功");
		} else {
			result.setMsg("删除失败");
		}
		return result;
		
	}
	
	@RequestMapping("/role/Product/modifyduct.action")
	@ResponseBody
	public ResponseResult modifyduct(Product product) {
		
		
		int res = iProductService.modifyduct(product);
		
		ResponseResult result = new ResponseResult();
		
		if (res > 0) {
			result.setCode(0);
			result.setMsg("修改成功!");
		}else {
			result.setCode(1);
			result.setMsg("修改失败!");
		}
		
		return result;
		
	}
	/*
	 * 上传文件
	 * 1. 需要依赖commons-fileuplad.jar,commons-io.jar
	 * 2.需要在SpringMVC.xml文件中添加文件解析器的设置
	 * 3.
	 */
	
	@RequestMapping("/role/Product/uploadPic.action")
	@ResponseBody
	public ResponseResult uploadPic(MultipartFile file,HttpServletRequest request) {
		
		
		//文件保存到哪里？
		//保存路径
		String savePath = request.getSession().getServletContext().getRealPath("/upload");
		//保存文件名
		//获取上传的文件名
		String fileName = file.getOriginalFilename();
		//截取文件名的最后一个.点 的名字后缀
		String subfix = fileName.substring(fileName.lastIndexOf("."));
		//根据UUID 加上后缀 创建一个新的文件名
		String saveFile = UUID.randomUUID() + subfix;
		
		//文件如何保存？
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			inputStream = file.getInputStream();
			
			outputStream = new FileOutputStream(savePath +"/"  + saveFile);
			
			IOUtils.copy(inputStream, outputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Productpic pic = new Productpic();
		pic.setPrdpic("upload/"+saveFile);
		
		
		ResponseResult result = new ResponseResult();
		
		result.setCode(0);
		result.setMsg("上传成功");
		result.setData(pic);;
		
		return result;
	}
	
	@RequestMapping("/role/Product/deletepic.action")
	@ResponseBody
	public int deletepic(Productpic productpic) {
		
		int res = iProductpicService.deletepic(productpic);
		
		return res;
		
	}
	@RequestMapping("/role/Product/addpic.action")
	@ResponseBody
	public ResponseResult addpic(Integer picture,String[] pics) {
		
		ResponseResult result = new ResponseResult();
		
		
			
			//将图片信息插入数据库
			int res2 = iProductpicService.insertBatch(pics, picture);
			for (String string : pics) {
				System.out.println(string);
			}
			
			if (res2 <= 0) {
				result.setCode(-2);
				result.setMsg("图片添加失败!");
			} else {
				result.setCode(0);
				result.setMsg("图片添加成功");
			}
		
		return result;
	}
	
}
