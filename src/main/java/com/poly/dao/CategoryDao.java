package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Category;



public interface CategoryDao extends JpaRepository<Category, String> {
	
	
}