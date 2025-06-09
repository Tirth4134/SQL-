CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    CreatedDate DATETIME
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, CreatedDate) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', '2024-01-15 10:30:00'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', '2024-02-20 14:45:00'),
(3, 'Charlie', 'Lee', 'charlie.lee@example.com', '2024-03-05 09:00:00'),
(4, 'Diana', 'Brown', 'diana.brown@example.com', '2024-03-25 16:10:00'),
(5, 'Ethan', 'Clark', 'ethan.clark@example.com', '2024-04-01 11:20:00'),
(6, 'Fiona', 'Taylor', 'fiona.taylor@example.com', '2024-04-10 08:15:00');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(101, 'Wireless Mouse', 'Electronics', 25.99, 100),
(102, 'Keyboard', 'Electronics', 45.50, 80),
(103, 'USB-C Charger', 'Accessories', 18.75, 150),
(104, 'Notebook', 'Stationery', 5.00, 200),
(105, 'Office Chair', 'Furniture', 150.00, 20),
(106, 'Desk Lamp', 'Lighting', 35.25, 40);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2024-04-05 13:20:00', 71.99),
(1002, 2, '2024-04-06 10:15:00', 195.25),
(1003, 3, '2024-04-07 17:30:00', 23.75),
(1004, 1, '2024-04-08 09:45:00', 30.00),
(1005, 4, '2024-04-09 12:05:00', 150.00),
(1006, 5, '2024-04-10 15:00:00', 80.50);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1001, 101, 2, 25.99),
(2, 1001, 104, 4, 5.00),
(3, 1002, 105, 1, 150.00),
(4, 1002, 106, 1, 35.25),
(5, 1003, 103, 1, 18.75),
(6, 1004, 104, 6, 5.00),
(7, 1005, 105, 1, 150.00),
(8, 1006, 102, 1, 45.50),
(9, 1006, 103, 2, 17.50);  -- One discount unit price for practice

--Write a stored procedure to insert a new customer.
     SELECT * FROM Customers
   
    CREATE PROCEDURE GetCustomerAdd
     @CustomerID int,
	 @firstname varchar(20),
     @lastname varchar(20),
	 @email varchar(50)	
    as
     begin
     insert into Customers values(@CustomerID,@firstname, @lastname  ,  @email , GETDATE() );
	 end

     exec GetCustomerAdd  7  , 'john', 'Miller',  'george.miller@example.com';
 
     SELECT * FROM Customers
	
	
--Write a stored procedure to update a customer's email.

  create PROCEDURE GetEmailUpdate
    @customerID  int = 5
    AS
	BEGIN
	    UPDATE Customers
		SET email = 'tom.cruise@gmail.com'
		where CustomerID = @CustomerID;
    END
	  
	EXEC GetEmailUpdate; 
	
	
    
--Write a stored procedure to delete a customer by ID.

   ALTER PROCEDURE GetCustomerDelete
  @customerID INT  = 3
  as 
  begin 
    delete  Customers
	where CustomerID = @customerID
	end;

	exec GetCustomerDelete ;  


	
--Write a stored procedure to retrieve all customers.

 create procedure getAllCustomer 
as
begin
  select * from Customers
  end

   exec getAllCustomer;
--Write a stored procedure to find customers created in the last 30 days.
    
	create procedure getlastdays
	as
	begin
	 select firstname , lastname   from Customers
	 where createdDate >= DATEADD(DAY , -30, GETDATE()) 
	 end

	 exec getlastdays;

--Write a stored procedure to insert a new product.
     select * from Products
    
   create procedure getInsertProduct
    @productID  int,
	@productname varchar(30),
	@category varchar(30),
	@price decimal(10,2),
	@stock int
	as
	begin
	   insert into Products values(@productID, @productname, @category, @price, @stock)
	   end

	   exec  getInsertProduct 107, 'chair' , 'Furniture', 450.00 , 35;
	   select * from Products;

--Write a stored procedure to get all products below a given stock level.

   create procedure getStockLevel
    @stockhold int
   as
   begin 
     select * from Products
	 where stock  < @stockhold;
 end

 exec getStockLevel @stockhold = 70;

--Write a stored procedure to update product price by ProductID.


 create procedure  getUpdatePrice 
  @productId int
 as
 begin 
    update Products
	set Price = 75.00
	where ProductID =  @productId
 end	

 exec getUpdatePrice @productID = 104;
 select * from Products;

