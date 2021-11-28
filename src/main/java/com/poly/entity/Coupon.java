package com.poly.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
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
@Entity @Table(name="Coupons")
public class Coupon implements Serializable {

	@Id
	private String code;
	private Integer value;
	private Integer quantity;
	private Boolean active;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	private Date createdate;
	private Boolean category;
	
	@JsonIgnore
	@OneToMany(mappedBy = "coupon")
	private List<Order> orders;
	
	@ManyToOne
	@JoinColumn(name = "customerid")
	private Account account;
	
	
}
