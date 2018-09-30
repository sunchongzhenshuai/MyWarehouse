package com.st.rbac.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


/**
 * 过滤用户登录, 进行验证
 * 
 * HandlerInterceptor接口 SpringMVC的拦截器
 * 
 */
public class RoleInterceptor implements HandlerInterceptor{

	@Override
	/**
	 * 请求执行完时调用
	 */
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	/**
	 * 返回视图时, 调用该方法
	 */
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	/**
	 * 需要被拦截的请求Contoller执行之前, 执行该方法
	 * 
	 * 当该方法返回false时, 请求被拦截, 
	 * 当该方法返回true时, 请求放行.
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("权限验证");
		
		//1.取出当前的请求地址	*.action
		String url = request.getRequestURI();
		System.out.println(url);
		// /RBAC/role/Product/addproduct.action
		url = url.substring(url.indexOf("role/"));
		//2.查询权限的匹配
		System.out.println(url);
		HttpSession session = request.getSession();
		Map<String, String> accesses = (Map<String, String>) session.getAttribute("accesses");
		//String url2 = "role/Product/addview.action";
		System.out.println(accesses.get(url));
		String urlname = accesses.get(url);
		
		
		if (urlname == null) {
			//3..如果没有权限跳转到一个提示页面
			response.sendRedirect("../../accesserror.jsp");
			return false;
		}
		//4..如果有权限 放行
		return true;
	}

}
