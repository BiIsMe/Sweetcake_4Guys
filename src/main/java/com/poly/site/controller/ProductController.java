package com.poly.site.controller;

import java.util.List;
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

import com.poly.dao.ProductDao;
import com.poly.entity.Product;
import com.poly.service.ProductService;
import com.poly.service.SessionService;

@Controller
public class ProductController {
	@Autowired
	ProductDao dao;
	@Autowired
	SessionService session;

	@RequestMapping("product/list")
	public String plist(Model model, @RequestParam("cid") Optional<String> cid, @RequestParam("p") Optional<Integer> pg,
			@RequestParam("keyword") Optional<String> kw) {
		String kwords = kw.orElse(session.get("keywords", ""));
		session.set("keywords", kwords);
		Pageable pageable = (Pageable) PageRequest.of(pg.orElse(0), 9);
		Page<Product> page = dao.findByKeywords("%" + kwords + "%", pageable);
		if (cid.isPresent()) {
			Page<Product> list = dao.findAllByCate(cid.get(), pageable);
			model.addAttribute("page", list);
		} else {
			Page<Product> list = dao.findAll(pageable);
			model.addAttribute("page", list);
		}
		return "sites/product/list.html";
	}

	@RequestMapping("product/detail/{id}")
	public String pdetail(Model model, @PathVariable("id") Integer id) {
		Product prod = dao.findById(id).get();
		model.addAttribute("item", prod);
		return "sites/product/detail.html";
	}
}
