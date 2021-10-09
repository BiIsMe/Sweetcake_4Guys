package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.Product;




public interface ProductDao extends JpaRepository<Product, Integer> {
	
}
