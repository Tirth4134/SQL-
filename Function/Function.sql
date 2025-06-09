  CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Salary DECIMAL(10,2),
    DepartmentID INT,
    DateOfJoining DATE
);




INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID, DateOfJoining) VALUES
(1, 'Alice', 'Smith', 'alice.smith@corp.com', 60000.00, 101, '2020-03-15'),
(2, 'Bob', 'Johnson', 'bob.johnson@corp.com', 75000.00, 102, '2019-07-10'),
(3, 'Carol', 'Davis', 'carol.davis@corp.com', 68000.00, 101, '2021-01-20'),
(4, 'David', 'Lee', 'david.lee@corp.com', 72000.00, 103, '2018-11-05'),
(5, 'Eva', 'Brown', 'eva.brown@corp.com', 55000.00, 104, '2022-05-01'),
(6, 'Frank', 'Wilson', 'frank.wilson@corp.com', 63000.00, NULL, '2023-09-12');


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing'),
(105, 'Operations'),
(106, 'R&D');


CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES
(201, 'Website Revamp', '2023-01-01', '2023-06-30'),
(202, 'CRM Integration', '2022-08-15', '2023-02-15'),
(203, 'Budget Planning', '2023-03-01', '2023-12-31'),
(204, 'Marketing Blitz', '2023-04-10', '2023-09-10'),
(205, 'AI Research', '2024-01-05', NULL),
(206, 'Cloud Migration', '2023-05-20', '2024-02-28');



CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(1, 201, 120),
(2, 202, 200),
(3, 201, 90),
(3, 204, 60),
(4, 203, 150),
(5, 204, 80),
(6, 205, 100);


SELECT * FROM Departments;
SELECT * FROM Projects;
SELECT * FROM EmployeeProjects;

--Get the full name of all employees using CONCAT().
 
	SELECT * FROM Employees;
	SELECT CONCAT(FIRSTNAME, ' ' , LASTNAME) AS FULLNAME FROM Employees

--Extract the year from the DateOfJoining for each employee.

    SELECT FIRSTNAME , DATEPART(YEAR,DATEOFJOINING )  AS JOININGYEAR FROM Employees

--Return the length of each employee's email address.


    SELECT * FROM Employees;
    SELECT LEN(Email) as EmailLength From Employees;

--Show salaries rounded to the nearest whole number using ROUND().
  
    UPDATE Employees
	SET SALARY = 68000.46
	WHERE EmployeeID = 3;

	SELECT * FROM Employees
	SELECT FIRSTNAME , ROUND(SALARY , 0) AS NearestSalary FROM Employees;

--Convert all department names to uppercase using UPPER().

    SELECT * FROM Departments;
	SELECT UPPER(DepartmentName) AS DepartmentUpper  FROM  Departments; 

--Return only the first 3 characters of each employee's first name using LEFT().

    SELECT LEFT(FirstName, 3) AS frist3chars FROM Employees;

--Replace ‘@’ with ‘#’ in email addresses using REPLACE().

   SELECT REPLACE(EMAIL , '@', '#') AS EMAILREPLACE FROM Employees;

--Get the day name of each employee's DateOfJoining using DATENAME().

  SELECT DATENAME(WEEKDAY , DATEOFJOINING)  FROM Employees;

--Add 6 months to the DateOfJoining for each employee using DATEADD().

     SELECT * FROM Employees
   SELECT DATEADD(MONTH , 6 , DATEOFJOINING) AS Add6Month FROM Employees;

--Calculate the difference in days between today and each employee’s joining date using DATEDIFF().
 
      SELECT * FROM Employees;
      SELECT DATEDIFF(DAY, DATEOFJOINING , GETDATE()) AS DiffDate FROM Employees;

--Use ISNULL() to replace any NULL salary with 0.

   UPDATE Employees
   SET SALARY = null
   WHERE EmployeeID = 1;

   SELECT * FROM Employees;
   SELECT ISNULL(SALARY , 0) AS ReplaceWith0 FROM Employees;


--Format the salary with commas using FORMAT().

  SELECT FORMAT(SALARY , 'C') AS FormatSalary FROM Employees

