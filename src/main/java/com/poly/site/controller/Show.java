package com.poly.site.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.dao.ProductDao;
import com.poly.entity.Product;

@Controller
public class Show {
	@Autowired
	ProductDao dao;

	@RequestMapping("layout/show")
	public String Show(Model model, @RequestParam("p") Optional<Integer> p){
		Pageable pageable = PageRequest.of(p.orElse(0), 9);
		Page<Product> bestSale = dao.findBestSaleInDex(pageable);
		model.addAttribute("sale", bestSale);
		return "sites/layout/show.html";
	}

	
}
