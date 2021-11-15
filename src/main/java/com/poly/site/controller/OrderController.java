 package com.poly.site.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderController {
	@RequestMapping("order/checkout")
		public String checkout() {
			return "sites/order/checkout.html";
		}
	@RequestMapping("order/list")
		public String List() {
		return "order/list";
	}
	@RequestMapping("/order/detail/{id}")
	public String detail() {
		return "order/detail";
	}
}
