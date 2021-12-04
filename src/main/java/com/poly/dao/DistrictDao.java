package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.District;

public interface DistrictDao extends JpaRepository<District, Integer> {

	@Query(value = "select * from Districts where available = 'True'", nativeQuery = true)
	List<District> findAllTrue();
}
