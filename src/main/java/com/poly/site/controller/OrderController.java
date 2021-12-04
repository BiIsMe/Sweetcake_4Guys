 package com.poly.site.controller;

 import java.util.Optional;

 import javax.servlet.http.HttpServletRequest;

 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.data.domain.Page;
 import org.springframework.data.domain.PageRequest;
 import org.springframework.data.domain.Pageable;
 import org.springframework.stereotype.Controller;
 import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
 import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.dao.OrderDao;
 import com.poly.entity.Order;
 import com.poly.service.OrderService;

@Controller
public class OrderController {
	@Autowired
	OrderService orderService;
	
	@Autowired
	OrderDao dao;
	
	@RequestMapping("order/checkout")
		public String checkout() {
			return "sites/order/checkout.html";
		}
	@RequestMapping("order/list")
	public String List(Model model,
			@RequestParam("order") Optional<Integer> order,
			HttpServletRequest request) {
	Pageable pageable = PageRequest.of(order.orElse(0), 5);
	Page<Order> page = dao.findAll(pageable);
	model.addAttribute("page", page);
	String username = request.getRemoteUser();
	model.addAttribute("orders",orderService.findByUser(username));
	return "sites/order/list";
	}
	@RequestMapping("/order/detail/{id}")
	public String detail(@PathVariable("id")Long id, Model model) {
		model.addAttribute("order",orderService.findById(id));
		return "sites/order/detail";
	}
	@PostMapping("/order/updateStatuss")
	public String updateStatus(Order order,BindingResult result, RedirectAttributes model) {
		if (result.hasErrors()) {
			return "sites/order/detail";
		}
		orderService.save(order);
		model.addFlashAttribute("success", "Đơn hàng đã hủy!");
		return "sites/order/detail";
		
	}
}
