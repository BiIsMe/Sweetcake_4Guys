package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.dao.DistrictDao;
import com.poly.entity.District;


@CrossOrigin("*")
@RestController
@RequestMapping("/rest/district")
public class DistrictsRestController {
	@Autowired
	DistrictDao dao;
	
	@GetMapping()
	public List<District>getAll(){
		return dao.findAll();
	}
}
