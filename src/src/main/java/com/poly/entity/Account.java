package com.poly.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
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
@Entity @Table(name="Accounts")
public class Account implements Serializable{

	@Id
	private String username;
	private String password;
	private String fullname;
	private Boolean gender;
	private String email;
	private String phone;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	private Date dob;
	
	@JsonIgnore
	@OneToMany(mappedBy = "account")
	private List<Authority> authorities;
	
	@JsonIgnore
	@OneToMany(mappedBy = "account")
	private List<Order> orders;
	
	
	
}
