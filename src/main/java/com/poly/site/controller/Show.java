package com.poly.site.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Show {
	

	@RequestMapping("layout/show")
	public String Show(){
		return "sites/layout/show.html";
	}

	
}
