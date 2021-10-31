package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.dao.OrderDetailDao;
import com.poly.entity.Orderdetail;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/orderdetails")
public class OrderdetaiRestController {

	@Autowired
	OrderDetailDao dao;
	
	@GetMapping("{id}")
	public List<Orderdetail> getAll(@PathVariable("id") Long id){
		return dao.findByOrder(id);
	}
}
