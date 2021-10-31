package com.poly.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.AccountDao;
import com.poly.entity.Account;
import com.poly.service.AccountService;

@Service
public class AccountServiceImp implements AccountService {

	@Autowired
	AccountDao dao;

	@Override
	public Account findById(String username) {
		return dao.findById(username).get();
	}
	
	
}
