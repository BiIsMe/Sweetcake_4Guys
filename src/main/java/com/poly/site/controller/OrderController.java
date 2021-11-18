 package com.poly.site.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.service.OrderService;

@Controller
public class OrderController {
	@Autowired
	OrderService orderService;
	
	@RequestMapping("order/checkout")
		public String checkout() {
			return "sites/order/checkout.html";
		}
	@RequestMapping("order/list")
		public String List(Model model, HttpServletRequest request) {
		String username = request.getRemoteUser();
		model.addAttribute("orders",orderService.findByUsername(username));
		return "sites/order/list";
	}
	@RequestMapping("/order/detail/{id}")
	public String detail(@PathVariable("id")Long id, Model model) {
		model.addAttribute("order",orderService.findById(id));
		return "sites/order/detail";
	}
}