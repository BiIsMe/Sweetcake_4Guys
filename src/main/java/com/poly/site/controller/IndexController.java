package com.poly.site.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Account;
import com.poly.entity.Product;
import com.poly.dao.ProductDao;
import com.poly.service.SessionService;

@Controller
@RequestMapping("sweetcake.com")
public class IndexController {
	
	@Autowired
	ProductDao dao;
	
	@Autowired
	SessionService session;
	
	@RequestMapping("")
	public String siteIndex() {
		return "redirect:/layout/show";
	}
	
	@RequestMapping("product/list")
	public String paginate(Model model,	
			@RequestParam("p") Optional<Integer> p,
			@RequestParam("cid") Optional<String> cid,
			@RequestParam("keywords") Optional<String> kw) {
		
		String keywords = kw.orElse(session.get("keywords", ""));
		session.set("keywords", keywords);
		
		Pageable pageable = PageRequest.of(p.orElse(0), 9);
		Page<Product> bestSale = dao.findBestSale(pageable);
			model.addAttribute("sale", bestSale);
		
		if (cid.isPresent()) {
			Page<Product> list = dao.findAllByCate(cid.get(), pageable);
			model.addAttribute("page", list);
		} else {
			Page<Product> list = dao.findAll(pageable);
			model.addAttribute("page", list);
		}
		return "sites/product/list.html";
	}
	
	@RequestMapping("price")
	public String searchGia(Model model,
			@RequestParam("min") Optional<Double> min,
			@RequestParam("max") Optional<Double> max, @RequestParam("p") Optional<Integer> p) {
		
		double minPrice = min.orElse(Double.MIN_VALUE);
		double maxPrice = max.orElse(Double.MAX_VALUE);
		
		Pageable pageable = PageRequest.of(p.orElse(0), 9);
		Page<Product> page = dao.findByPrice(minPrice, maxPrice, pageable);
		int currentPage =1;
		int totalItems = page.getNumberOfElements();
		int totalPages = page.getTotalPages();
		model.addAttribute("totalItems", totalItems);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("page", page);
		
		return "sites/product/list.html";

	}
	
	@RequestMapping("search")
	public String search(Model model,	
			@RequestParam("p") Optional<Integer> p,
			@RequestParam("keywords") Optional<String> kw) {
		
		String keywords = kw.orElse(session.get("keywords", ""));
		session.set("keywords", keywords);
		
		Pageable pageable = PageRequest.of(p.orElse(0), 9);
		
			Page<Product> page = dao.findByKeywords("%"+keywords+"%", pageable);
			int currentPage =1;
			int totalItems = page.getNumberOfElements();
			int totalPages = page.getTotalPages();
			model.addAttribute("totalItems", totalItems);
			model.addAttribute("totalPages", totalPages);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("page", page);
		
		return "sites/product/list.html";
	}
	
	@RequestMapping("product/detail/{id}")
	public String pdetail(Model model, @PathVariable("id") Integer id) {
		Product prod = dao.findById(id).get();
		model.addAttribute("item", prod);
		return "sites/product/detail.html";
	}
	
	@RequestMapping("sub/contact")
	public String contact() {
		return "sites/sub/contact.html";
	}
	@RequestMapping("sub/aboutUs")
	public String aboutUs() {
		return "sites/sub/aboutUs.html";
	}
	
}
