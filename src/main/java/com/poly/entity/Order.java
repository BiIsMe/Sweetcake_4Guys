package com.poly.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@SuppressWarnings("serial")
@Data
@AllArgsConstructor @NoArgsConstructor
@Entity @Table(name="Orders")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Date createdate = new Date();
	
	private String phone;
	private String address;
	private String email;
	private Double price;
	private Double shipfee;
	private String paymentmethod;
	private String orderstatus;
	private String staffid;
	
	@ManyToOne
	@JoinColumn(name="customerid")
	private Account account;
	
	@ManyToOne
	@JoinColumn(name="couponcode")
	private Coupon coupon;
	
	@ManyToOne
	@JoinColumn(name="district")
	private District district;
	
	@JsonIgnore
	@OneToMany(mappedBy = "order")
	private List<Orderdetail>orderdetails;
	
}
