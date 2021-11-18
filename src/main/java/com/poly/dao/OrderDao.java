package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Order;

public interface OrderDao extends JpaRepository<Order, Long> {
	@Query("select o from Order o where o.account.username=?1 order by o.id desc")
	List<Order> findByUsername(String username);

}
