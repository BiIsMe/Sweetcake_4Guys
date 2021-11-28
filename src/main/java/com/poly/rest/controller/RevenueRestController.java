package com.poly.rest.controller;

import java.util.ArrayList;
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
import com.poly.dao.OrderDao;
import com.poly.dao.OrderDetailDao;
import com.poly.entity.Chart;
import com.poly.entity.District;
import com.poly.entity.Orderdetail;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/revenue")
public class RevenueRestController {

	@Autowired
	OrderDao dao;
	
	@GetMapping("/date/{from}/{to}")
	public List<Chart> getRevenueByDate(@PathVariable("from") String from,@PathVariable("to") String to) {
		List<Chart> list = new ArrayList<Chart>();
		List<Object[]> result =  (List<Object[]>) dao.revenueByDate(from, to);
		if(result != null && !result.isEmpty()) {
			for(Object[] object : result) {
				Chart chart = new Chart(object[0], object[1], object[2]);
				list.add(chart);
			}
		}
		return list;
	}
	

	@GetMapping("/month/{mF}/{yF}/{mT}/{yT}")
	public List<Chart> getRevenueByDate(@PathVariable("mF") String mF,@PathVariable("yF") String yF,
							@PathVariable("mT") String mT, @PathVariable("yT") String yT) {
		List<Chart> list = new ArrayList<Chart>();
		List<Object[]> result =  (List<Object[]>) dao.revenueByMonth(mF, yF, mT, yT);
		if(result != null && !result.isEmpty()) {
			for(Object[] object : result) {
				Chart chart = new Chart(object[0], object[1], object[2]);
				list.add(chart);
			}
		}
		return list;
	}
}