--Write a stored procedure to retrieve all orders by a specific customer.
   select * from Customers
   select * from Orders
 
   create procedure getAllOrders
      @firstname varchar(20)
   as
   begin 
    select C.firstname, C.lastname , O.OrderID , O.TotalAmount from Orders O 
	JOIN Customers C ON O.CustomerID = C.CustomerID
	WHERE C.FIRSTNAME = @firstname 
 END 

 EXEC getAllOrders @FIRSTNAME = 'Diana';
 
 
--Write a stored procedure to calculate total amount for an order using OrderDetails.
 
 CREATE PROCEDURE GetOrderTotalAmount
    @OrderID INT
AS
BEGIN
    SELECT 
        @OrderID AS OrderID,
        SUM(Quantity * UnitPrice) AS TotalAmount
    FROM OrderDetails
    WHERE OrderID = @OrderID;
END;

EXEC GetOrderTotalAmount @ORDERID = 1002;

--Write a stored procedure to delete an order and its related order details.
   select * from Orders
   select * from OrderDetails
 
  alter PROCEDURE GetDeleteOrders 
  @orderId int 
  as
  begin 
    delete  OrderDetails
	where OrderID = @orderId;

	delete Orders
	where OrderID = @orderId;
	end

	exec GetDeleteOrders @orderId = 1004
     


--Write a stored procedure to fetch products in a specific category.
    

  create procedure getproducts
    @category varchar(20)
	as
	begin
	  select Productname , price , stock from Products
	  where category = @category
    end

	exec getproducts @category = 'Electronics';

 --Write a stored procedure to count the number of orders placed by a customer.
           
		   SELECT * FROM Customers;
	       SELECT * FROM Orders;

CREATE PROCEDURE GetnumberOrder
as
 begin 
   select CustomerID , count(OrderID) as NumberOrder   from Orders
   group by CustomerID
 end 

 exec GetnumberOrder;

--Write a stored procedure to list top 5 products with highest stock.
    SELECT * FROM Products;
	    
      
	  alter procedure getHighestStock 
	  as
	  begin 
	    select  top 5 * from Products
		order by Stock desc
		end
		

		exec getHighestStock; 

  ---Write a stored procedure to get order history (order + details) for a customer.

		 select * from Orders;
        select * from OrderDetails;
 

 create  procedure  getOrderHistory
   @CustomerID int 
 as
 begin
    select O.OrderID , OD.ProductID , O.OrderDate , O.TotalAmount  , OD.Quantity , OD.UnitPrice from Orders O
	JOIN OrderDetails OD  
	ON O.OrderID = OD.OrderID
	WHERE O.CustomerID = @CustomerID
	end

	exec getOrderHistory @CustomerID = 4;


--Write a stored procedure to check if a customer exists by email.

   select * from Customers

   create procedure getEmailCheck
   @email  varchar(50)
   as
   begin
     select  * from Customers
	 where Email = @email;
	 end

	 exec getEmailCheck @email = 'ethan.clark@example.com'


--Write a stored procedure to list orders placed in a specific date range.

    	 select * from Orders;
        select * from OrderDetails;
 
 create procedure GetDateRange
   @startDate  datetime,
   @EndDate  datetime
 as
  begin
   select * from Orders
   where OrderDate between @startDate and @EndDate;
   end

   exec GetDateRange @startDate = '2024-04-06' , @endDate = '2024-04-08';
    

--Write a stored procedure to get total number of customers.

     create procedure getTotalNumber 
	 as
	 begin 
	   select count(CustomerID) as TotalNumber from Customers
	   end

	   exec getTotalNumber; 

--Write a stored procedure to retrieve the top N most expensive products.

    select * from Products

	 create procedure getExensiveProduct
	 @number int
	 as 
	 begin 
	   select top (@number) * from Products
	   order by Price desc
	   end

   exec  getExensiveProduct @number = 3;


--Write a stored procedure to update stock quantity after a new order.
     	 
			CREATE PROCEDURE UpdateStockAfterOrder
            @OrderID INT
           AS
          BEGIN
    
        UPDATE P
       SET P.Stock = P.Stock - OD.Quantity
       FROM Products P
       INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
       WHERE OD.OrderID = @OrderID;
       END;


       exec  UpdateStockAfterOrder @OrderID = 1002;

--Write a stored procedure to apply a discount to products in a specific category.

         
SELECT * FROM Products;
 

CREATE PROCEDURE discount
	@Category varchar(50),
	@DiscountPercentage int
