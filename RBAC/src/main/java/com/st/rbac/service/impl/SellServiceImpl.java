package com.st.rbac.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.rbac.mapper.CategoryMapper;
import com.st.rbac.mapper.ProductMapper;
import com.st.rbac.mapper.SellMapper;
import com.st.rbac.mapper.StaffMapper;
import com.st.rbac.mapper.UserMapper;
import com.st.rbac.pojo.Product;
import com.st.rbac.pojo.ResponseResult;
import com.st.rbac.pojo.Sell;
import com.st.rbac.pojo.User;
import com.st.rbac.service.ISellService;
import com.st.rbac.util.Page;

@Service
public class SellServiceImpl implements ISellService {
	
	@Autowired
	SellMapper sellMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	StaffMapper staffMapper;
	
	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	CategoryMapper categoryMapper;
	
	@Override
	public List<HashMap<String, Object>> selectsell(Page page2,Sell sell) {
		
		return sellMapper.selectsell(page2, sell);
	}

	@Override
	public Integer getRows(Sell sell) {
		// TODO Auto-generated method stub
		return sellMapper.getRows(sell);
	}

	@Override
	public List<Sell> timeselect(Date date, Date date2) {
		
		return sellMapper.timeselect(date,date2);
	}

	@Override
	public int addSell(Sell sell, User user) {
		
		try {
			int res = userMapper.adduser(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new RuntimeException("订单添加失败");
		}
		
		
			Double sprice = sell.getSellprice();
			
			System.out.println(sprice);
			
			Product product = productMapper.selectprodByid(sell.getPid());
			
			System.out.println(product.getSdprice());
			System.out.println(product.getLowprice());
			System.out.println(user.getSellture());
			Double sellprice2;
			if (sprice!=null && sprice <= product.getSdprice() && sprice >= product.getLowprice()) {
				try {
					
					sellprice2 = (sell.getSellcount() * sell.getSellprice());
					System.out.println(sellprice2);
					sell.setSellprice(sellprice2);
					sell.setUid(user.getSellture());
					int res2 = sellMapper.addsell(sell);
					categoryMapper.addsalesv(sell.getXclassid(),sellprice2);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("订单添加失败");
				}
				
				try {
					productMapper.reducecount(sell.getPid(), sell.getSellcount());
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					throw new RuntimeException("添加失败!输入的数量与当前的库存不符!");
				}
				
				try {
			
					
					
					productMapper.addxiaoliang(sell.getPid(), sell.getSellcount());
					
					categoryMapper.addsalesv(sell.getDclassid(),sellprice2);
					
					staffMapper.addachievement(sell.getStaffid(),sellprice2);
					
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("订单添加失败");
				}
				
			} else {
				
				throw new RuntimeException("价格不在区间范围内!");
			}
			
		return 1;
		
	}

}
