package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.Orderdetail;

public interface OrderDetailDao extends JpaRepository<Orderdetail, Long> {

}
