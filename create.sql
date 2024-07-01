drop table OrderItems;
drop table Products;
drop table Shipping;
drop table Location;
drop table Orders;
drop table Customers;
drop table Department;
drop table Category;
drop table Transaction;
drop table Main;


CREATE TABLE MAIN (
  Type VARCHAR(50),
  Daysforshipping INT,
  Daysforshipment INT,
  Salespercustomer FLOAT,
  DeliveryStatus VARCHAR(100),
  Latedeliveryrisk VARCHAR(10),
  CategoryId INT,
  CategoryName VARCHAR(100),
  CustomerCity VARCHAR(100),
  CustomerCountry VARCHAR(50),
  CustomerFname VARCHAR(50),
  CustomerId INT,
  CustomerLname VARCHAR(50),
  CustomerSegment VARCHAR(50),
  CustomerState VARCHAR(50),
  CustomerStreet VARCHAR(100),
  CustomerZipcode VARCHAR(20),
  DepartmentId INT,
  DepartmentName VARCHAR(100),
  Latitude FLOAT,
  Longitude FLOAT,
  Market VARCHAR(50),
  OrderCity VARCHAR(100),
  OrderCountry VARCHAR(50),
  OrderId INT,
  OrderItemDiscount FLOAT,
  OrderItemDiscountRate FLOAT,
  OrderItemId INT,
  OrderItemProductPrice FLOAT,
  OrderItemProfitRatio FLOAT,
  OrderItemQuantity INT,
  OrderItemTotal FLOAT,
  OrderProfitPerOrder FLOAT,
  OrderRegion VARCHAR(100),
  OrderState VARCHAR(100),
  OrderStatus VARCHAR(50),
  ProductCardId INT,
  ProductName VARCHAR(100),
  ProductPrice FLOAT,
  ProductStatus VARCHAR(50),
  ShippingMode VARCHAR(100),
  ordertime TIME,
  orderdate TEXT,
  Shippingtime TIME,
  Shippingdate TEXT
);

create table Customers(
	CustomerID int not null Primary key,
	CustomerFirstName Varchar,
	CustomerLastName Varchar,
	CustomerSegment Varchar
);

create table Department(
	DepartmentID int not null Primary key,
	DepartmentName Varchar
);

create table Category(
	CategoryID int Primary key,
	CategoryName Varchar
);

create table Products(
	ProductID int not null Primary key,
	ProductName Varchar,
	ProductPrice float,
	ProductStatus Varchar,
	CategoryID int,
	DepartmentID int,
	FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
	FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

create table Transaction(
	TransactionID serial Primary key,
	TransactionType Varchar
);

create table Orders(
	OrderID int not null Primary key,
	OrderDate text,
	OrderTime time,
	OrderStatus Varchar,
	TransactionID int,
	FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID)
);

create table OrderItems(
	OrderItemID int not null Primary key,
	OrderItemQuantity int,
	OrderItemProductPrice float,
	OrderItemDiscount float,
	OrderItemDiscountRate float,
	OrderItemTotal float,
	OrderItemProfitRatio float,
	CustomerID int,
	ProductID int,
	OrderID int,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

create table Location(
	LocationID serial Primary key,
	CustomerCity Varchar,
	CustomerCountry Varchar,
	CustomerState char(2),
	CustomerStreet text,
	CustomerZipcode varchar,
	OrderRegion Varchar,
	OrderCity Varchar,
	OrderState Varchar,
	OrderCountry Varchar,
	Market Varchar,
	Latitude float,
	Longitude float,
	CustomerID int,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

create table Shipping(
	ShippingID serial Primary key,
	DaysForShipping int,
	DaysForShipment int,
	Shippingmode varchar,
	ShippingDate text,
	ShippingTime time,
	DeliveryStatus Varchar,
	LateDeliveryRisk Varchar,
	OrderID int,
	LocationID int,
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
