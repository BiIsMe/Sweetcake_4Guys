package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.dao.DistrictDao;
import com.poly.dao.OrderDetailDao;
import com.poly.entity.District;
import com.poly.entity.Orderdetail;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/district")
public class DistrictRestController {

	@Autowired
	DistrictDao dao;
	
	@GetMapping()
	public List<District> getDistrictAll(){
		return dao.findAll();
	}
	
	@GetMapping("{id}")
	public District getDistrict(@PathVariable("id") Integer id){
		return dao.findById(id).get();
	}
	
	@PutMapping("{id}")
	public District updateDistrict(@PathVariable("id") Integer id,@RequestBody District dist) {
		return dao.save(dist);
	}
}
