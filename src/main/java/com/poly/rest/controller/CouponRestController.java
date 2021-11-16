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

import com.poly.dao.CouponDao;
import com.poly.dao.DistrictDao;
import com.poly.dao.OrderDetailDao;
import com.poly.entity.Coupon;
import com.poly.entity.District;
import com.poly.entity.Orderdetail;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/coupon")
public class CouponRestController {

	@Autowired
	CouponDao dao;
	
	@GetMapping()
	public List<Coupon> getAllCoupon(){
		return dao.findAll();
	}
	
	@PostMapping()
	public Coupon createCoupon(@RequestBody Coupon coupon) {
		return dao.save(coupon);
	}
	
	@PutMapping("{code}")
	public Coupon updateCoupon(@PathVariable("code") String code,@RequestBody Coupon coupon) {
		return dao.save(coupon);
	}
}
