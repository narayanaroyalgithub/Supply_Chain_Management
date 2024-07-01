-- delete from orderitems;
-- delete from shipping;
-- delete from orders;
-- delete from products;
-- delete from location;
-- delete from customers;
-- delete from category;
-- delete from department;
-- delete from transaction;


insert into customers
select distinct customerid,customerfname,customerlname,customersegment
from main;

insert into department
select distinct departmentid,departmentname
from main;

insert into category 
select distinct categoryid,categoryname
from main;

insert into products(productid,productname,productprice,productstatus,categoryid,departmentid)
select distinct m.productcardid,m.productname,m.productprice,m.productstatus,c.categoryid,d.departmentid
from main m
inner join category c on c.categoryid = m.categoryid
inner join department d on d.departmentid = m.departmentid;

insert into transaction(transactiontype)
select distinct type
from main;

insert into Orders (OrderID, OrderDate, OrderTime, OrderStatus, TransactionID)
select distinct m.OrderID, m.OrderDate, m.OrderTime, m.OrderStatus, t.TransactionID
from main m
inner join Transaction t on t.Transactiontype = m.type;

insert into Orderitems (OrderitemID, OrderitemQuantity, OrderitemProductprice, OrderitemDiscount, OrderitemDiscountrate, Orderitemtotal, Orderitemprofitratio, CustomerID, ProductID, orderID)
select distinct m.OrderitemID, m.OrderitemQuantity, m.OrderitemProductprice, m.OrderitemDiscount,m.OrderitemDiscountrate,m.Orderitemtotal,m.Orderitemprofitratio, c.CustomerID,p.productid,o.orderid
from main m
inner join Customers c on c.CustomerID = m.CustomerID 
inner join Products p on p.productid = m.productcardid
inner join orders o on o.orderid = m.orderid;

insert into Location (customercity,customercountry,customerstate,customerstreet,customerzipcode,orderregion,ordercity,orderstate,ordercountry,market,latitude,longitude,customerid)
select distinct m.customercity,m.customercountry,m.customerstate,m.customerstreet,m.customerzipcode,m.orderregion,m.ordercity,m.orderstate,m.ordercountry,m.market,m.latitude,m.longitude,c.customerid
from main m
inner join Customers c on c.CustomerID = m.CustomerID;

insert into Shipping (daysforshipping,daysforshipment,shippingmode,shippingdate,shippingtime,deliverystatus,latedeliveryrisk,orderid,locationid)
select distinct m.daysforshipping,m.daysforshipment,m.shippingmode,m.shippingdate,m.shippingtime,m.deliverystatus,m.latedeliveryrisk,o.orderid,l.locationid
from main m
inner join Orders o on o.orderID = m.orderID
inner join location l on l.customerid = m.customerid;