AS
BEGIN
	update Products
	SET Price = Price - (Price * @DiscountPercentage / 100)
	where Category = @Category;
END;
 
EXEC discount @DiscountPercentage = 10, @Category = 'Furniture';

--Write a stored procedure to get monthly sales totals for the current year.
  select * from Orders
  exec getMonthlySales

  update Orders
  set OrderDate = '2025-05-03'
  where OrderID = 1002

   alter procedure getMonthlySales 
   as
   begin 
     select  DATENAME(MONTH , OrderDate) as Month , sum(TotalAmount) as Sales from Orders
	WHERE YEAR(OrderDate) = YEAR(GETDATE())
    GROUP BY  DATENAME(MONTH, OrderDate);
end

  exec getMonthlySales;
--Write a stored procedure that accepts a category and returns average product price.

  select * from Products

  ALTER procedure getAvgProductPrice
  @category varchar(20)
  as
  begin
    select   @category , avg(Price)  from Products
	 where Category = @category
     GROUP BY Category
	end

	exec  getAvgProductPrice @category = 'Electronics';


--Write a stored procedure to get customers who haven’t placed any orders.

     select * from Customers

	 create procedure getAnyOrder
	 as
	 begin 
	   select C.FirstName , O.OrderDate , O.TotalAmount from Customers C
     	LEFT join Orders O ON C.CustomerID = O.CustomerID
	   WHERE O.OrderID IS NULL;
	   END

    EXEC  getAnyOrder; 

--Write a stored procedure to return the best-selling product.
      select * from OrderDetails;
	 select * from Products;
   
    CREATE  PROCEDURE BestSelling
	AS
	BEGIN
   SELECT TOP 1 P.ProductID, P.ProductName , SUM(OD.Quantity) TotalQuantity from  Products P
   JOIN OrderDetails OD  ON OD.ProductID = P.ProductID
   GROUP BY P.ProductID , P.ProductName
   ORDER BY TotalQuantity DESC
    END

	exec BestSelling

--Write a stored procedure to calculate revenue generated per product.
  
   CREATE PROCEDURE GetRevenueProduct
   @productID int
   as 
   begin
   select productID , SUM(quantity * unitprice) as revenue from OrderDetails
   WHERE ProductID = @productID 
   GROUP BY ProductID
   end

  exec GetRevenueProduct @productID = 104;

--Write a stored procedure to retrieve top 3 customers by total order value.

     SELECT * FROM Customers
     SELECT * FROM Orders
	 
    
	CREATE PROCEDURE GetTop3CustomerValue
	as
	begin  
	  select top 3 customerID , SUM(TotalAmount) as value from Orders
	  group by CustomerID
	  order by value desc
	  end

	  exec GetTop3CustomerValue;
	 

--Write a stored procedure to insert a new order with order details.
     SELECT * FROM Products;
     SELECT * FROM OrderDetails;
     SELECT * FROM Orders;

    ALTER PROCEDURE newOrderAndDetails
	@OrderID INT,
    @CustomerID INT,
    @TotalAmount DECIMAL(10,2),
	@orderdetailId int,
    @ProductID INT,
    @Quantity INT,
    @UnitPrice DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Orders ( OrderID,CustomerID, OrderDate, TotalAmount)
    VALUES (@OrderID, @CustomerID, GETDATE(), @TotalAmount);

    INSERT INTO OrderDetails (OrderDetailID,OrderID, ProductID, Quantity, UnitPrice)
    VALUES (@orderdetailId, @OrderID, @ProductID, @Quantity, @UnitPrice);
END;

	EXEC newOrderAndDetails 
	@orderdetailId = 10,
	@OrderID = 1009,
    @CustomerID = 6, 
    @TotalAmount = 450.78, 
    @ProductID = 103, 
    @Quantity = 2, 
    @UnitPrice = 225.39;


--Write a stored procedure to archive orders older than 2 years.

     SELECT * FROM OrderDetails;
     SELECT * FROM Orders;

	 create procedure orderOlder2Year
	 as
	 begin 
	   select OrderID , CustomerID , OrderDate AS YEARS from Orders
	   where  OrderDate <= DATEADD(YEAR, -2, GETDATE())
    END

	EXEC orderOlder2Year;

--Write a stored procedure to find orders with missing order details.

    CREATE PROCEDURE MissingOrderDetails
	as
	begin
	   select OrderID ,OrderDate , TotalAmount from Orders
	   where OrderID not in (select OrderID from OrderDetails)
  end

  exec MissingOrderDetails;


