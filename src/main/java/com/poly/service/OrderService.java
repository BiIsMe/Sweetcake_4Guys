package com.poly.service;

import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.poly.entity.Order;

public interface OrderService {

	Order create(JsonNode order);

	Order findById(Long id);

	List<Order> findByUser(String username);

	public void save(Order order);




}
