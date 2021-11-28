CREATE DATABASE SWEETCAKE_4GUYS
GO
USE SWEETCAKE_4GUYS
GO

CREATE TABLE Categories (
	Id int identity(1,1) primary key,
	Name nvarchar(40) not null )
GO

CREATE TABLE Products (
	Id int identity(1,1) primary key,
	Name nvarchar(50) not null,
	Price float not null,
	Quantity int not null,
	Available bit ,
	Detail nvarchar(100),
	Photo varchar(30),
	Categoryid int not null,
	Createdate date,
	Foreign key(Categoryid) References Categories(Id) )
GO

CREATE TABLE Accounts (
	Username varchar(30) primary key,
	Password varchar(50) not null,
	Fullname nvarchar(50),
	Gender bit,
	Phone char(10),
	Dob date,
	Active bit,
	Role varchar(5) not null )				/*3 role : cust, staff, dire */
GO


CREATE TABLE Coupons (
	Code varchar(20) primary key,
	Value int not null,
	Quantity int,					/* dành cho voucher group, quantity = 0 thì mã ko được sử dụng nữa */
	Active bit,
	Createdate date, 
	Category bit not null,					/*2 loại : group (true-1) , private (false-0) */
	Customerid varchar(30),			/* dành cho private, xác định khách hàng cụ thể cho coupon đó */
	Foreign key (Customerid) references Accounts(Username) )
GO

CREATE TABLE Districts (
	Id int identity(1,1) primary key,
	Name nvarchar(30) not null,
	Shipfee float,
	Available bit)
GO

CREATE TABLE Orders (
	 Id bigint identity(1,1) primary key,
	 CustomerId varchar(30) not null,			/* này ko hiện lên form chỗ đặt order, nhưng bắt buộc phải lưu vào database, vì là khóa phụ để kết nối tìm kiếm */
	 CreateDate date not null,
	 RecipientName nvarchar(50) not null,		/* tên người nhận, phải có field cho khách nhập như địa chỉ */
	 Phone char(10) not null,
	 Address nvarchar(100) not null,
	 District int not null,
	 Email varchar(50),
	 CouponCode varchar(20),
	 Price float not null,
	 Shipfee float,
	 PaymentMethod varchar(20),
	 PaymentStatus bit,
	 OrderStatus varchar(20),
	 WhoCancel bit,					/* nếu do khách hủy : true-1, bên nhân viên hủy : false -0 */
	 Reason nvarchar(100),			/*lý do hủy*/
	 StaffId varchar(30),			/*nếu do nhân viên hủy thì lưu user của nhân viên vào */
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
	Foreign key(Orderid) References Orders(Id),
	Foreign key(Productid) References Products(Id) )
GO

SET IDENTITY_INSERT [dbo].[Categories] ON
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (1, N'Cupcake')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (2, N'Chocolate')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (3, N'Birthday Cake')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (4, N'Bread')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (5, N'Cookies')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (6, N'Rau câu 3D')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO

SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (1, N'Bánh kem sắc màu', 499000, 10, 1, N'Bánh kem 1', N'birthday1.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (2, N'Bánh kem dâu', 399000, 10, 1, N'Bánh kem 2', N'birthday2.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (3, N'Bánh kem ngọt ngào', 449000, 10, 1, N'Bánh kem 3', N'birthday3.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (4, N'Bánh kem chocolate', 299000, 10, 1, N'Bánh kem 4', N'birthday4.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (5, N'Bánh kem thường', 249000, 10, 1, N'Bánh kem 5', N'birthday5.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (6, N'Bánh kem tình yêu', 499000, 10, 1, N'Bánh kem 6', N'birthday6.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (7, N'Bánh kem hạnh nhân', 399000, 10, 1, N'Bánh kem 7 ', N'birthday7.jpg', 3, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (8, N'Bread khoai', 149000, 10, 1, N'Bread 1', N'bread1.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (9, N'Bread tươi 1', 99000, 10, 1, N'Bread 2', N'bread2.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (10, N'Bread tươi 2', 99000, 10, 1, N'Bread 3', N'bread3.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (11, N'Bread tươi 4', 79000, 10, 1, N'Bread 4', N'bread4.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (12, N'Bread tươi 5', 99000, 10, 1, N'Bread 5', N'bread5.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (13, N'Bread tươi 6', 79000, 10, 1, N'Bread 6', N'bread6.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (14, N'Bread tươi 7', 59000, 10, 1, N'Bread 7 ', N'bread7.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (15, N'Bread tươi 8', 39000, 10, 1, N'Bread 8 ', N'bread8.jpg', 4, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (16, N'Chocolate 1', 89000, 10, 1, N'Chocolate 1', N'chocolate1.jpg', 2, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (17, N'Chocolate 2 ', 199000, 10, 1, N'Chocolate 2', N'chocolate2.jpg', 2, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (18, N'Chocolate 3', 249000, 10, 1, N'Chocolate 3', N'chocolate3.jpg', 2, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (19, N'Chocolate 4', 249000, 10, 1, N'Chocolate 4', N'chocolate4.jpg', 2, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (20, N'Chocolate 5', 129000, 10, 1, N'Chocolate 5', N'chocolate5.jpg', 2, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (21, N'Chocolate 6', 79000, 10, 1, N'Chocolate 6', N'chocolate6.jpg', 2, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (22, N'Cookies 1', 29000, 10, 1, N'Cookies 1', N'cookies1.jpg', 5, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (23, N'Cookies 2 ', 39000, 10, 1, N'Cookies 2', N'cookies2.jpg', 5, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (24, N'Cookies 3', 39000, 10, 1, N'Cookies 3', N'cookies3.jpg', 5, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (25, N'Cookies 4 ', 19000, 10, 1, N'Cookies 4', N'cookies4.jpg', 5, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (26, N'Cookies 5', 19000, 10, 1, N'Cookies 5', N'cookies5.jpg', 5, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (27, N'Cupcake 1', 49000, 10, 1, N'Cupcake 1', N'cupcake1.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (28, N'Cupcake 2', 49000, 10, 1, N'Cupcake 2', N'cupcake2.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (29, N'Cupcake 3', 49000, 10, 1, N'Cupcake 3', N'cupcake3.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (30, N'Cupcake 4', 69000, 10, 1, N'Cupcake 4', N'cupcake4.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (31, N'Cupcake 5', 49000, 10, 1, N'Cupcake 5', N'cupcake5.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (32, N'Cupcake 6 ', 69000, 10, 1, N'Cupcake 6', N'cupcake6.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (33, N'Cupcake 7', 59000, 10, 1, N'Cupcake 7', N'cupcake7.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (34, N'Cupcake 8', 89000, 10, 1, N'Cupcake 8', N'cupcake8.jpg ', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (35, N'Cupcake 9 ', 79000, 10, 1, N'Cupcake 9', N'cupcake9.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (36, N'Cupcake 10', 79000, 10, 1, N'Cupcake 10', N'cupcake10.jpg', 1, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (37, N'Rau câu 3D 1', 299000, 10, 1, N'Rau câu 1', N'raucau1.jpg', 6, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (38, N'Rau câu 3D 2', 399000, 10, 1, N'Rau câu 2 ', N'raucau2.jpg', 6, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (39, N'Rau câu 3D 3', 399000, 10, 1, N'Rau câu 3', N'raucau3.jpg', 6, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (40, N'Rau câu 3D 4 ', 79000, 10, 1, N'Rau câu 4', N'raucau4.jpg', 6, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (41, N'Rau câu 3D 5', 79000, 10, 1, N'Rau câu 5', N'raucau5.jpg', 6, CAST(N'2021-11-11' AS Date))
INSERT [dbo].[Products] ([Id], [Name], [Price], [Quantity], [Available], [Detail], [Photo], [Categoryid], [Createdate]) VALUES (42, N'Rau câu 3D 6 ', 199000, 10, 1, N'Rau câu 6 ', N'raucau6.jpg', 6, CAST(N'2021-11-11' AS Date))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO

SET IDENTITY_INSERT [dbo].[Districts] ON 

INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (1, N'Quận 1', 12000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (2, N'Quận 2', 18000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (3, N'Quận 3', 0, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (4, N'Quận 4', 10000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (5, N'Quận 5', 10000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (6, N'Quận 6', 20000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (7, N'Quận 7', 12000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (8, N'Quận 8', 12000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (9, N'Quận 9', 15000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (10, N'Quận 10', 12000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (11, N'Quận 11', 12000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (12, N'Quận 12', 12000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (13, N'Quận Bình Thạnh', 20000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (14, N'Quận Gò Vấp', 10000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (15, N'Quận Phú Nhuận', 10000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (16, N'Quận Tân Bình', 0, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (17, N'Quận Tân Phú', 10000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (18, N'Quận Bình Tân', 10000, 1)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (19, N'Huyện Nhà Bè', 20000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (20, N'Huyện Hóc Môn', 20000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (21, N'Huyện Bình Chánh', 20000, 0)
INSERT [dbo].[Districts] ([Id], [Name], [Shipfee], [Available]) VALUES (22, N'Thủ Đức', 15000, 0)
SET IDENTITY_INSERT [dbo].[Districts] OFF
GO

INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'direc01', N'12345', NULL, 1, NULL, CAST(N'1998-07-01' AS Date), 1, N'DIRE')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'direc02', N'12345', NULL, 0, NULL, CAST(N'2001-10-18' AS Date), 1, N'DIRE')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff01', N'12345678', N'Mã Văn', 1, NULL, CAST(N'2021-11-26' AS Date), 1, N'Staff')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff02', N'12345', N'Nguyễn Văn Tèo', 0, NULL, CAST(N'2000-04-12' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff03', N'12345', N'Tấn C', 0, N'0907337764', CAST(N'1998-07-01' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff04', N'12345', N'Tôn Tằng Tôn Nữ Tôn Thị', 1, NULL, CAST(N'1999-12-20' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff05', N'12345', N'Đăng E', 0, N'0908080708', CAST(N'2000-04-12' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff06', N'12345', N'Rồi F', 1, NULL, CAST(N'2001-10-18' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff07', N'12345', N'Tới G', 1, NULL, CAST(N'1998-07-01' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff08', N'12345', N'Nhơ Q', 0, NULL, CAST(N'2001-10-18' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff09', N'12345', N'Chung R', 0, NULL, CAST(N'2000-04-12' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff10', N'12345', N'Liền S', 0, N'0907337764', CAST(N'1999-12-20' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff11', N'12345', N'Tung T', 1, NULL, CAST(N'1998-07-01' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff12', N'12345', N'Hoành U', 1, N'0908080708', CAST(N'2000-04-12' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff13', N'12345', N'Ngang V', 0, NULL, CAST(N'1999-12-20' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff14', N'12345', N'Lại H', 1, NULL, CAST(N'2000-04-12' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff15', N'12345', N'Sau I', 0, N'0908080708', CAST(N'1999-12-20' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff17', N'12345', N'Tiếp K', 0, NULL, CAST(N'2000-04-12' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff18', N'12345', N'Nối L', 0, N'0907337764', CAST(N'2001-10-18' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff19', N'12345', N'Trước M', 1, NULL, CAST(N'1999-12-20' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff20', N'12345', N'Sau N', 1, N'0907337764', CAST(N'2000-04-12' AS Date), 1, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff21', N'12345', N'Kéo O', 0, NULL, CAST(N'1998-07-01' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'staff22', N'12345', N'Tấp P', 1, N'0908080708', CAST(N'1999-12-20' AS Date), 0, N'STAFF')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'tan@gmail.com', N'12345678', N'Châu Tấn', 1, NULL, CAST(N'2021-11-26' AS Date), 1, N'Staff')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'user01', '12345678', NULL, NULL, NULL, NULL, 0, N'CUST')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'user02', '12345678', NULL, NULL, NULL, NULL, 1, N'CUST')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'user03', '12345678', NULL, NULL, N'0908080809', NULL, 0, N'CUST')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'user04', '12345678', NULL, NULL, NULL, NULL, 1, N'CUST')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'user05', '12345678', NULL, NULL, N'0748756789', NULL, 0, N'CUST')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Gender], [Phone], [Dob], [Active], [Role]) VALUES (N'user06', '12345678', NULL, NULL, NULL, NULL, 1, N'CUST')
GO

INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'CHRISTMAS21', 10, 15, 0, CAST(N'2021-11-10' AS Date), 1, NULL)
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'HAPPYDAY11', 5, 12, 0, CAST(N'2021-11-10' AS Date), 1, NULL)
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'PRIFOR1', 20, 1, 0, CAST(N'2021-11-15' AS Date), 0, N'user03')
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'PRIFOR2', 5, 1, 1, CAST(N'2021-11-15' AS Date), 0, N'user01')
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'SAVE1010', 20, 8, 0, CAST(N'2021-10-01' AS Date), 1, NULL)
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'TESTGROUP', 15, 10, 1, CAST(N'2021-11-15' AS Date), 1, NULL)
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'TROPHYGOLD', 20, 1, 1, CAST(N'2021-11-01' AS Date), 0, N'user05')
INSERT [dbo].[Coupons] ([Code], [Value], [Quantity], [Active], [Createdate], [Category], [Customerid]) VALUES (N'TROPHYSILVER', 15, 1, 1, CAST(N'2021-11-05' AS Date), 0, N'user03')
GO

SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (3, N'user01', CAST(N'2021-10-12' AS Date), N'Nguyễn Văn Tèo', N'0909080809', N'14 Lý Chính Thắng , Phường 11', 3, NULL, N'PRIFOR2', 90000, 0, N'COD', NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (4, N'user02', CAST(N'2021-10-12' AS Date), N'Tèo', N'0908070605', N'7 Ly Bah', 6, NULL, NULL, 120000, 20000, N'COD', NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10003, N'user03', CAST(N'2021-10-14' AS Date), N'Tèo', N'0808080708', N'10 Nguyen Hue', 1, NULL, N'TROPHYSILVER', 57000, 0, N'COD', NULL, N'accepted', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10004, N'user05', CAST(N'2021-10-15' AS Date), N'Tèo', N'0907758475', N'35 Su Van Hanh', 10, NULL, NULL, 88000, 20000, N'COD', NULL, N'canceled', 1, N'Đổi ý', NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10006, N'user01', CAST(N'2021-10-15' AS Date), N'Tèo', N'0909080809', N'14 Cong Hoa', 3, NULL, NULL, 110000, 0, N'COD', NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10008, N'user04', CAST(N'2021-11-16' AS Date), N'Teo', N'09090     ', N'a', 13, NULL, NULL, 88000, 0, NULL, NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10009, N'user02', CAST(N'2021-11-17' AS Date), N'Teo', N'09090     ', N'a', 15, NULL, NULL, 100000, 0, NULL, NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10010, N'user05', CAST(N'2021-11-17' AS Date), N'Teo', N'09090     ', N'a', 18, NULL, NULL, 68000, 0, NULL, NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10011, N'user03', CAST(N'2021-11-18' AS Date), N'Teo', N'0909      ', N'a', 5, NULL, NULL, 45000, NULL, NULL, NULL, N'canceled', 0, N'Khách bom hàng', NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10013, N'user01', CAST(N'2021-11-19' AS Date), N'Teo', N'09090     ', N'a', 8, NULL, NULL, 95000, 0, NULL, NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10014, N'user02', CAST(N'2021-11-19' AS Date), N'Teo', N'09090     ', N'a', 10, NULL, NULL, 55000, 0, NULL, NULL, N'completed', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [CustomerId], [CreateDate], [RecipientName], [Phone], [Address], [District], [Email], [CouponCode], [Price], [Shipfee], [PaymentMethod], [PaymentStatus], [OrderStatus], [WhoCancel], [Reason], [StaffId]) VALUES (10015, N'user04', CAST(N'2021-11-20' AS Date), N'Teo', N'09090     ', N'a', 11, NULL, NULL, 55000, 0, NULL, NULL, N'completed', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO

SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (1, 3, 1, 1, 18000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (2, 3, 2, 1, 35000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (3, 4, 4, 2, 29000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (4, 4, 5, 1, 120000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (10004, 10003, 1, 2, 18000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (10005, 10003, 3, 1, 38000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (10007, 10003, 5, 2, 120000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (10008, 10004, 4, 2, 290000)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (10009, 10004, 1, 1, 180000)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
