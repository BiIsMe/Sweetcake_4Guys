package com.poly.site.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("sweetcake.com")
	public String siteIndex() {
		return "redirect:/product/list";
	}
}
