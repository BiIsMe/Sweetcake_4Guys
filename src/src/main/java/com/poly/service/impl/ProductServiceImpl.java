package com.poly.service.impl;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.poly.entity.Product;
import com.poly.service.ProductService;
import com.poly.dao.ProductDao;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductDao pdao;

	@Override
	public List<Product> findAll() {
		return pdao.findAll();
	}

	@Override
	public Product findById(Integer id) {
		return pdao.findById(id).get();
	}

	@Override
	public List<Product> findAllByCate(String cid) {
		return null;
	}

	@Override
	public Page<Product> findAllByCate(String string, Pageable pageable) {
		// TODO Auto-generated method stub
		return null;
	}
}