--Get the ASCII value of the first letter of each first name.

   SELECT ASCII(FIRSTNAME) AS AsciiLetter  FROM Employees;
 
--Use SUBSTRING() to extract domain name from email.

    SELECT * FROM Employees;
    SELECT SUBSTRING(EMAIL,CHARINDEX('@', EMAIL)+ 1, LEN(EMAIL)) AS DomainName FROM Employees;

--Count the number of characters (excluding spaces) in full name.
	
    SELECT * FROM Employees;
  SELECT LEN(CONCAT(FIRSTNAME , ' ' , LASTNAME)) AS CHARLENGTH  FROM Employees;
 
--Show the employees whose names start with ‘A’ using LIKE with functions.
				
  SELECT FIRSTNAME  FROM Employees
  WHERE FIRSTNAME LIKE 'A%';

--Pad employee ID with leading zeroes to make them 5-digit using RIGHT() and REPLICATE().

SELECT * FROM Employees;
SELECT RIGHT( REPLICATE( '0', 5) + CAST(EMPLOYEEID AS varchar), 5) FROM Employees

SELECT FORMAT(EmployeeID , 'D5') FROM Employees
--Convert FirstName to Proper Case using string functions.

 SELECT
    EmployeeID,
    UPPER(SUBSTRING(FirstName, 1, 1)) + LOWER(SUBSTRING(FirstName, 2, LEN(FirstName))) AS ProperFirstName
FROM Employees;


--Truncate salaries to 1 decimal using ROUND() and CAST().

  select * from Employees;

  SELECT ROUND( CAST(SALARY AS DECIMAL(10 ,1)) , 1) FROM Employees;


 --Convert DateOfJoining to format ‘DD-MM-YYYY’.

 SELECT FORMAT( DATEOFJOINING, 'dd-MM-yyyy' ) AS FORMAT FROM Employees

  

--Get the number of employees in each department using COUNT() and GROUP BY.

  SELECT 
    d.DepartmentID,
    d.DepartmentName,
    COUNT(e.EmployeeID) AS NumberOfEmplo
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;

--Calculate average salary using AVG().

 SELECT AVG(SALARY) FROM Employees

--Find the highest and lowest salaries using MAX() and MIN().
   
   SELECT * FROM Employees;
   SELECT MAX(SALARY) AS Maxsalary , MIN(SALARY) AS MinSalary FROM Employees

--Display total salary paid in each department using SUM() and GROUP BY.

   SELECT * FROM Employees;
   SELECT * FROM Departments;
   SELECT Departments.DepartmentName , SUM(EMPLOYEES.SALARY) AS Totalsalary FROM Departments 
   LEFT JOIN Employees
   ON Departments.DepartmentID  = Employees.DepartmentID
   GROUP BY  Departments.DepartmentName


--Find the number of employees who joined in each year.

update Employees
set DateOfJoining = '2021-03-15'
where EmployeeID = 1
     
SELECT * FROM Employees;
   SELECT DATEPART(YEAR,  DateOfJoining) AS Year , COUNT(EmployeeID) as NumEmplo  FROM Employees
   GROUP BY DATEPART(YEAR,  DateOfJoining)

--Get all departments with less than 5 employees.

    SELECT * FROM Employees;
	SELECT * FROM Departments;

SELECT Departments.DepartmentName , COUNT(Employees.EmployeeID) AS numberEmplo FROM Departments
LEFT JOIN Employees
ON Departments.DepartmentID = Employees.DepartmentID
GROUP BY Departments.DepartmentName 
HAVING COUNT(Employees.EmployeeID) < 5;


--Find total hours worked by each employee using aggregation.

   select * from Employees
   select * from EmployeeProjects
  
   select Employees.firstname  , sum(EmployeeProjects.HoursWorked) as totalhours from Employees
   left join EmployeeProjects
   on Employees.EmployeeID = EmployeeProjects.EmployeeID
   group by Employees.firstname 

--Show the number of employees assigned to each project.

   select * from Employees
  select * from Projects
   select * from EmployeeProjects
  
   SELECT P.ProjectName , COUNT(EP.EmployeeID) AS NumberofEmplo FROM  Projects P
   LEFT JOIN EmployeeProjects EP ON EP.ProjectID = P.ProjectID
   LEFT JOIN Employees E ON EP.EmployeeID = E.EmployeeID
   GROUP BY P.ProjectName
  

