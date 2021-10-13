package com.poly.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.AccountDao;
import com.poly.entity.Account;
import com.poly.service.AccountService;
@Service
public class AccountServiceImpl implements AccountService{
	@Autowired
	AccountDao accDao;
	
	@Override
	public Account findById(String username) { 
		return accDao.findById(username).get(); 
	}


	 
}
