package com.poly.site.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@RequestMapping("sweetcake1.com")
	public String signIn() {
		return "sites/login.html";
	}
	
	@RequestMapping("sweetcake2.com")
	public String create() {
		return "sites/createAccount.html";
	}
}
