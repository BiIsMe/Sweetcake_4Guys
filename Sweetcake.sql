CREATE DATABASE SWEETCAKE_4GUYS
GO
USE SWEETCAKE_4GUYS
GO

CREATE TABLE Categories (
	Id varchar(4) primary key,
	Name nvarchar(40) )
GO

CREATE TABLE Products (
	Id int identity(1,1) primary key,
	Name nvarchar(50),
	Price float,
	Quantity int,
	Available bit,
	Detail nvarchar(100),
	Photo varchar(30),
	Discount int,
	Categoryid varchar(4),
	Foreign key(Categoryid) References Categories(Id) )
GO

CREATE TABLE Accounts (
	Username varchar(30) primary key,
	Password varchar(50),
	Fullname nvarchar(80),
	Gender bit,
	Email varchar(50),
	Phone char(10),
	Dob date)
GO

CREATE TABLE Roles (
	Id varchar(4) primary key,
	Name nvarchar(20) )
GO

CREATE TABLE Authorities (
	Id int identity(1,1) primary key,
	Username varchar(30),
	Roleid varchar(4),
	Foreign key(Username) References Accounts(Username),
	Foreign key(Roleid) References Roles(Id) )
GO

CREATE TABLE Coupons (
	Code varchar(20) primary key,
	Value int,
	Quantity int,
	Active bit )
GO

CREATE TABLE Districts (
	Id int primary key,
	Name varchar(30),
	Shipfee float )
GO

CREATE TABLE Orders (
	 Id bigint identity(1,1) primary key,
	 CustomerId varchar(30),
	 Createdate date,
	 Phone char(10),
	 Address varchar(100),
	 District int,
	 Email varchar(50),
	 CouponCode varchar(20),
	 Price float,
	 Shipfee float,
	 PaymentMethod varchar(20),
	 PaymentStatus bit,
	 OrderStatus varchar(20),
	 StaffId varchar(30),
	 Foreign key(CustomerId) References Accounts(Username),
	 Foreign key(CouponCode) References Coupons(Code),
	 Foreign key(District) References Districts(Id) )
GO

CREATE TABLE OrderDetails (
	Id bigint identity(1,1) primary key,
	OrderId bigint,
	ProductId int,
	Quantity int,
	Price float,
	Discount int,
	Foreign key(Orderid) References Orders(Id),
	Foreign key(Productid) References Products(Id) )
GO

CREATE TABLE CouponUsed (
	Id bigint identity(1,1) primary key,
	CouponCode varchar(20),
	CustomerId varchar(30),
	Foreign key(CouponCode) References Coupons(Code),
	Foreign key(CustomerId) References Accounts(Username) )
GO