--Find employees who have not worked on any project using LEFT JOIN and IS NULL.

   UPDATE EmployeeProjects 
   SET ProjectID = NULL
   WHERE EmployeeID = 4


   select * from Employees
   select * from Projects
   select * from EmployeeProjects
    
   SELECT E.FIRSTNAME   FROM  Employees E
   LEFT JOIN EmployeeProjects EP ON E.EmployeeID =EP.EmployeeID 
   LEFT JOIN Projects P ON EP.ProjectID = P.ProjectID
   WHERE EP.ProjectID IS NULL;



--Show projects that started in the last 60 days using DATEDIFF().

    update Projects
	 set StartDate = '2025-04-10' 
	where ProjectID = 201;
	
		SELECT * FROM Projects;

 SELECT * FROM Projects
  where DATEDIFF(DAY , startDate , GETDATE()) <=60
 
--Create a column that shows whether an employee’s salary is above or below average.

SELECT
    FIRSTNAME, Salary,
    CASE
        WHEN Salary > (SELECT AVG(Salary) FROM Employees) THEN 'SALARY IS ABOVE AVERAGE'
        ELSE 'SALARY IS BELOW AVERAGE'
    END AS SalaryStatus
FROM Employees;

--List employees with names longer than 10 characters.

SELECT  CONCAT(FIRSTNAME , ' ' , LASTNAME) as fullname ,  LEN(CONCAT(FIRSTNAME , ' ' , LASTNAME)) AS NameLongerThan10 FROM Employees
WHERE  LEN(CONCAT(FIRSTNAME , ' ' , LASTNAME)) > 10;

--Show employee ID, name, and a note saying "High Earner" if salary > 100000, else "Normal".

 
SELECT * FROM Employees;
 SELECT EmployeeID , FIRSTNAME , CASE WHEN SALARY > 100000 THEN 'High Earner' 
   ELSE 'Normal'
   END AS NOTE
   FROM Employees;

--Extract and list month names from StartDate of projects.
   SELECT * FROM Projects;
   SELECT DATENAME(MONTH, STARTDATE) FROM Projects;

--Count the number of distinct departments.

    UPDATE Departments
	SET DepartmentName = 'Marketing'
	where DepartmentID = 102;

  SELECT * FROM Departments
  SELECT   COUNT( DISTINCT DepartmentName ) FROM Departments;

--Show employees who joined on a weekend.

SELECT 
    EmployeeID,
    FirstName,
    LastName,
datename(WEEKDAY, dateofjoining)    
FROM Employees
where DATEPART(WEEKDAY,dateofjoining  ) in  (6,7)


--Rank employees by salary using DENSE_RANK().

   select firstname , salary , dense_rank() over( order by  salary desc) as dencerank
   from Employees;

--Use COALESCE() to handle nulls in multiple columns.

 UPDATE Employees
 SET DateOfJoining = NULL
 WHERE EmployeeID = 2;

    select * from Employees
	select * from projects
	select * from EmployeeProjects

	SELECT E.FirstName , E.DateOfJoining , P.EndDate , COALESCE(E.DATEOFJOINING , P.ENDDATE) FROM EmployeeProjects EP
	JOIN Employees E ON EP.EmployeeID = E.EmployeeID
	JOIN Projects P ON EP.ProjectID = P.ProjectID

--Show average hours worked per employee per project.

	   
    select * from Employees
	select * from projects
	select * from EmployeeProjects


SELECT E.FirstName , P.ProjectName , AVG(EP.HoursWorked)  AS AvgWorkHour FROM EmployeeProjects EP
JOIN Employees E  ON EP.EmployeeID = E.EmployeeID
JOIN Projects P ON EP.ProjectID = P.ProjectID
GROUP BY E.FIRSTNAME , P.ProjectName

--Find employees who have worked more than 100 hours on any project.


    select * from Employees
	select * from projects
	select * from EmployeeProjects


 SELECT E.FirstName , P.ProjectName , EP.HoursWorked   FROM EmployeeProjects EP
