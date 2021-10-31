package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Orderdetail;

public interface OrderDetailDao extends JpaRepository<Orderdetail, Long> {

	@Query("select o from Orderdetail o where o.order.id=?1")
	public List<Orderdetail> findByOrder(long id);
}
