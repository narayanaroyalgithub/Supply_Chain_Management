
explain analyse SELECT ShippingMode, round ((AVG (DaysForShipping))) as AvgNumberOfShippingDays
FROM Shipping
GROUP BY ShippingMode;
---------------------------------------------------------
-- Indexes for Customers table
CREATE INDEX idx_customerName ON Customers(CustomerFirstName, CustomerLastName);

-- Indexes for Products table
CREATE INDEX idx_productPrice ON Products(ProductPrice);
CREATE INDEX idx_productStatus ON Products(ProductStatus);

-- Indexes for Orders table
CREATE INDEX idx_orderDate ON Orders(OrderDate);
CREATE INDEX idx_orderStatus ON Orders(OrderStatus);

-- Indexes for OrderItems table
CREATE INDEX idx_orderItemTotal ON OrderItems(OrderItemTotal);
CREATE INDEX idx_orderItemQuantity ON OrderItems(OrderItemQuantity);

-- Indexes for Location table
CREATE INDEX idx_customerCity ON Location(CustomerCity);
CREATE INDEX idx_orderRegion ON Location(OrderRegion);

-- Indexes for Shipping table
CREATE INDEX idx_shippingMode ON Shipping(ShippingMode);
CREATE INDEX idx_deliveryStatus ON Shipping(DeliveryStatus);
------------------------------------------------------------------------
-- Drop indexes for the Customers table
DROP INDEX idx_customerName;

-- Drop indexes for the Products table
DROP INDEX idx_productPrice;
DROP INDEX idx_productStatus;

-- Drop indexes for the Orders table
DROP INDEX idx_orderDate;
DROP INDEX idx_orderStatus;

-- Drop indexes for the OrderItems table
DROP INDEX idx_orderItemTotal;
DROP INDEX idx_orderItemQuantity;

-- Drop indexes for the Location table
DROP INDEX idx_customerCity;
DROP INDEX idx_orderRegion;

-- Drop indexes for the Shipping table
DROP INDEX idx_shippingMode;
DROP INDEX idx_deliveryStatus;
--------------------------------------------------------
--Find customers whose total order value exceeds a specified limit, useful for identifying high-value customers

SELECT
  c.CustomerFirstName,
  c.CustomerLastName,
  SUM(oi.OrderItemTotal) AS TotalOrderValue
FROM Customers c
JOIN OrderItems oi ON c.CustomerID = oi.CustomerID
GROUP BY c.CustomerID
HAVING SUM(oi.OrderItemTotal) > 1000
ORDER BY TotalOrderValue DESC
LIMIT 10;
-------------------------------------------------------
-- Most Popular Product in Each Category
SELECT CategoryName, ProductName, ProductSales
FROM (
    SELECT 
        c.CategoryName, p.ProductName, Sales.ProductSales,
        RANK() OVER (PARTITION BY c.CategoryID ORDER BY Sales.ProductSales DESC) as SalesRank
    FROM Category c
    JOIN Products p ON p.CategoryID = c.CategoryID
    JOIN (
        SELECT ProductID, SUM(OrderItemTotal) AS ProductSales
        FROM OrderItems
        GROUP BY ProductID
    ) AS Sales ON p.ProductID = Sales.ProductID
) AS RankedProducts
WHERE SalesRank = 1;

---------------------------------------------------------
INSERT INTO Customers (CustomerID, CustomerFirstName, CustomerLastName, CustomerSegment)
VALUES (180518, 'John', 'Doe', 'Consumer');

select * from customers where CustomerID = 180518

--------------------------------------------------------------------------------

UPDATE Customers
SET CustomerSegment = 'Corporate'
WHERE CustomerID = 180518;

select * from customers where CustomerID = 180518

---------------------------------------------------------

DELETE FROM Customers
WHERE CustomerID = 180518;

select * from customers where CustomerID = 180518

-------------------------------------------------------------

SELECT ProductName, SUM(OrderItemTotal) AS TotalSales
FROM OrderItems
JOIN Products ON OrderItems.ProductID = Products.ProductID
GROUP BY ProductName
ORDER BY TotalSales DESC
LIMIT 10;

------------------------------------------------------------
SELECT 
    p.ProductName,
    AVG(oi.OrderItemProfitRatio) AS AvgProfitMargin
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID
ORDER BY AvgProfitMargin DESC
LIMIT 10;
---------------------------------------------------

SELECT 
    c.CustomerSegment,
    SUM(oi.OrderItemTotal) AS TotalSales
FROM Customers c
JOIN OrderItems oi ON c.CustomerID = oi.CustomerID
GROUP BY c.CustomerSegment;
----------------------------------------------

WITH RankedProducts AS (
    SELECT 
        c.CategoryID,c.CategoryName,p.ProductName,
        SUM(oi.OrderItemTotal) AS TotalSales,
        RANK() OVER (PARTITION BY c.CategoryID ORDER BY SUM(oi.OrderItemTotal) DESC) AS SalesRank
    FROM Category c
    JOIN Products p ON c.CategoryID = p.CategoryID
    JOIN OrderItems oi ON p.ProductID = oi.ProductID
    GROUP BY c.CategoryID, c.CategoryName, p.ProductName
)
SELECT 
    CategoryName,
    ProductName,
    TotalSales
FROM RankedProducts
WHERE SalesRank <= 3;