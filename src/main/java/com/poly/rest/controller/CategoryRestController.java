package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
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
}
