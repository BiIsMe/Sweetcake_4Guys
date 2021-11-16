package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.dao.ProductDao;
import com.poly.entity.Product;
import com.poly.service.ProductService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/product")
public class ProductRestController {

	@Autowired
	ProductService psv;
	@Autowired
	ProductDao dao;
	
	@GetMapping("{id}")
	public Product getOne(@PathVariable("id")Integer id) {
		return psv.findById(id);
	}
	
	@GetMapping()
	public List<Product> getAll(){
		return dao.findAll();
	}
	@PostMapping()
	public Product create(@RequestBody Product prod) {
		return dao.save(prod);
	}
	
	@PutMapping("{id}")
	public Product update(@PathVariable("id") Integer id, @RequestBody Product prod) {
		return dao.save(prod);
	}
	
	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") Integer id) {
		dao.deleteById(id);;
	}
	
	@GetMapping("name/{name}")
	public List<Product> findByName(@PathVariable("name") String name) {
		if(name.equals("all")) {
			return dao.findByName("%%");
		}
		else
			return dao.findByName("%"+name+"%");
	}
	
	//count products by Category
	@GetMapping("/count/{id}")
	public Long countProdByCate(@PathVariable("id") String id) {
		return dao.countProductsByCategory(id);
	}
}