--Write a stored procedure to detect and return duplicate customer emails.

   select * from Customers
   
   create procedure duplicateCustomer 
   as
   begin 
      select   FirstName, LastName , Email  from Customers 
 	  WHERE Email IN ( SELECT Email FROM Customers GROUP BY Email HAVING COUNT(Email) > 1 )
	END
	
	EXEC  duplicateCustomer;

--Write a stored procedure to return products that were never ordered.

   SELECT * FROM Products
   SELECT * FROM OrderDetails
   SELECT * FROM Orders

   CREATE PROCEDURE GetProductNotOrder
   as
   begin
     select P.ProductID , P.ProductName , OD.OrderID from Products P
     LEFT JOIN OrderDetails OD  ON P.ProductID = OD.ProductID
	 WHERE OD.ProductID IS NULL;
   END
   
   EXEC  GetProductNotOrder;

 --Write a stored procedure to calculate average order value per month.
   
   CREATE PROCEDURE GetAveragePerMonth
   as 
    begin 
	   select   avg(OD.Quantity * OD.UnitPrice) as avgprice , DATENAME(MONTH, O.OrderDate)   FROM Orders O
	   LEFT JOIN OrderDetails OD  ON O.OrderID = OD.OrderID
	   GROUP BY DATENAME(MONTH, O.OrderDate)
	   END

EXEC GetAveragePerMonth;

--Write a stored procedure to get all orders for products in a specific category.
 
    SELECT * FROM Products
   SELECT * FROM OrderDetails
   SELECT * FROM Orders
   exec allOrderCategory @category = 'Electronics';

   create procedure allOrderCategory
    @category varchar(20)
   as
   begin
    SELECT  P.Category ,O.OrderID ,  SUM(OD.Quantity * OD.UnitPrice) as Totalprice from Orders  O
 	left join OrderDetails OD ON O.OrderID = OD.OrderID
	JOIN Products P ON OD.ProductID = P.ProductID
	WHERE P.Category = @category
	GROUP BY O.OrderID , P.Category
    end 

	exec allOrderCategory @category = 'Electronics';


--Write a stored procedure to generate a sales report by category.
    select * from Products
    select * from OrderDetails

	CREATE PROCEDURE SalesReport
	as
   begin
   select   P.Category ,SUM( OD.Quantity) as Total  ,sum(OD.Quantity * OD.UnitPrice) as TotalPrice  from Products P
   join OrderDetails OD ON P.ProductID = OD.ProductID
   GROUP BY  P.Category
	end

	exec SalesReport

--Write a stored procedure to get the customer with the highest order total.

   select * from Customers
   select * from Orders
   select * from OrderDetails

   ALTER PROCEDURE HighestOrderCustomer 
   as
   begin
    select  TOP 1 C.FirstName , COUNT(O.OrderID) AS highestOrder from Customers C
	join Orders O ON C.CustomerID = O.CustomerID
	GROUP BY C.FirstName
	ORDER BY  COUNT(O.OrderID) DESC;
   end
    
	exec HighestOrderCustomer; 
	

--Write a stored procedure that returns order count by customer with more than 5 orders.

  
   ALTER PROCEDURE MoreThan5orderCustomer
   as
   begin
    select   C.FirstName , COUNT(O.OrderID) AS highestOrder from Customers C
	join Orders O ON C.CustomerID = O.CustomerID
	GROUP BY C.FirstName
	having COUNT(O.OrderID) >= 5 ;
   end
    
	exec MoreThan5orderCustomer; 

--Write a stored procedure to get top 5 most frequently ordered products.


   select * from OrderDetails
   select * from Products
 
    alter  PROCEDURE Top5OrderedProducts
	AS
	BEGIN
   SELECT TOP 5 P.ProductID, P.ProductName, p.Category ,count(od.ProductID) Timeorder ,   SUM(OD.Quantity) TotalQuantity from  Products P
   JOIN OrderDetails OD  ON OD.ProductID = P.ProductID
   GROUP BY P.ProductID , P.ProductName , p.Category
   ORDER BY Timeorder DESC
    END

	exec Top5OrderedProducts;

--Write a stored procedure to track daily stock changes.

   SELECT * FROM Customers
   SELECT * FROM Products
   select * from OrderDetails
   select * from Orders
 
   

   
