package com.poly.service;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.data.domain.Page;

import com.poly.entity.Product;

public interface ProductService {

	List<Product> findAll();

	List<Product> findAllByCate(String cid);

	Page<Product> findAllByCate(String string, Pageable pageable);

}