JOIN Employees E  ON EP.EmployeeID = E.EmployeeID
 JOIN Projects P ON EP.ProjectID = P.ProjectID
WHERE EP.HoursWorked > 100;


--Create a report showing each department's average salary and the percentage of each employee’s salary to that average.

  UPDATE Employees
  SET Salary = 60000.00
  WHERE EmployeeID = 1

	SELECT * FROM Employees;

	 WITH AvgSalary AS (
	 SELECT DepartmentID ,AVG(Salary) AS Average FROM Employees GROUP BY   DepartmentID)

	 select Employees.FirstName , Employees.DepartmentID, Employees.Salary , AvgSalary.Average  ,  round(CAST((Employees.Salary* 100.00) / AvgSalary.Average AS decimal(10,2)), 2)   from Employees
     join AvgSalary
	 on Employees.DepartmentID = AvgSalary.DepartmentID;
;


--Generate an email alias like firstname.lastname@company.com using string functions.

   
   select * from Employees
   
   SELECT EMAIL,  REPLACE(EMAIL, SUBSTRING(EMAIL, 1, CHARINDEX('@' , EMAIL)-1) ,CONCAT(FIRSTNAME, '.', LASTNAME)) FROM Employees
      
   SELECT CONCAT(LOWER(FIRSTNAME), '.' , LOWER(LASTNAME)) + '@corp.com' from Employees

--For each employee, calculate the total number of working days since they joined (excluding weekends).

   select * from Employees ;     
   
   SELECT DATEDIFF(DAY, DATEOFJOINING, GETDATE() ) - (DATEDIFF(WEEK , DATEOFJOINING , GETDATE())* 2) FROM Employees

--Write a query to find employees who have worked on all projects.

	SELECT * FROM Projects
	SELECT * FROM EmployeeProjects	
	
   SELECT EmployeeID  FROM EmployeeProjects
   GROUP BY EmployeeID
   HAVING COUNT(DISTINCT ProjectID) = (SELECT COUNT(*) FROM Projects)

--Get top 3 highest paid employees in each department using ROW_NUMBER().

SELECT * FROM Employees;
SELECT * FROM (SELECT EmployeeID ,  SALARY,  ROW_NUMBER() OVER(PARTITION BY DEPARTMENTID ORDER BY SALARY desc) AS RowNum FROM Employees) RowNum
   WHERE RowNum <=3;
    


--Generate a formatted string like:
--"John Smith works in IT department and joined on 12-Jan-2021" using concatenation and formatting.

  SELECT * FROM Employees;
  SELECT * FROM Departments

  SELECT CONCAT(Employees.FIRSTNAME , ' ' ,Employees.LASTNAME) + 'Works In ' + Departments.DepartmentName + 'Departments  and joined on' + FORMAT(dateofjoining, 'dd-MMM-yyyy' ) FROM Employees 
  JOIN Departments
  ON Employees.DepartmentID = Departments.DepartmentID;

 --Find departments where average salary is more than overall average salary using subqueries.
    SELECT * FROM Employees;
   SELECT DepartmentID  , AVG(SALARY) AS Avg_salary FROM Employees
   GROUP BY DepartmentID
   HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM Employees)
   
--Show employees who haven’t worked on any project in the last 30 days using date and join logic.

SELECT * FROM Employees
SELECT * FROM Projects
SELECT * FROM EmployeeProjects

select E.FirstName , P.ProjectID, P.EndDate from EmployeeProjects EP
JOIN Employees E  ON EP.EmployeeID = E.EmployeeID
JOIN Projects P ON EP.ProjectID = P.ProjectID
WHERE P.EndDate <= DATEADD(DAY , -30 , GETDATE());


--Create a summary table that shows for each department:Total employees, Average salary, Earliest joining date, Total projects involved (via employees)
  select * From Departments;
  select * From Employees;
  select * From EmployeeProjects;
  SELECT * FROM Projects;

  
	SELECT Departments.DepartmentName,
	               count(DISTINCT Employees.EmployeeID) AS TotalEmpl , 
				   AVG(Employees.Salary) AS AvgSalary, 
				   MIN(Employees.DateOfJoining) AS Earliestjoining , 
				   COUNT(DISTINCT EmployeeProjects.ProjectID) AS TotalProjctEmpl  FROM Departments 
