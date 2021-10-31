package com.poly.rest.controller;


import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.poly.dao.OrderDao;
import com.poly.entity.Order;
import com.poly.entity.Product;
import com.poly.service.OrderService;
import com.poly.service.ProductService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/order")
public class OrderRestController {

	@Autowired
	OrderService osv;
	@Autowired
	OrderDao dao;
	
	@GetMapping()
	public List<Order> getAll(){
		Sort sort = Sort.by(Direction.DESC,"id");
		return dao.findAll(sort);
	}
	
	@PostMapping()
	public Order create(@RequestBody JsonNode order) {
		return osv.create(order);
	}
	
	@GetMapping("{id}")
	public Order findbyId(@PathVariable("id") long id) {
		return dao.findById(id).get();
	}
	
	@PutMapping("{id}")
	public Order update(@PathVariable("id") long id, @RequestBody Order order) {
		return dao.save(order);
	}
	
	@GetMapping("{from}/{to}/{status}")
	public List<Order> findByDate(@PathVariable("from") String from,@PathVariable("to") String to,
			@PathVariable("status") String status){
		if(status.equals("all"))
			status = "%%";
		return dao.findByDate(from,to,status);
	}
}
