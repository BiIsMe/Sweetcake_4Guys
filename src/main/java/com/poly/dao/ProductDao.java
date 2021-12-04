package com.poly.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Product;

public interface ProductDao extends JpaRepository<Product, Integer> {
	@Query("select p from Product p where p.category.id=?1")
	Page<Product> findAllByCate(String cid,Pageable page);
	
	@Query("SELECT o FROM Product o WHERE o.name LIKE ?1")
	Page<Product> findByKeywords(String keywords, Pageable pageable);

	@Query("SELECT o FROM Product o WHERE o.price BETWEEN ?1 AND ?2")
	Page<Product> findByPrice(double minPrice, double maxPrice, Pageable pageable);


	@Query("select p from Product p where p.name like ?1")
	List<Product> findByName(String name);

	
	@Query(value="select count(*) from products where categoryid like ?1 ", nativeQuery = true)
	Long countProductsByCategory(String category);
	
	@Query(value= "select * from products\r\n"
			+ "where id in ( \r\n"
			+ "select top 5 productid from orderdetails group by productid order by sum(quantity) desc )", nativeQuery = true)			 		
	Page<Product> findBestSale(Pageable pageable);
	
	@Query(value= "select * from products\r\n"
			+ "where id in ( \r\n"
			+ "select top 8 productid from orderdetails group by productid order by sum(quantity) desc )", nativeQuery = true)			 		
	Page<Product> findBestSaleInDex(Pageable pageable);
}
