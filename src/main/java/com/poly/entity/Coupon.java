package com.poly.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@SuppressWarnings("serial")
@Data
@AllArgsConstructor @NoArgsConstructor
@Entity @Table(name="Coupons")
public class Coupon implements Serializable {

	@Id
	private String code;
	private Integer value;
	private Integer quantity;
	private Boolean active;
	
	@JsonIgnore
	@OneToMany(mappedBy = "coupon")
	private List<Order> orders;
	
	@JsonIgnore
	@OneToMany(mappedBy = "coupon")
	private List<CouponUsed> couponUsed;
	
}
