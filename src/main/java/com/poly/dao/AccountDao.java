package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Account;

public interface AccountDao extends JpaRepository<Account, String> {

	@Query("select a from Account a where a.role = ?1")
	List<Account> findByRole(String role);
}
