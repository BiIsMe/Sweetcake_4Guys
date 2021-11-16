package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.dao.AccountDao;
import com.poly.entity.Account;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/account")
public class AccountRestController {

	@Autowired
	AccountDao dao;
	
	@GetMapping("/staff")
	public List<Account> findAllStaff() {
		return dao.findByRole("Staff");
	}
	
	@GetMapping("/customer")
	public List<Account> findAllCustomer(){
		return dao.findByRole("Cust");
	}
	
	@PostMapping("/staff")
	public Account createStaff(@RequestBody Account acc) {
		return dao.save(acc);
	}
	
	@PutMapping("/staff/{id}")
	public Account updateStaff(@PathVariable("id") String id, @RequestBody Account acc) {
		return dao.save(acc);
	}
}
