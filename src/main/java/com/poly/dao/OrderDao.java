package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Chart;
import com.poly.entity.Order;

public interface OrderDao extends JpaRepository<Order, Long> {
	@Query("select o from Order o where o.account.username=?1 order by o.id desc")
	List<Order> findByUsername(String username);

	@Query("select o from Order o where o.account.username=?1 order by o.id desc")
	List<Order> findByUser(String username);

	@Query(value = "select * from Orders where createdate >=?1 and createdate<=?2 and orderstatus like ?3"
			+ " order by id desc",nativeQuery = true)
	List<Order> findByDate(String from, String to, String status);
	
	@Query(value = "select "
			+ "	concat(Day(CreateDate),'/',Month(createdate)) as 'time' , "
			+ "	Left(sum(price),len(sum(price))-3) as 'revenue' , "
			+ "	count(*) as 'order' "
			+ " from Orders "
			+ " where createdate >= ?1 and createdate<= ?2 and OrderStatus='completed' "
			+ " group by createdate", nativeQuery = true)
	List<?> revenueByDate(String from, String to);
	
	
	@Query(value = "select "
			+ "	concat(Month(CreateDate),'/',Year(createdate)) as 'time' , "
			+ "	Left(sum(price),len(sum(price))-3) as 'revenue' , "
			+ "	count(*) as 'order' "
			+ " from Orders "
			+ " where Month(createdate) >= ?1 and Month(createdate) <= ?2 and year(createdate) >= ?3 "
			+ " and year(createdate) <= ?4 and OrderStatus='completed' "
			+ " group by concat(Month(CreateDate),'/',Year(createdate))", nativeQuery = true)
	List<?> revenueByMonth(String mF, String yF, String mT, String yT);
	
}
