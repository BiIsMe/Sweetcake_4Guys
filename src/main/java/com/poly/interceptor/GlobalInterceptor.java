package com.poly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.poly.dao.CategoryDao;

@Component
public class GlobalInterceptor implements HandlerInterceptor{
	@Autowired
	CategoryDao dao;
	
	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		req.setAttribute("cates", dao.findAll());
		
	}

}