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

import com.poly.dao.CategoryDao;
import com.poly.entity.Category;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/category")
public class CategoryRestController {

	@Autowired
	CategoryDao dao;
	
	@GetMapping()
	public List<Category> getAll(){
		return dao.findAll();
	}
	
	@PostMapping()
	public Category createCate(@RequestBody Category cate) {
		return dao.save(cate);
	}
	
	@PutMapping("{id}")
	public Category updateCate(@PathVariable("id") String id, @RequestBody Category cate) {
		return dao.save(cate);
	}
	
	
}
