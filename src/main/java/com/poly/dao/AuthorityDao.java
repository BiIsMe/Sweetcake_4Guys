package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.Authority;

public interface AuthorityDao extends JpaRepository<Authority, Integer> {

}
