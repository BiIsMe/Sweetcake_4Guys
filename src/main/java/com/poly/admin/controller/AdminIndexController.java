package com.poly.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sweetcake.com")
public class AdminIndexController {

	@RequestMapping("/admin")
	public String adminIndex() {
		return "admins/index";
	}
}