left JOIN Employees ON Departments.DepartmentID = Employees.DepartmentID
left JOIN EmployeeProjects ON EmployeeProjects.EmployeeID = Employees.EmployeeID
	GROUP BY Departments.DepartmentName;


--Generate a pipe-delimited string of project names for each employee like:
--John: ProjectA | ProjectB | ProjectC

SELECT * FROM Employees
SELECT * FROM Projects
SELECT * FROM EmployeeProjects
SELECT 
    e.FirstName + ': ' + 
    STRING_AGG(p.ProjectName, ' | ') AS ProjectList
FROM   EmployeeProjects  ep
JOIN Employees e  ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON ep.ProjectID = p.ProjectID
GROUP BY e.EmployeeID, e.FirstName;



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Sure! Here's a list of **SQL Server practice questions** focused on **user-defined functions (UDFs)** — scalar and table-valued — and their use within **stored procedures**.

CREATE TABLE Products_fn (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    Rating INT -- 1 to 5 stars
);

INSERT INTO Products_fn VALUES
(1, 'Pizza', 500.00, 5),
(2, 'Burger', 250.00, 4),
(3, 'Pasta', 350.00, 3),
(4, 'Fries', 150.00, 2),
(5, 'Salad', 200.00, 4),
(6, 'Soda', 100.00, 1);


CREATE TABLE Orders_fn (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    DiscountPercent INT,
    OrderDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products_fn(ProductID)
);

INSERT INTO Orders_fn VALUES
(101, 1, 2, 10, '2024-04-01'),
(102, 2, 1, 0,  '2024-04-10'),
(103, 3, 3, 5,  '2024-04-15'),
(104, 5, 2, 15, '2024-04-25'),
(105, 1, 1, 0,  '2024-05-01');


CREATE TABLE Coupons_fn (
    CouponCode VARCHAR(20) PRIMARY KEY,
    DiscountPercent INT,
    IsActive BIT
);

INSERT INTO Coupons_fn VALUES
('NEW50', 50, 1),
('SAVE10', 10, 1),
('EXPIRED', 30, 0);


--## ✅ **SQL Practice Questions on Functions & Procedures**

--Write a function that returns the square of a number.
    create function fn_sqrNumber (@productid int)
	 returns int
	as 
	begin 
	   declare @ratting int
	   SELECT @ratting = RATING * RATING FROM Products_fn
	      WHERE ProductID = @productid
		  RETURN @ratting
   END;	    
   
   SELECT dbo.fn_sqrNumber  (2);
--Create a function that returns the year from a given date.
      alter function fn_year (@orderId int)
	 returns int
	as 
	begin 
	   declare @year int
	   SELECT @year = YEAR(Orders_fn.OrderDate) FROM Orders_fn
	      WHERE OrderID = @orderId
		  RETURN @year
   END;	    
   
   SELECT dbo.fn_year  (102);


--Create a function that calculates GST (18%) on a given amount.

--Create a function that returns 'Pass' if marks >= 35, else 'Fail'.
      select * from Student
	  create function fn_resultMark
   ( @studentId int 
   
   )
   returns varchar(100)
    as
	begin 
	   declare @result varchar(100)
	   select @result = iif(marks>= 35, 'Pass', 'Fail') from Student where StudentID = @studentId

	   
	   return @result 
   end;
   update Student
   set Marks = 27
   where StudentID = 7

   select dbo.fn_resultMark  (1)

   select *, dbo.fn_resultMark  (studentId) from Student 
--1. **Create a scalar function** that calculates the final price after applying a given discount percent to a product price.

  select * from Products_fn
  select * from Orders_fn
  select * from Coupons_fn

   create function fn_FinalPrice
   ( @productId int ,
   @quantity int ,
   @Discount int
   )
   returns decimal(10,2)
    as
	begin 
	   declare @price decimal(10,2)
	   select @price = price from Products_fn where ProductID = @productId

	   declare @total decimal(10,2)
	   set  @total = @price * @quantity 

	   return @total - (@total *  @Discount /100) 
   end;

   select dbo.fn_FinalPrice (1,2,10);
	    
