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
@Entity @Table(name="Districts")
public class District implements Serializable {

	@Id
	private Integer id;
	private String name;
	private Double shipfee;
	
	@JsonIgnore
	@OneToMany(mappedBy = "district")
	private List<Order> orders;
	
}
