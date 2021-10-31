package com.poly.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Product;




public interface ProductDao extends JpaRepository<Product, Integer> {
	@Query("select p from Product p where p.category.id=?1")
	Page<Product> findAllByCate(String cid,Pageable page);

	@Query("select p from Product p where p.name like ?1")
	List<Product> findByName(String name);
}