--Write a stored procedure that returns products where stock < average stock.

    CREATE PROCEDURE StockBelowAvgrage
	as
	begin
   SELECT ProductName , Category , stock from Products
   where Stock < (select avg(Stock) from Products)
    end

	exec StockBelowAvgrage;

--Write a stored procedure that returns a dynamic pivot table showing sales per category per month.
    SELECT * FROM Products 
  SELECT * FROM OrderDetails
  SELECT * FROM Orders

	 ALTER PROCEDURE CategoryPivot
AS
BEGIN
    DECLARE @column NVARCHAR(MAX)

    SELECT @column = STRING_AGG(
        QUOTENAME(FORMAT(CONVERT(DATE, RIGHT(OrderMonth, 4) + '-' + LEFT(OrderMonth, 2) + '-01'), 'MMM-yyyy')), ',' )
    FROM (
        SELECT DISTINCT FORMAT(O.OrderDate, 'MM-yyyy') AS OrderMonth 
        FROM Orders O
    ) AS Month

    DECLARE @query NVARCHAR(MAX)
    SET @query = '
        SELECT Category, ' + @column + '
        FROM (
            SELECT 
                P.Category,
                FORMAT(O.OrderDate, ''MMM-yyyy'') AS OrderMonth,
                OD.Quantity * P.Price AS SalesAmount
            FROM OrderDetails OD
            JOIN Orders O ON OD.OrderID = O.OrderID
            JOIN Products P ON OD.ProductID = P.ProductID
        ) AS SourceTable
        PIVOT (
            SUM(SalesAmount)
            FOR OrderMonth IN (' + @column + ')
        ) AS PivotTable
        ORDER BY Category;'

    EXEC sp_executesql @query;
END


	    SELECT * FROM Products 
  SELECT * FROM OrderDetails
  SELECT * FROM Orders


EXEC CategoryPivot 















--Write a stored procedure that performs bulk insert of products from a temporary staging table.

     create  table ProductStaging(
	   productID int,
	  ProductName  varchar(50),
	  Category  varchar(50),
	  Price decimal(10,2),
	  Stock int
	 )
	 INSERT INTO ProductStaging (ProductID, ProductName, Category, Price, Stock)
VALUES 
(125, 'USB Drive', 'Electronics', 600.50, 10),
(126, 'memory card', 'Furniture', 250.00, 5),
(127, 'Monitor', 'Accessories', 2000.00, 100),
(128, 'Mouse', 'Accessories', 65.00, 80);
 

	ALTER procedure StagingTable
	as
	 begin  
	    insert into Products(ProductID , ProductName , Category , Price, Stock)
		 select ProductID , ProductName , Category , Price, Stock from ProductStaging
		 end

		 exec StagingTable

		  select * from Products
          select * from ProductStaging

--Write a stored procedure that audits changes to the Products table (trigger + log table).
   
      CREATE TABLE ProductAuditLog (

    AuditID INT IDENTITY(1,1) PRIMARY KEY, 
    ProductID INT,                         
    OperationType VARCHAR(20),  
    Oldcategory VARCHAR(100),          
    Newcategory VARCHAR(100),         
    OldProductName VARCHAR(100),          
    NewProductName VARCHAR(100),         
    OldPrice DECIMAL(10,2),        
    NewPrice DECIMAL(10,2),           
    ChangeDate DATETIME DEFAULT GETDATE() 
);
	 
	alter TRIGGER Triggertable
	 on products 
	 after insert, update, delete
	 as 
	 begin
	    insert into ProductAuditLog (ProductID , OperationType, NewProductName, Newcategory ,NewPrice) 
		select i.ProductID , 'INSERT' , i.productName, i.category  , i.price from inserted i
		left join deleted d   on i.productID = d.productID
		where d.productID is null;

	    insert into ProductAuditLog (ProductID , OperationType, OldProductName, oldcategory , OldPrice) 
		select d.ProductID , 'DELETE' , d.productName , d.category , d.price from deleted d
		left join inserted i   on i.productID = d.productID
		where i.productID is null;
 
  	    insert into ProductAuditLog (ProductID , OperationType, OldProductName, NewProductName, Oldcategory, Newcategory , OldPrice , NewPrice) 
		select i.ProductID , 'UPDATE',  i.productName   , d.productName ,i.category , d.category  , d.price, i.price from inserted i
		 join  deleted d   on i.productID = d.productID
		where i.productname <> d.productName or i.price <> d.price or i.category <> d.category ;
	 end
     

	 select * from Products;
	 select * from ProductAuditLog;

    update Products 
	set Price = 2000.50
	where ProductID = 126

	delete Products
	where ProductID = 126

	 insert into Products  values(126, ' mashine', 'Electronics' , 1500.00, 10);

