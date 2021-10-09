package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.CouponUsed;

public interface CouponUsedDao extends JpaRepository<CouponUsed, Long> {

}