--2. **Create a stored procedure** that takes an `OrderID`, calculates the final price after discount using the function from Q1, and displays it.

    select * from Products_fn
  select * from Orders_fn
  select * from Coupons_fn
    
	create procedure get_discountPrice
	 @orderId  int 
	 as 
	 begin 
	   declare @productId int , @quantity int , @Discount int

	   select @productId = ProductID , @quantity = Quantity , @Discount = DiscountPercent 
	    from Orders_fn  
		where OrderID = @orderID

		select dbo.fn_FinalPrice(@productId ,@quantity , @Discount) as finalPrice
		end;

  exec get_discountPrice @orderId = 101;

--3. **Create a table-valued function** that returns all orders where the total amount after discount exceeds a given threshold.
            select * from Products_fn
  select * from Orders_fn
  select * from Coupons_fn

  create function fn_OrdersthresHold(
  @Aimamount int)
   returns table 
  as
  return 
      (
	    select O.ProductID ,
		O.Quantity, 
		O.DiscountPercent ,
		dbo.fn_FinalPrice(O.ProductID ,O.Quantity, O.DiscountPercent) as finalPrice
		from Orders_fn O
		where dbo.fn_FinalPrice(O.ProductID ,O.Quantity, O.DiscountPercent) > @Aimamount
	  ) 
   
   select * from fn_OrdersthresHold (500);

--4. **Create a stored procedure** that uses the function from Q3 to list orders above ₹500.

       create procedure get_above500
	   as
	   begin
	        select * from fn_OrdersthresHold (500)
	   end

	   exec get_above500;

--5. **Create a scalar function** that returns the tax amount (e.g., 18% GST) for a given price.

      alter function fn_withGst
	 ( @productId int
	  ) 
	  returns decimal(10,2)
	  as
	  begin
	   declare @Price int
	   select @price = price + (price * 18/100) from Products_fn 
	   where ProductID = @productId

   return @price
end
  
  select * , dbo.fn_withGst(productId) as GstPrice  from Products_fn;

--6. **Create a stored procedure** that calculates the total bill amount including discount and tax for a given order.

   alter procedure get_totalBillAmount
    @orderId int
	as 
	begin
	   declare @price int , @quantity int , @Discount int , @Total int 
	   
	   select @price = P.Price,
	       @quantity = O.Quantity,
		   @Discount = O.DiscountPercent
		   from Orders_fn O 
		   join Products_fn P   on O.ProductID = P.ProductID
		   where OrderID = @orderId;

		--select @Total = ((@price * @quantity)- @Discount ) + (((@price * @quantity)- @Discount ) * 0.18) ;

		    SET @total = (@price * @quantity) * (1 - @Discount / 100.0) * 1.18;


		select @price AS Price, @quantity AS Quantity, @Discount as Discount,  @Total as FinalPrice
	end;

	exec  get_totalBillAmount @orderId = 101


--7. **Create a table-valued function** that returns all products with a price greater than the average product price.
--8. **Create a stored procedure** that lists all such above-average priced products using the function from Q7.
--9. **Create a scalar function** to return a rating category ("High", "Medium", "Low") based on a numeric rating input.
--10. **Create a stored procedure** that uses the above function to show each product and its rating category based on a `Rating` column.
--11. **Create a table-valued function** that returns all orders with more than 2 quantities and less than 10% discount.
--12. **Create a scalar function** that converts a numeric value to a formatted currency string (e.g., ₹1,000.00).
--13. **Create a stored procedure** that uses this currency-formatting function to display all order totals in INR format.
--14. **Create a table-valued function** that lists orders placed on a specific date (pass date as parameter).
--15. **Create a stored procedure** that calls the above function to get daily order reports.
--16. **Create a scalar function** that returns the number of days between order date and current date.
--17. **Create a stored procedure** that shows all orders older than 30 days using the above function.
--18. **Create a table-valued function** that returns all products that have not been ordered yet.
--19. **Create a scalar function** that returns a delivery charge based on total order amount (e.g., free delivery above ₹500).
--20. **Create a stored procedure** that computes total amount + delivery charge using functions from Q1 and Q19.