--Write a stored procedure that calculates reorder level dynamically based on past 3 months sales.
   select * from Products
   select * from OrderDetails
   select * from Orders


   alter procedure dynamicRecorderLevel
   as
    begin
	   create table #RecorderLevel (
	     productID int,
		 productname varchar(20),
		 avgMontlySales  decimal(10,2),
		 reorderLevel decimal(10,2)
	   )

	   insert into #RecorderLevel(productID, productname, avgMontlySales, reorderLevel)
	   select P.ProductID ,
	   P.ProductName ,
	   avg(cast(OD.Quantity as decimal(10,2))) as avgMontlySales , 
	   round(avg(cast(OD.Quantity as decimal(10,2))) * 1.5, 2) as reorderLevel 
	   from Products p
	   JOIN OrderDetails OD ON P.ProductID = OD.ProductID
	   JOIN Orders O ON OD.OrderID = O.OrderID
	   WHERE  O.OrderDate >= DATEADD(MONTH, -3 , GETDATE())
	   group by p.ProductID , p.ProductName ;

	     select * from  #RecorderLevel
	   end

  
   select * from Products
   select * from OrderDetails
   select * from Orders

  exec dynamicRecorderLevel;

--Write a stored procedure to generate invoice (with order + customer + product details) in one result.

  alter procedure InvoiceData
  @customerID int
  as 
  begin

with tempt as (
     select OD.OrderID , SUM(OD.Quantity * P.Price) as TotalOrderPrice from OrderDetails OD 
	 FULL OUTER JOIN Products P ON OD.ProductID = P.ProductID
	 GROUP BY OD.OrderID
  )
  SELECT C.CustomerID , CONCAT(C.FirstName , ' ', C.LastName) AS FullName , c.Email, o.OrderID, o.OrderDate, p.ProductID, p.ProductName,  p.Category,  p.Price ,od.Quantity , (OD.Quantity * P.Price) as LineTotal  ,t.TotalOrderPrice FROM Customers C
  FULL OUTER JOIN Orders O ON C.CustomerID = O.CustomerID
  FULL OUTER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
  FULL OUTER JOIN Products P ON OD.ProductID = P.ProductID
  FULL OUTER JOIN tempt T ON O.OrderID = T.OrderID
  where c.CustomerID  is not null and c.CustomerID = @customerID;
end

exec InvoiceData  @customerID = 2;
  
--Write a stored procedure that implements pagination for the Orders table (page size, number).
        
		    select  * from Orders 

      create procedure PaginationOrder
	  @pageNum int , 
	  @pageSize int
	  as 
	  begin 
	    select  * from Orders 
		order by OrderID
		offset(@pageNum - 1) * @pageSize rows
		fetch next @pageSize rows only;
		end
	exec	PaginationOrder @pageNum = 2 , @pageSize = 2

--Write a stored procedure that returns top 3 selling products per category.
 
SELECT * FROM Products;
 
SELECT * FROM OrderDetails;
 
WITH RankedProducts AS (
SELECT p.ProductID,p.ProductName, p.Category, 
ROW_NUMBER() OVER (PARTITION BY p.Category ORDER BY SUM(o.Quantity) DESC) AS rank from Products p 
join OrderDetails o on p.ProductID = o.ProductID
group by p.Category, p.ProductID,p.ProductName) 
select * from RankedProducts
where rank <= 3;

--Write a stored procedure that validates all order details for consistency (e.g., price * quantity = subtotal).

  select * from Products
  select * from OrderDetails
  select * from Orders

  create procedure ValidateOrder
  as
  begin 
    select O.OrderID , SUM(OD.Quantity * OD.UnitPrice) as SubTotal , O.TotalAmount , 
	  CASE WHEN SUM(OD.Quantity * OD.UnitPrice) = O.TotalAmount THEN 'Valid'
	    else 'Mismatch' 
		end as Status
	from Orders O
	join OrderDetails  OD ON O.OrderID = OD.OrderID
	group by o.OrderID , o.TotalAmount
	end

 exec ValidateOrder

--Write a stored procedure to simulate order placement: insert order, deduct stock, return receipt.


--Write a stored procedure to predict stockout dates based on order trends (requires historical order data).