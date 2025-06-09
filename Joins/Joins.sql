  CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactEmail VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName, ContactEmail, City, Country) 
VALUES 
(1, 'Alice Johnson', 'alice.johnson@example.com', 'New York', 'USA'),
(2, 'Bob Smith', 'bob.smith@example.com', 'Los Angeles', 'USA'),
(3, 'Carlos Rivera', 'carlos.rivera@example.com', 'Madrid', 'Spain'),
(4, 'Diana Patel', 'diana.patel@example.com', 'Mumbai', 'India'),
(5, 'Ethan Zhang', 'ethan.zhang@example.com', 'Beijing', 'China'),
(6, 'Fiona Müller', 'fiona.muller@example.com', 'Berlin', 'Germany'),
(7, 'George Brown', 'george.brown@example.com', 'Toronto', 'Canada'),
(8, 'Hana Suzuki', 'hana.suzuki@example.com', 'Tokyo', 'Japan'),
(9, 'Ivan Ivanov', 'ivan.ivanov@example.com', 'Moscow', 'Russia'),
(10, 'Julia Silva', 'julia.silva@example.com', 'São Paulo', 'Brazil');


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, OrderDate, CustomerID, TotalAmount)
VALUES
(101, '2024-03-15', 1, 250.75),
(102, '2024-03-17', 3, 180.00),
(103, '2024-03-20', 2, 560.50),
(104, '2024-03-22', 5, 99.99),
(105, '2024-03-25', 8, 340.20);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, Price)
VALUES
(201, 'Wireless Mouse', 1, 101, 15.99),
(202, 'Mechanical Keyboard', 102, 2, 49.99),
(203, 'LED Monitor 24"', 2, 103, 129.99),
(204, 'USB-C Hub', 1, 104, 25.50),
(205, 'External Hard Drive 1TB', 3, 105, 69.00);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
(1, 101, 201, 2),    -- 2 Wireless Mice in Order 1001
(2, 102, 204, 1),    -- 1 USB-C Hub in Order 1001
(3, 103, 202, 1),    -- 1 Mechanical Keyboard in Order 1002
(4, 104, 203, 2),    -- 2 LED Monitors in Order 1003
(5, 105, 205, 1);    -- 1 External Hard Drive in Order 1004


CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

INSERT INTO Categories (CategoryID, CategoryName)
VALUES
(1, 'Computer Accessories'),
(2, 'Keyboards'),
(3, 'Monitors'),
(4, 'Storage Devices'),
(5, 'Cables & Hubs');


CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactEmail VARCHAR(100)
);

INSERT INTO Suppliers (SupplierID, SupplierName, ContactEmail) VALUES
(101, 'TechWorld Inc.', 'contact@techworld.com'),
(102, 'Office Supplies Co.', 'support@officeco.com'),
(103, 'GadgetHub', 'sales@gadgethub.com'),
(104, 'CompuGlobal', 'info@compuglobal.com'),
(105, 'SmartBuy Ltd.', 'service@smartbuy.com');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    ManagerID INT,
    DepartmentID INT,
    HireDate DATE,
    JobTitle VARCHAR(100),
	
   FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),	
);

INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID,  DepartmentID, HireDate, JobTitle) VALUES
(1, 'Alice Johnson', NULL, 1, '2015-03-15', 'CTO'),
(2, 'Bob Smith', 1,  2, '2017-07-10', 'Software Engineer'),
(3, 'Charlie Lee', 1, 2, '2018-09-22', 'QA Analyst'),
(4, 'Dana White', 2,  3, '2020-01-13', 'Technical Writer'),
(5, 'Ethan Brown', 2, 3, '2021-06-30', 'Support Engineer');

DROP TABLE Departments


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Executive'),
(2, 'Engineering'),
(3, 'Support'),
(4, 'Human Resources'),
(5, 'Marketing');

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    MentorID INT,
    FOREIGN KEY (MentorID) REFERENCES Students(StudentID)
);

INSERT INTO Students (StudentID, StudentName, MentorID) VALUES
(1, 'John Doe', NULL),
(2, 'Jane Smith', 1),
(3, 'Emily Davis', 1),
(4, 'Michael Johnson', 2),
(5, 'Sarah Brown', 3);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

INSERT INTO Courses (CourseID, CourseName) VALUES
(1, 'Mathematics'),
(2, 'Physics'),
(3, 'Computer Science'),
(4, 'English Literature'),
(5, 'History');

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1, 1, 1, 'A'),
(2, 2, 3, 'B'),
(3, 3, 2, 'A'),
(4, 4, 4, 'C'),
(5, 5, 5, 'B');

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

INSERT INTO Authors (AuthorID, AuthorName) VALUES
(1, 'George Orwell'),
(2, 'Jane Austen'),
(3, 'Mark Twain'),
(4, 'J.K. Rowling'),
(5, 'Ernest Hemingway');

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

INSERT INTO Books (BookID, Title, AuthorID) VALUES
(1, '1984', 1),
(2, 'Pride and Prejudice', 2),
(3, 'Adventures of Huckleberry Finn', 3),
(4, 'Harry Potter and the Sorcerer''s Stone', 4),
(5, 'The Old Man and the Sea', 5);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);




INSERT INTO Projects (ProjectID, ProjectName, ManagerID) VALUES
(1, 'AI Research', 1),
(2, 'Mobile App Development', 2),
(3, 'Customer Support System', 3),
(4, 'Website Redesign', 1),
(5, 'Employee Training Platform', 2);


CREATE TABLE ProjectAssignments (
    AssignmentID INT PRIMARY KEY,
    ProjectID INT,
    EmployeeID INT,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


INSERT INTO ProjectAssignments (AssignmentID, ProjectID, EmployeeID) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 5),
(5, 5, 2);




-- 🔹 **Basic INNER JOIN (1–20)**

-- 1. Get the names of all employees and their department names.
	   SELECT e.EmployeeName, d.DepartmentName from Employees e
	   join Departments d
	   on e.DepartmentID = d.DepartmentID;
  
--2. List all orders along with the names of the customers who placed them.
	  select c.CustomerName, o.OrderID from Customers c
	  join Orders o
	  on c.CustomerID = o.CustomerID;	

--3. Show the product name and category name for all products

		select p.ProductName , c.CategoryName from Products p
		join Categories c
		on  p.CategoryID = c.CategoryID;

--4. List students and the courses they are enrolled in.

	   SELECT s.StudentName, c.CourseName FROM Students s
	   join Courses c
	   on s.StudentID = c.CourseID;	


--5. Retrieve book titles and author names.
		 select b.Title, a.AuthorName from Books b
		 join Authors a
		 on b.AuthorID = a.AuthorID;

--6. Show all invoices along with the customer’s name and country.

		CREATE TABLE Invoices (
		InvoiceID INT PRIMARY KEY,
		InvoiceDate DATE,
		CustomerID INT,
		TotalAmount DECIMAL(10, 2),
		FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
	);


	INSERT INTO Invoices (InvoiceID, InvoiceDate, CustomerID, TotalAmount) VALUES
	(1001, '2024-12-01', 1, 150.00),
	(1002, '2024-12-02', 2, 325.50),
	(1003, '2024-12-03', 3, 89.90),
	(1004, '2024-12-04', 4, 245.75),
	(1005, '2024-12-05', 5, 500.00);

	SELECT  i.InvoiceID, i.InvoiceDate,  c.CustomerName,  c.Country,  i.TotalAmount
	FROM Invoices i
	JOIN  Customers c
	ON i.CustomerID = c.CustomerID;



--7. Display all projects and their assigned manager names.
	   SELECT * FROM Projects;
	   SELECT * FROM Employees;

		  SELECT p.ProjectName, e.EmployeeName AS ManagerName FROM Projects P
		  JOIN Employees e
		  ON P.ManagerID = e.EmployeeID;

--8. List all patients and their attending doctors.
		 CREATE TABLE Patients (
		PatientID INT PRIMARY KEY,
		PatientName VARCHAR(100),
		Age INT,
		DoctorID INT,
		FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
		);

		INSERT INTO Patients (PatientID, PatientName, Age, DoctorID) VALUES
		(1, 'Alice Green', 28, 101),
		(2, 'Brian Fox', 42, 102),
		(3, 'Catherine Lee', 33, 103);


		 CREATE TABLE Doctors (
			DoctorID INT PRIMARY KEY,
			DoctorName VARCHAR(100),
			Specialty VARCHAR(100)
		);

		INSERT INTO Doctors (DoctorID, DoctorName, Specialty) VALUES
		(101, 'Dr. Smith', 'Cardiology'),
		(102, 'Dr. Johnson', 'Neurology'),
		(103, 'Dr. Patel', 'General Medicine');

		select P.PatientName , D.DoctorName, D.Specialty  from Patients P
		JOIN Doctors D
		ON P.DoctorID = D.DoctorID;
     
--9. Retrieve order details along with the corresponding product names.
		  SELECT O.OrderDetailID , P.ProductName FROM OrderDetails O
		  JOIN Products P
		  ON O.ProductID = P.ProductID;

--10. Get all employees with their job titles.
		 SELECT EmployeeName, JobTitle FROM Employees;


--11. Show all sales along with salesperson names.
       
			   CREATE TABLE Salespersons (
			  SalespersonID INT PRIMARY KEY,
			  Name VARCHAR(100)
			  );
   
	
	 
		INSERT INTO Salespersons (SalespersonID, Name) VALUES
		(1, 'Alice'),
		(2, 'Bob'),
		(3, 'Charlie'),
		(4, 'David');

		CREATE TABLE Sales (
			SaleID INT PRIMARY KEY,
			SalespersonID INT,
			Amount DECIMAL(10,2),
			SaleDate DATE,
			FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID)
		);
    


		INSERT INTO Sales (SaleID, SalespersonID, Amount, SaleDate) VALUES
		(101, 1, 500.00, '2024-06-01'),
		(102, 2, 750.50, '2024-06-03'),
		(103, 1, 320.00, '2024-06-05'),
		(104, 3, 1200.00, '2024-06-06'),
		(105, 4, 950.75, '2024-06-07');

		 select S.SaleID, S.Amount, S.SaleDate, Sa.Name from Sales S
		  JOIN Salespersons Sa
		  ON S.SalespersonID = Sa.SalespersonID;


--12. Get all transactions and the bank branch they occurred in.

			 CREATE TABLE Transactions (
			TransactionID INT PRIMARY KEY,
			TransactionDate DATE,
			Amount DECIMAL(10, 2),
			BranchID INT,
			FOREIGN KEY (BranchID) REFERENCES BankBranches(BranchID)
		);

		INSERT INTO Transactions (TransactionID, TransactionDate, Amount, BranchID) VALUES
		(1, '2025-04-01', 1500.00, 101),
		(2, '2025-04-02', 300.00, 102),
		(3, '2025-04-03', 1200.00, 103);

		

		   CREATE TABLE BankBranches (
			BranchID INT PRIMARY KEY,
			BranchName VARCHAR(100),
			Location VARCHAR(100)
		);

		INSERT INTO BankBranches (BranchID, BranchName, Location) VALUES
		(101, 'Main Street Branch', 'Downtown'),
		(102, 'West End Branch', 'West City'),
		(103, 'Eastside Branch', 'East City');

		SELECT T.TransactionID, T.TransactionDate, T.Amount, B.BranchName, B.Location FROM Transactions T
		 JOIN BankBranches B
		 ON T.BranchID = b.BranchID;

--13. List all vehicles and their owners. 
     
			 CREATE TABLE Vehicles (
			VehicleID INT PRIMARY KEY,
			VehicleName VARCHAR(100),
			VehicleType VARCHAR(50),
			OwnerID INT,
			FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
		);

		INSERT INTO Vehicles (VehicleID, VehicleName, VehicleType, OwnerID) VALUES
		(1, 'Toyota Corolla', 'Car', 101),
		(2, 'Honda Civic', 'Car', 102),
		(3, 'Ford F-150', 'Truck', 103),
		(4, 'Tesla Model 3', 'Car', 104),
		(5, 'Yamaha R1', 'Motorcycle', 105);


		   CREATE TABLE Owners (
			OwnerID INT PRIMARY KEY,
			OwnerName VARCHAR(100),
			Address VARCHAR(150)
		);

		INSERT INTO Owners (OwnerID, OwnerName, Address) VALUES
		(101, 'John Doe', '123 Elm St, Springfield'),
		(102, 'Jane Smith', '456 Oak St, Riverside'),
		(103, 'Alice Brown', '789 Pine St, Greendale'),
		(104, 'Bob White', '101 Maple St, Lakeside'),
		(105, 'Charlie Green', '202 Birch St, Hilltop');

		SELECT V.VehicleName, V.VehicleType, O.OwnerName FROM Vehicles V
		JOIN Owners O
		ON V.OwnerID = O.OwnerID;

--14. Show all classes with their teachers.
     
			  CREATE TABLE Classes (
			ClassID INT PRIMARY KEY,
			ClassName VARCHAR(100),
			TeacherID INT,
			FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
		);
		
		
		INSERT INTO Classes (ClassID, ClassName, TeacherID) VALUES
		(1, 'Mathematics', 101),
		(2, 'Physics', 102),
		(3, 'Chemistry', 103),
		(4, 'Biology', 104),
		(5, 'Computer Science', 105);
  
		   CREATE TABLE Teachers (
			TeacherID INT PRIMARY KEY,
			TeacherName VARCHAR(100),
			Department VARCHAR(100)
		);

		
		INSERT INTO Teachers (TeacherID, TeacherName, Department) VALUES
		(101, 'Dr. Alice Johnson', 'Mathematics'),
		(102, 'Mr. Bob Smith', 'Physics'),
		(103, 'Dr. Charlie Williams', 'Chemistry'),
		(104, 'Ms. Diana Taylor', 'Biology'),
		(105, 'Dr. Edward Brown', 'Computer Science');

		SELECT C.ClassName , T.TeacherName from Classes C
		JOIN Teachers T
		ON C.TeacherID =T.TeacherID;



--15. Get all movie names and their directors.

		CREATE TABLE Movies (
			MovieID INT PRIMARY KEY,
			MovieName VARCHAR(100),
			DirectorID INT,
			FOREIGN KEY (DirectorID) REFERENCES Directors(DirectorID)
		);

		INSERT INTO Movies (MovieID, MovieName, DirectorID) VALUES
		(101, 'Inception', 1),
		(102, 'Jurassic Park', 2),
		(103, 'Barbie', 3),
		(104, 'Pulp Fiction', 4),
		(105, 'Avatar', 5);

    
			CREATE TABLE Directors (
			DirectorID INT PRIMARY KEY,
			DirectorName VARCHAR(100)
		);

		INSERT INTO Directors (DirectorID, DirectorName) VALUES
		(1, 'Christopher Nolan'),
		(2, 'Steven Spielberg'),
		(3, 'Greta Gerwig'),
		(4, 'Quentin Tarantino'),
		(5, 'James Cameron');

		SELECT M.MovieName, D.DirectorName FROM Movies M
		JOIN Directors D
		ON M.DirectorID = D.DirectorID;


--16. List all athletes with their respective teams.
   
			CREATE TABLE Teams (
			TeamID INT PRIMARY KEY,
			TeamName VARCHAR(100)
		);

		INSERT INTO Teams (TeamID, TeamName) VALUES
		(1, 'Lions'),
		(2, 'Tigers'),
		(3, 'Eagles'),
		(4, 'Sharks'),
		(5, 'Wolves');

		   CREATE TABLE Athletes (
			AthleteID INT PRIMARY KEY,
			AthleteName VARCHAR(100),
			TeamID INT,
			FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
		);

		INSERT INTO Athletes (AthleteID, AthleteName, TeamID) VALUES
		(101, 'John Smith', 1),
		(102, 'Emily Davis', 2),
		(103, 'Carlos Martinez', 3),
		(104, 'Ravi Patel', 4),
		(105, 'Linda Zhao', 5),
		(106, 'Mohamed Salah', 1),
		(107, 'Sakura Tanaka', 3);

		SELECT A.AthleteName, T.TeamName
		FROM Athletes A
		JOIN Teams T 
		ON A.TeamID = T.TeamID;

--17. Show products and their suppliers.
		 SELECT P.ProductName, S.SupplierName  FROM Products P
		 JOIN Suppliers S
		 ON P.SupplierID = S.SupplierID;

--18. List blog posts with their respective authors.

			 CREATE TABLE Authors (
			AuthorID INT PRIMARY KEY,
			AuthorName VARCHAR(100)
		);

		INSERT INTO Authors (AuthorID, AuthorName) VALUES
		(1, 'Alice Johnson'),
		(2, 'Bob Smith'),
		(3, 'Carla Gomez'),
		(4, 'David Lee');

		   CREATE TABLE BlogPosts (
			PostID INT PRIMARY KEY,
			Title VARCHAR(200),
			AuthorID INT,
			PostDate DATE,
			FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
		);

		INSERT INTO BlogPosts (PostID, Title, AuthorID, PostDate) VALUES
		(101, 'Understanding SQL Joins', 1, '2024-10-01'),
		(102, 'Top 10 JavaScript Tips', 2, '2024-10-05'),
		(103, 'A Guide to Data Modeling', 1, '2024-10-10'),
		(104, 'Building APIs with Node.js', 3, '2024-10-12');

		 SELECT BlogPosts.Title, Authors.AuthorName
		FROM BlogPosts
		JOIN Authors ON BlogPosts.AuthorID = Authors.AuthorID;


--19. Show employees and the location of their offices.

		   CREATE TABLE Employee (
			EmployeeID INT PRIMARY KEY,
			EmployeeName VARCHAR(100),
			OfficeID INT,
			FOREIGN KEY (OfficeID) REFERENCES Offices(OfficeID)
		);

		INSERT INTO Employee (EmployeeID, EmployeeName, OfficeID) VALUES
		(201, 'Sophia Brown', 1),
		(202, 'Liam Wilson', 2),
		(203, 'Olivia Chen', 3),
		(204, 'Noah Kim', 1),
		(205, 'Mia Schulz', 4);

		CREATE TABLE Offices (
			OfficeID INT PRIMARY KEY,
			Location VARCHAR(100)
		);

		INSERT INTO Offices (OfficeID, Location) VALUES
		(1, 'New York'),
		(2, 'London'),
		(3, 'Tokyo'),
		(4, 'Berlin');

		SELECT Employee.EmployeeName, Offices.Location FROM Employee E
		JOIN Offices O
		ON E.OfficeID = O.OfficeID;


--20. Display all items in a shopping cart with product descriptions.
 
		 CREATE TABLE ShoppingCart (
			CartID INT PRIMARY KEY,
			ProductID INT,
			Quantity INT,
			FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
		);
		INSERT INTO ShoppingCart (CartID, ProductID, Quantity) VALUES
		(1, 201, 2),
		(2, 202, 1),
		(3, 204, 3),
		(4, 203, 1),
		(5, 205, 2);

		SELECT sc.CartID, p.ProductName, p.Price, sc.Quantity, (p.Price * sc.Quantity) AS TotalPrice FROM  ShoppingCart sc
		JOIN Products p
		ON sc.ProductID = p.ProductID;





-- 🔹 **LEFT JOIN (21–40)**

--21. List all customers, even those who haven’t placed orders.
       select * from Customers;
       select * from Orders;

	   select C.CustomerName , C.City , O.OrderDate from Customers C
	   left join Orders O
	   ON C.CustomerID = O.CustomerID
	   
--22. Get all products and their order quantities (even if never ordered).
		 select *  from Products;
		 select * from OrderDetails;

		 select P.ProductID, P.ProductName , O.Quantity from Products P
		 left join OrderDetails  O
		 on P.ProductID = O.ProductID;
--23. Show all students and the grades they've received (if any).
        SELECT Name, Grade FROM Student;
	   

--24. List all employees and their assigned projects (if any).
		  SELECT * FROM Employees;
		  SELECT * FROM Projects;

		  SELECT E.EmployeeName , P.ProjectName from Employees E
		  LEFT JOIN Projects P
		  ON  E.ManagerID = P.ManagerID;


--25. Show all departments and their employees (if any).

       SELECT * FROM Departments;
	   SELECT * FROM Employees;
	    
		SELECT D.DepartmentName , E.EmployeeName , E.HireDate FROM Departments D
		LEFT JOIN Employees E
		ON D.DepartmentID = E.DepartmentID;


--26. Display all articles and any comments (if any).
		CREATE TABLE Articles (
		ArticleID INT PRIMARY KEY,
		Title VARCHAR(100),
		Content TEXT,
		PublishDate DATE
	);

	INSERT INTO Articles (ArticleID, Title, Content, PublishDate) VALUES
	(1, 'What is SQL?', 'An introduction to SQL.', '2024-12-01'),
	(2, 'Data Normalization', 'Steps of normalizing a database.', '2025-01-15'),
	(3, 'Understanding Indexes', 'Speed up queries with indexes.', '2025-02-10'),
	(4, 'Stored Procedures', 'Reusable logic in SQL.', '2025-03-05');

	CREATE TABLE Comments (
		CommentID INT PRIMARY KEY,
		ArticleID INT,
		CommentText VARCHAR(255),
		CommentDate DATE,
		FOREIGN KEY (ArticleID) REFERENCES Articles(ArticleID)
	);

	INSERT INTO Comments (CommentID, ArticleID, CommentText, CommentDate) VALUES
	(1, 1, 'Very helpful, thanks!', '2025-01-01'),
	(2, 1, 'Needs more examples.', '2025-01-02'),
	(3, 2, 'Clear and concise!', '2025-01-20'),
	(4, 3, 'Great explanation of indexes.', '2025-02-15');

	SELECT   A.ArticleID,  A.Title, C.CommentText, C.CommentDate
	FROM  Articles A
	LEFT JOIN  Comments C
	ON A.ArticleID = C.ArticleID;

    
--27. List all books, even those without an author (null author\_id).
	   SELECT * FROM Books;
	   SELECT * FROM Authors;
	   SELECT B.Title , A.AuthorName FROM Books B
	   LEFT JOIN Authors A
	   ON B.AuthorID = A.AuthorID;

--28. Show all courses, including those with no enrollments.
       
		   SELECT *  FROM Courses;
		   SELECT * FROM Enrollments;
		   SELECT C.CourseName , E.EnrollmentID FROM Courses C
		   LEFT JOIN Enrollments E
		   ON C.CourseID = E.CourseID;

--29. Get all users and their last login time (if logged in).
			   CREATE TABLE Users (
			UserID INT PRIMARY KEY,
			UserName VARCHAR(100),
			Email VARCHAR(100)
		   );

		INSERT INTO Users (UserID, UserName, Email) VALUES
		(1, 'Alice', 'alice@example.com'),
		(2, 'Bob', 'bob@example.com'),
		(3, 'Charlie', 'charlie@example.com'),
		(4, 'Daisy', 'daisy@example.com');

		CREATE TABLE Logins (
			LoginID INT PRIMARY KEY,
			UserID INT,
			LoginTime DATETIME,
			FOREIGN KEY (UserID) REFERENCES Users(UserID)
		);

		INSERT INTO Logins (LoginID, UserID, LoginTime) VALUES
		(1, 1, '2025-05-01 09:00:00'),
		(2, 2, '2025-05-03 14:25:00'),
		(3, 1, '2025-05-04 08:15:00'),
		(4, 3, '2025-05-02 17:45:00');


		SELECT  U.UserID, U.UserName, L.LoginTime FROM Users U
		LEFT JOIN Logins L 
		ON U.UserID = L.UserID;




--30. List all patients, even if no appointment is scheduled.
      
	  
			  CREATE TABLE Appointments (
			AppointmentID INT PRIMARY KEY,
			PatientID INT,
			AppointmentDate DATE,
			DoctorName VARCHAR(100),
			Reason VARCHAR(200),
			FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
		   );

		INSERT INTO Appointments (AppointmentID, PatientID, AppointmentDate, DoctorName, Reason)
		VALUES
		(101, 1, '2025-05-01', 'Dr. Kapoor', 'General Checkup'),
		(102, 3, '2025-05-03', 'Dr. Mehta', 'Dental Cleaning'),
		(104, 2, '2025-05-10', 'Dr. Kapoor', 'Blood Test');

		   SELECT * FROM Patients;
		  SELECT * FROM Appointments;
		  SELECT P.PatientName , A.DoctorName , A.AppointmentDate, A.Reason FROM Patients P
		  LEFT JOIN Appointments A
		  ON P.PatientID = A.PatientID;

--31. Show all teachers, even if they are not teaching any class.

		  SELECT * FROM Classes;
		  SELECT * FROM Teachers;
		  SELECT T.TeacherName, C.ClassName  FROM Teachers T
		   LEFT JOIN Classes C
		   ON T.TeacherID = C.TeacherID;

--32. List all cars, even those not assigned to any customer.
				CREATE TABLE Cars (
			CarID INT PRIMARY KEY,
			CarModel VARCHAR(100),
			Year INT,
			CustomerID INT NULL,
			FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
		  );   
		   INSERT INTO Cars (CarID, CarModel, Year, CustomerID)
		VALUES
		(1, 'Toyota Camry', 2020, 1),
		(2, 'Honda Civic', 2019, 2),
		(3, 'Ford Mustang', 2022, NULL),  
		(4, 'Tesla Model 3', 2023, 4),
		(5, 'Hyundai Elantra', 2018, NULL); 

			  SELECT * FROM Cars
			  SELECT * FROM Customers

			  SELECT C.CarModel , Cu.CustomerName FROM Cars C
			  LEFT JOIN Customers Cu
			  ON C.CustomerID = Cu.CustomerID;

--33. Get all songs and their album names (even if not in any album).

		CREATE TABLE Albums (
			AlbumID INT PRIMARY KEY,
			AlbumName VARCHAR(100)
		);

		CREATE TABLE Songs (
			SongID INT PRIMARY KEY,
			SongTitle VARCHAR(100),
			AlbumID INT NULL,
			FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
		);


		INSERT INTO Albums (AlbumID, AlbumName)
		VALUES
		(1, 'Skyfall Hits'),
		(2, 'Chill Vibes'),
		(3, 'Rock Legends');


		INSERT INTO Songs (SongID, SongTitle, AlbumID)
		VALUES
		(1, 'Rolling in the Deep', 1),
		(2, 'Ocean Drive', 2),
		(3, 'Bohemian Rhapsody', 3),
		(4, 'Lonely Road', NULL),  -- Not part of any album
		(5, 'Moonlight Whisper', NULL);  -- Not part of any album

			SELECT * FROM Songs;
			SELECT * FROM Albums;

			 SELECT S.SongTitle , A.AlbumName FROM Songs S
			 LEFT JOIN Albums A
			 ON S.AlbumID = A.AlbumID;
--34. Show all houses and the tenants living there (if any).
		   CREATE TABLE Houses (
			HouseID INT PRIMARY KEY,
			Address VARCHAR(100),
			City VARCHAR(50)
		);

		CREATE TABLE Tenants (
			TenantID INT PRIMARY KEY,
			TenantName VARCHAR(100),
			HouseID INT,
			FOREIGN KEY (HouseID) REFERENCES Houses(HouseID)
		);


		-- Houses
		INSERT INTO Houses (HouseID, Address, City) VALUES
		(1, '101 Green Street', 'New York'),
		(2, '202 Maple Avenue', 'Chicago'),
		(3, '303 Oak Road', 'Los Angeles'),
		(4, '404 Pine Blvd', 'Miami'),
		(5, '505 Elm Drive', 'Houston');


		
		INSERT INTO Tenants (TenantID, TenantName, HouseID) VALUES
		(1, 'Alice Johnson', 1),
		(2, 'Bob Smith', 2),
		(3, 'Charlie Davis', 3);

		SELECT * FROM Houses;
		SELECT * FROM Tenants;

		SELECT H.Address , H.City , T.TenantName FROM Houses H
		LEFT JOIN Tenants T
		ON H.HouseID = T.HouseID;



--35. List all posts and the number of likes (even if zero).
   
	   CREATE TABLE Posts (
		PostID INT PRIMARY KEY,
		Title VARCHAR(100)
	);

	CREATE TABLE Likes (
		LikeID INT PRIMARY KEY,
		PostID INT,
		UserID INT
	);

	-- Posts
	INSERT INTO Posts (PostID, Title) VALUES
	(1, 'SQL Tips and Tricks'),
	(2, 'Introduction to T-SQL'),
	(3, 'Advanced Joins'),
	(4, 'Stored Procedures Explained'),
	(5, 'Indexes in SQL');

	-- Likes
	INSERT INTO Likes (LikeID, PostID, UserID) VALUES
	(17, 1, 101),
	(89, 1, 102),
	(56, 2, 103),
	(64, 3, 104);

	SELECT * FROM Likes;
	SELECT * FROM Posts;

	SELECT P.Title , L.LikeID FROM Posts P
	LEFT JOIN  Likes L
	ON P.PostID = L.PostID;
 
   
--36. Get all employees and their emergency contact details (if any).
		 CREATE TABLE EmergencyContacts (
		ContactID INT PRIMARY KEY,
		EmployeeID INT,
		ContactName VARCHAR(100),
		ContactPhone VARCHAR(20),
		FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
	);

	INSERT INTO EmergencyContacts (ContactID, EmployeeID, ContactName, ContactPhone) VALUES
	(1, 1, 'John Johnson', '555-1234'),
	(2, 3, 'Mary Davis', '555-5678'),
	(3, 5, 'Paul Miller', '555-9012');

	 SELECT * FROM Employees;
	 SELECT * FROM EmergencyContacts;

	 SELECT E.EmployeeName ,E.JobTitle , Em.ContactPhone  FROM Employees E
	 LEFT JOIN EmergencyContacts Em
	 ON  E.EmployeeID = Em.EmployeeID;

--37. Display all branches and their ATM machines (if any).


	CREATE TABLE ATMs (
		ATMID INT PRIMARY KEY,
		BranchID INT,
		ATMLocation VARCHAR(100),
		FOREIGN KEY (BranchID) REFERENCES BankBranches(BranchID)
	);

	-- ATMs
	INSERT INTO ATMs (ATMID, BranchID, ATMLocation) VALUES
	(1, 101, 'Lobby'),
	(2, 102, 'Parking Lot'),
	(3, 103, 'Front Door');
  
  
	  SELECT * FROM ATMs;
	  SELECT * FROM BankBranches;
	  SELECT Ba.BranchName, A.ATMLocation FROM BankBranches Ba
	  LEFT JOIN ATMs A
	  ON Ba.BranchID = A.BranchID;

 --38. List all schools and their principals (even if no principal assigned).
	  CREATE TABLE Schools (
		SchoolID INT PRIMARY KEY,
		SchoolName VARCHAR(100),
		Location VARCHAR(100)
	);

	CREATE TABLE Principals (
		PrincipalID INT PRIMARY KEY,
		PrincipalName VARCHAR(100),
		SchoolID INT,
		FOREIGN KEY (SchoolID) REFERENCES Schools(SchoolID)
	);

	-- Schools
	INSERT INTO Schools (SchoolID, SchoolName, Location) VALUES
	(1, 'Greenwood High', 'California'),
	(2, 'Oakwood Academy', 'Texas'),
	(3, 'Riverside School', 'New York'),
	(4, 'Pinehill School', 'Florida');

	-- Principals
	INSERT INTO Principals (PrincipalID, PrincipalName, SchoolID) VALUES
	(1, 'Mr. John Doe', 1),
	(2, 'Mrs. Jane Smith', 2);

	SELECT * FROM Schools;
	SELECT * FROM Principals;

	SELECT S.SchoolName, S.Location , P.PrincipalName FROM Schools S
	LEFT JOIN Principals P
	ON  S.SchoolID = P.SchoolID;


--39. Get all flights and the corresponding pilots (if any).

	 CREATE TABLE Flights (
		FlightID INT PRIMARY KEY,
		FlightName VARCHAR(100),
		DepartureCity VARCHAR(100),
		ArrivalCity VARCHAR(100)
	);

	CREATE TABLE Pilots (
		PilotID INT PRIMARY KEY,
		PilotName VARCHAR(100)
	);

	CREATE TABLE FlightAssignments (
		AssignmentID INT PRIMARY KEY,
		FlightID INT,
		PilotID INT,
		FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
		FOREIGN KEY (PilotID) REFERENCES Pilots(PilotID)
	);

	  -- Flights
	INSERT INTO Flights (FlightID, FlightName, DepartureCity, ArrivalCity) VALUES
	(1, 'Flight 101', 'New York', 'London'),
	(2, 'Flight 102', 'Chicago', 'Paris'),
	(3, 'Flight 103', 'Los Angeles', 'Tokyo');

	-- Pilots
	INSERT INTO Pilots (PilotID, PilotName) VALUES
	(1, 'Captain Mike'),
	(2, 'Captain Sarah'),
	(3, 'Captain Alex');

	-- Flight Assignments
	INSERT INTO FlightAssignments (AssignmentID, FlightID, PilotID) VALUES
	(1, 1, 1),
	(2, 2, 2);

	SELECT * FROM Flights;
	SELECT * FROM Pilots;
	SELECT * FROM FlightAssignments;

	SELECT Flights.FlightName, Flights.DepartureCity, Flights.ArrivalCity , Pilots.PilotName FROM Flights 
	LEFT JOIN
		FlightAssignments ON Flights.FlightID = FlightAssignments.FlightID
	LEFT JOIN
		Pilots ON FlightAssignments.PilotID = Pilots.PilotID;

--40. Show all resumes and job applications linked to them (if any).
	  CREATE TABLE Resumes (
		ResumeID INT PRIMARY KEY,
		CandidateName VARCHAR(100),
		ResumeTitle VARCHAR(100)
	);

	CREATE TABLE JobApplications (
		ApplicationID INT PRIMARY KEY,
		ResumeID INT,
		JobTitle VARCHAR(100),
		ApplicationDate DATE,
		FOREIGN KEY (ResumeID) REFERENCES Resumes(ResumeID)
	);

	-- Resumes
	INSERT INTO Resumes (ResumeID, CandidateName, ResumeTitle) VALUES
	(1, 'Alice Johnson', 'Software Engineer Resume'),
	(2, 'Bob Smith', 'Data Analyst Resume'),
	(3, 'Carol White', 'Project Manager Resume'),
	(4, 'David Lee', 'Graphic Designer Resume');

	-- Job Applications
	INSERT INTO JobApplications (ApplicationID, ResumeID, JobTitle, ApplicationDate) VALUES
	(1, 1, 'Backend Developer', '2025-04-01'),
	(2, 1, 'DevOps Engineer', '2025-04-05'),
	(3, 2, 'Data Analyst', '2025-04-03');


	SELECT * FROM Resumes;
	SELECT * FROM JobApplications;
	SELECT R.CandidateName , R.ResumeTitle, J.JobTitle, J.ApplicationDate FROM Resumes R
	LEFT JOIN JobApplications J
	ON   R.ResumeID = J.ResumeID;


--🔹 **RIGHT JOIN (41–55)**

--41. Get all orders, including those without customer info.

	 SELECT * FROM Orders;
	SELECT * FROM Customers;

	SELECT O.OrderDate, O.TotalAmount , C.CustomerName from  Customers C
	RIGHT JOIN   Orders O
	ON  C.CustomerID = O.CustomerID  ;

--42. Show all departments and employees assigned (even if none).

	   SELECT * FROM Departments;
	   SELECT * FROM Employees;

	SELECT  E.EmployeeName , E.JobTitle ,D.DepartmentName  FROM Employees E
	RIGHT JOIN    Departments D
	ON E.DepartmentID  =  D.DepartmentID;
 
--43. List all job postings and the applicants (even if no one applied).
   
	   CREATE TABLE JobPostings (
		JobID INT PRIMARY KEY,
		JobTitle VARCHAR(100),
		Department VARCHAR(100)
	);

	CREATE TABLE Applicants (
		ApplicantID INT PRIMARY KEY,
		ApplicantName VARCHAR(100),
		JobID INT,
		ApplicationDate DATE,
		FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
	);

	-- JobPostings
	INSERT INTO JobPostings (JobID, JobTitle, Department) VALUES
	(1, 'Software Developer', 'Engineering'),
	(2, 'Business Analyst', 'Business'),
	(3, 'Graphic Designer', 'Marketing'),
	(4, 'HR Manager', 'Human Resources'),
	(5, 'QA Tester', 'Engineering');

	-- Applicants
	INSERT INTO Applicants (ApplicantID, ApplicantName, JobID, ApplicationDate) VALUES
	(1, 'Emma Wilson', 1, '2025-04-01'),
	(2, 'Liam Brown', 2, '2025-04-02'),
	(3, 'Olivia Taylor', 1, '2025-04-03'),
	(4, 'Noah Davis', 3, '2025-04-04');

	SELECT * FROM JobPostings;
	SELECT * FROM Applicants;
	SELECT  A.ApplicantName, J.JobTitle , J.Department  FROM  Applicants A  
	RIGHT JOIN JobPostings J
	ON A.JobID = J.JobID;

--44. Show all songs and artists (even if song is missing artist info).
	   CREATE TABLE Artists (
		ArtistID INT PRIMARY KEY,
		ArtistName VARCHAR(100),
		SongID int
	FOREIGN KEY (SongID) REFERENCES Songs(SongID)
	);

	INSERT INTO Artists (ArtistID, ArtistName,SongID) VALUES
	(101, 'Adele',1),
	(102, 'Ed Sheeran',2),
	(103, 'Taylor Swift',3),
	(104, 'Drake',4),
	(105, 'BTS', 5);

	  SELECT * FROM Songs;
	   SELECT * FROM Artists;
	   SELECT  A.ArtistName , S.SongTitle FROM Artists A 
	   RIGHT JOIN   Songs S
	   ON A.SongID = S.SongID;

--45. Display all bank branches and employees (even if branch has no staff).

		  CREATE TABLE BankBranche (
		BranchID INT ,
		BranchName VARCHAR(100),
		City VARCHAR(100)
		FOREIGN KEY (BranchID) REFERENCES Employees(EmployeeID)

	);
	INSERT INTO BankBranche (BranchID, BranchName, City) VALUES
	(1, 'Central Branch', 'New York'),
	(2, 'West End Branch', 'Los Angeles'),
	(3, 'Downtown Branch', 'Chicago');

		   SELECT * FROM BankBranche;
		   SELECT * FROM Employees;

		   SELECT E.EmployeeName ,  B.BranchName, B.City  FROM	  Employees E 
		   RIGHT JOIN  BankBranche B
		   ON B.BranchID = E.EmployeeID;

--46. Get all flights and airports they depart from (even if flight data is missing).
			  SELECT * FROM Flights;
		SELECT * FROM Pilots;

		SELECT Flights.FlightName, Flights.DepartureCity, Flights.ArrivalCity , Pilots.PilotName FROM  Pilots 
		RIGHT JOIN  Flights ON  Pilots.PilotID = Flights.FlightID


--47. List all stores and the inventory they hold (even if store is empty).
		CREATE TABLE Stores (
			StoreID INT PRIMARY KEY,
			StoreName VARCHAR(100),
			Location VARCHAR(100)
		);

		CREATE TABLE Inventory (
			InventoryID INT PRIMARY KEY,
			StoreID INT,
			ProductName VARCHAR(100),
			Quantity INT,
			FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
		);

		-- Stores
		INSERT INTO Stores (StoreID, StoreName, Location) VALUES
		(1, 'Downtown Mart', 'New York'),
		(2, 'Westside Grocery', 'Los Angeles'),
		(3, 'CityStop', 'Chicago');

		-- Inventory
		INSERT INTO Inventory (InventoryID, StoreID, ProductName, Quantity) VALUES
		(101, 1, 'Apples', 150),
		(102, 1, 'Bread', 80),
		(103, 2, 'Milk', 120);

		SELECT S.StoreName , S.Location , I.ProductName, I.Quantity FROM  Inventory I 
		RIGHT JOIN  Stores S
		ON I.StoreID = S.StoreID;

--48. Show all sports teams and their players (even if team has no players).
		  CREATE TABLE SportsTeams (
		TeamID INT PRIMARY KEY,
		TeamName VARCHAR(100),
		City VARCHAR(100)
	);

	CREATE TABLE Players (
		PlayerID INT PRIMARY KEY,
		PlayerName VARCHAR(100),
		TeamID INT,
		FOREIGN KEY (TeamID) REFERENCES SportsTeams(TeamID)
	);


	INSERT INTO SportsTeams (TeamID, TeamName, City) VALUES
	(1, 'Thunderbolts', 'Dallas'),
	(2, 'Skyhawks', 'Seattle'),
	(3, 'Iron Giants', 'Denver');


	INSERT INTO Players (PlayerID, PlayerName, TeamID) VALUES
	(201, 'Liam Brown', 1),
	(202, 'Olivia White', 1),
	(203, 'Noah Green', 2);

		SELECT * FROM SportsTeams;
		SELECT * FROM Players;
	   SELECT S.TeamName, S.City , P.PlayerName FROM Players P  
	   RIGHT JOIN SportsTeams S
	   ON P.TeamID  = S.TeamID;



--49. List all invoices and the payments made (even if unpaid).
      
	  CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    PaymentDate DATE,
    AmountPaid DECIMAL(10, 2),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID)
);
	
INSERT INTO Payments (PaymentID, InvoiceID, PaymentDate, AmountPaid) VALUES
(1, 1001, '2024-12-06', 150.00),
(2, 1002, '2024-12-07', 300.00),
(3, 1003, '2024-12-08', 89.90);

SELECT * FROM  Invoices
SELECT * FROM Payments;

  SELECT I.InvoiceDate , I.TotalAmount ,   P.PaymentDate , P.AmountPaid FROM Payments P 
  RIGHT JOIN  Invoices I
  ON  P.InvoiceID = I.InvoiceID;
    
--50. Show all orders and shipping details (even if not shipped).
    CREATE TABLE ShippingDetails (
    ShippingID INT PRIMARY KEY,
    OrderID INT,
    ShippingDate DATE,
    Carrier VARCHAR(100),
    TrackingNumber VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO ShippingDetails (ShippingID, OrderID, ShippingDate, Carrier, TrackingNumber) VALUES
(1, 101, '2024-12-10', 'DHL', 'DHL123456'),
(2, 102, '2024-12-11', 'FedEx', 'FX987654'),
(3, 104, '2024-12-12', 'UPS', 'UPS456789');


	
	SELECT * FROM Orders;
	SELECT * FROM ShippingDetails

	SELECT O.OrderDate , O.TotalAmount , S.Carrier, S.TrackingNumber, S.ShippingDate FROM ShippingDetails S
	RIGHT JOIN  Orders O  
	ON S.OrderID = O.OrderID;
	

--51. Get all rental properties and tenants (even if vacant).
		  CREATE TABLE RentalProperties (
		PropertyID INT PRIMARY KEY,
		Address VARCHAR(200),
		City VARCHAR(100),
		RentAmount DECIMAL(10, 2)
	);

	INSERT INTO RentalProperties (PropertyID, Address, City, RentAmount) VALUES
	(1, '123 Main St', 'Springfield', 1200.00),
	(2, '456 Oak Ave', 'Shelbyville', 950.00),
	(3, '789 Pine Rd', 'Ogdenville', 1500.00),
	(4, '321 Elm St', 'Capital City', 1800.00);


	CREATE TABLE Tenants (
		TenantID INT PRIMARY KEY,
		TenantName VARCHAR(100),
		PropertyID INT,
		FOREIGN KEY (PropertyID) REFERENCES RentalProperties(PropertyID)
	);

	INSERT INTO Tenants (TenantID, TenantName, PropertyID) VALUES
	(1, 'Alice Johnson', 1),
	(2, 'Bob Smith', 3);

	SELECT * FROM RentalProperties;
	SELECT * FROM Tenants;

	SELECT  R.Address, R.City , R.RentAmount , T.TenantName FROM  Tenants T
	RIGHT JOIN  RentalProperties R
	ON T.PropertyID = R.PropertyID;

--52. List all service centers and the vehicles serviced (even if none).
      
		  CREATE TABLE ServiceCenters (
		CenterID INT PRIMARY KEY,
		CenterName VARCHAR(100),
		Location VARCHAR(100)
	);

	INSERT INTO ServiceCenters (CenterID, CenterName, Location) VALUES
	(1, 'AutoFix Center', 'Downtown'),
	(2, 'Speedy Repairs', 'Uptown'),
	(3, 'CarPro Service', 'Midtown'),
	(4, 'Elite AutoCare', 'Suburb East');


	CREATE TABLE ServicedVehicles (
		ServiceID INT PRIMARY KEY,
		VehicleNumber VARCHAR(20),
		ServiceDate DATE,
		CenterID INT,
		FOREIGN KEY (CenterID) REFERENCES ServiceCenters(CenterID)
	);

	INSERT INTO ServicedVehicles (ServiceID, VehicleNumber, ServiceDate, CenterID) VALUES
	(101, 'KA01AB1234', '2025-04-15', 1),
	(102, 'MH12CD5678', '2025-04-17', 2),
	(103, 'DL45EF9012', '2025-04-20', 1);


	SELECT * FROM ServiceCenters;
	SELECT * FROM ServicedVehicles;

	SELECT SC.CenterName , SC.Location , SV.VehicleNumber, SV.ServiceDate FROM  ServicedVehicles SV
	RIGHT JOIN  ServiceCenters SC
	ON SV.CenterID = SC.CenterID;
     
--53. Show all products and the vendors supplying them (even if unsupplied).
	CREATE TABLE Vendors (
		VendorID INT PRIMARY KEY,
		VendorName VARCHAR(100),
		ContactEmail VARCHAR(100)
	);

	INSERT INTO Vendors (VendorID, VendorName, ContactEmail) VALUES
	(1, 'Tech Supplies Inc.', 'contact@techsupplies.com'),
	(2, 'Gadget World', 'info@gadgetworld.com'),
	(3, 'Office Essentials', 'sales@officeessentials.com');
	
	     SELECT * FROM Products;
		 SELECT * FROM Vendors;

		 SELECT  P.ProductName, P.Price , V.VendorName , V.ContactEmail FROM  Vendors V
		 RIGHT JOIN  Products P
		 ON V.VendorID = P.CategoryID ;

--54. Display all training sessions and attendees (even if session is empty).
       
		   CREATE TABLE TrainingSessions (
		SessionID INT PRIMARY KEY,
		SessionTitle VARCHAR(100),
		TrainerName VARCHAR(100),
		SessionDate DATE
	);

	INSERT INTO TrainingSessions (SessionID, SessionTitle, TrainerName, SessionDate) VALUES
	(1, 'Time Management', 'Alice Johnson', '2025-05-01'),
	(2, 'Effective Communication', 'David Lee', '2025-05-03'),
	(3, 'Project Planning', 'Sandra Kim', '2025-05-06'),
	(4, 'Conflict Resolution', 'Mike Brown', '2025-05-09'); -- N

		CREATE TABLE Attendees (
		AttendeeID INT PRIMARY KEY,
		SessionID INT,
		AttendeeName VARCHAR(100),
		FOREIGN KEY (SessionID) REFERENCES TrainingSessions(SessionID)
	);

	INSERT INTO Attendees (AttendeeID, SessionID, AttendeeName) VALUES
	(201, 1, 'Tom Harris'),
	(202, 1, 'Nina Gomez'),
	(203, 2, 'Lara Singh'),
	(204, 3, 'Kevin Tran');

	 SELECT * FROM TrainingSessions;
	 SELECT * FROM Attendees;

	 SELECT T.TrainerName , T.SessionTitle, T.SessionDate , A.AttendeeName FROM  Attendees A 
	 RIGHT JOIN   TrainingSessions T
	 ON A.SessionID = T.SessionID;

--55. Get all users and their transactions (even if they made none).

       SELECT * FROM Users;
	   SELECT * FROM Transactions;

	   SELECT U.UserName , U.Email , T.TransactionDate , T.Amount FROM   Transactions T
	   RIGHT JOIN  Users U
	   ON  T.TransactionID = U.UserID;

-- 🔹 **FULL OUTER JOIN (56–70)**

--56. List all employees and their managers (even if no relation exists).
      SELECT * FROM Employees;
	 
	  
	  SELECT E.EmployeeName AS Employee, M.EmployeeName AS Manager FROM Employees E
      FULL OUTER JOIN Employees M
      ON E.ManagerID = M.EmployeeID;

 
--57. Get all books and authors (even if unmatched).
       SELECT * FROM Books;
	   SELECT * FROM Authors;
    
	SELECT B.Title , A.AuthorName FROM Books B
	FULL OUTER JOIN Authors A
	ON B.AuthorID = A.AuthorID;

--58. Display all customers and orders (even if either is missing).
		   SELECT *  FROM Customers;
		   SELECT * FROM Orders;

		   SELECT C.CustomerName, C.City , O.OrderDate , O.TotalAmount FROM Customers C
		   FULL OUTER JOIN  Orders O
		   ON C.CustomerID = O.CustomerID;

--59. Show all students and classes (even if not enrolled).
       SELECT * FROM Students;
       SELECT * FROM Classes;
	   SELECT S.StudentName , C.ClassName  FROM Students S
	   FULL OUTER JOIN Classes C
	   ON S.StudentID = C.ClassID;

--60. Get all products and their reviews (even if not reviewed).
      
		  CREATE TABLE Reviews (
		ReviewID INT PRIMARY KEY,
		ProductID INT,
		ReviewText VARCHAR(255),
		Rating INT,
		ReviewDate DATE,
		FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
	);
	
	INSERT INTO Reviews (ReviewID, ProductID, ReviewText, Rating, ReviewDate) VALUES
	(1, 201, 'Excellent quality and packaging!', 5, '2025-01-10'),
	(2, 202, 'Value for money.', 4, '2025-01-15'),
	(3, 204, 'Not as described, disappointed.', 2, '2025-01-18'),
	(4, 205, 'Satisfactory performance.', 3, '2025-01-20');

	SELECT * FROM Products;
	SELECT * FROM Reviews;

	select P.ProductName , P.Price , R.ReviewText, R.ReviewDate FROM Products P
	FULL OUTER JOIN Reviews R
	ON P.ProductID = R.ProductID ;



--61. List all applications and applicants (even if unlinked).
           SELECT * FROM JobApplications
	      SELECT * FROM Applicants;

	 SELECT J.JobTitle, J.ApplicationDate , A.ApplicantName FROM JobApplications J
	 FULL OUTER JOIN Applicants A
	 ON J.ApplicationID = A.ApplicantID;

--62. Show all users and their profile pictures (even if missing).
		 CREATE TABLE ProfilePictures (
		PictureID INT PRIMARY KEY,
		UserID INT,
		PictureURL VARCHAR(255),
		FOREIGN KEY (UserID) REFERENCES Users(UserID)
	);

	INSERT INTO ProfilePictures (PictureID, UserID, PictureURL) VALUES
	(101, 1, 'https://example.com/profiles/alice.jpg'),
	(102, 3, 'https://example.com/profiles/charlie.jpg'),
	(103, 4, 'https://example.com/profiles/ethan.jpg');

		 SELECT * FROM Users;
		   SELECT * FROM ProfilePictures;
		   SELECT U.UserName, U.Email , P.PictureURL FROM Users U
		   FULL OUTER JOIN ProfilePictures P
		   ON U.UserID = P.UserID;

--63. List all volunteers and events (even if not linked).
			 CREATE TABLE Volunteers (
		VolunteerID INT PRIMARY KEY,
		VolunteerName VARCHAR(100),
		Email VARCHAR(100)
	);

	CREATE TABLE Events (
		EventID INT PRIMARY KEY,
		EventName VARCHAR(100),
		EventDate DATE,
		VolunteerID INT,  
		FOREIGN KEY (VolunteerID) REFERENCES Volunteers(VolunteerID)
	);


	INSERT INTO Volunteers (VolunteerID, VolunteerName, Email) VALUES
	(1, 'Alice Green', 'alice@example.com'),
	(2, 'Bob Smith', 'bob@example.com'),
	(3, 'Charlie Johnson', 'charlie@example.com'),
	(4, 'Diana Ross', 'diana@example.com'),
	(5, 'Ethan Clark', 'ethan@example.com');


	INSERT INTO Events (EventID, EventName, EventDate, VolunteerID) VALUES
	(101, 'Park Cleanup', '2025-06-01', 1),
	(102, 'Food Distribution', '2025-06-03', 2),
	(103, 'Blood Donation Drive', '2025-06-05', NULL),
	(104, 'Recycling Workshop', '2025-06-07', NULL),
	(105, 'Community Painting', '2025-06-10', 4);

	 SELECT * FROM Volunteers;
	 SELECT * FROM Events;

	   SELECT V.VolunteerName , E.EventName , E.EventDate FROM Volunteers V
	   FULL OUTER JOIN Events E
	   ON V.VolunteerID = e.VolunteerID;

--64. Display all assets and owners (even if unassigned)

	CREATE TABLE Assets (
		AssetID INT ,
		AssetName VARCHAR(100),
		AssetType VARCHAR(50),
    

	);
	INSERT INTO Assets (AssetID, AssetName, AssetType) VALUES
	(101, 'Dell Laptop', 'Electronics'),
	(NULL, 'Office Chair', 'Furniture'),
	(103, 'Projector', 'Electronics'),
	(NULL, 'Whiteboard', 'Stationery'),
	(105, 'Conference Table', 'Furniture');
			SELECT * FROM Owners;
			SELECT * FROM Assets;

			SELECT A.AssetName , O.OwnerName, O.Address FROM Assets A
			FULL OUTER JOIN Owners O
			ON A.AssetID = O.OwnerID;
			
--65. Show all job titles and employees (even if no one holds the title).
       
	   SELECT * FROM Employees;
	   SELECT * FROM JobPostings

	   SELECT J.JobTitle , E.EmployeeName FROM Employees E
	   FULL OUTER JOIN JobPostings J
	   ON E.EmployeeID = J.JobID;

--66. Get all cities and their airports (even if no airport).
    
	SELECT * FROM Customers;
    SELECT * FROM Flights;

     SELECT C.City , F.DepartureCity AS Airports FROM Customers C
	 FULL OUTER JOIN Flights F
	 ON  C.CustomerID = F.FlightID;

--67. List all software and licenses (even if unused).
      CREATE TABLE Software (
    SoftwareID INT PRIMARY KEY,
    SoftwareName VARCHAR(100),
    Vendor VARCHAR(100)
);

CREATE TABLE Licenses (
    LicenseID INT PRIMARY KEY,
    SoftwareID INT,
    LicenseKey VARCHAR(100),
    ExpiryDate DATE,
    FOREIGN KEY (SoftwareID) REFERENCES Software(SoftwareID)
);

INSERT INTO Software (SoftwareID, SoftwareName, Vendor) VALUES
(1, 'Microsoft Office', 'Microsoft'),
(2, 'Photoshop', 'Adobe'),
(3, 'AutoCAD', 'Autodesk'),
(4, 'Slack', 'Slack Technologies'),
(5, 'Notepad++', 'Don Ho'); 


INSERT INTO Licenses (LicenseID, SoftwareID, LicenseKey, ExpiryDate) VALUES
(101, 1, 'OFFICE-1234-ABCD', '2025-12-31'),
(102, 2, 'PHOTO-5678-EFGH', '2025-11-30'),
(103, 3, 'ACAD-9012-IJKL', '2026-01-15'),
(104, 4, 'SLACK-3456-MNOP', '2025-10-01');

   SELECT * FROM Software;
   SELECT * FROM Licenses;

   SELECT S.SoftwareName, S.Vendor , L.LicenseKey , L.ExpiryDate FROM Software S
   FULL OUTER JOIN Licenses L
   ON S.SoftwareID = L.SoftwareID;

--68. Show all classes and schedules (even if one is missing).
  
       CREATE TABLE Schedules (
    ScheduleID INT PRIMARY KEY,
    ClassID INT,
    DayOfWeek VARCHAR(20),
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime) VALUES
(101, 1, 'Monday', '09:00', '10:30'),
(102, 2, 'Tuesday', '10:45', '12:15'),
(103, 3, 'Wednesday', '13:00', '14:30'),
(104, 4, 'Thursday', '14:45', '16:15');

   SELECT  * FROM Classes;
   SELECT * FROM Schedules;

   SELECT C.ClassName , S.DayOfWeek , S.StartTime, S.EndTime FROM Classes C
   FULL OUTER JOIN Schedules S
   ON C.TeacherID = S.ScheduleID;

--69. List all banks and customers (even if no link).
      SELECT * FROM BankBranche;
	  SELECT * FROM Customers;

	  SELECT C.CustomerName , B.BranchName AS Bank FROM BankBranche B
	  FULL OUTER JOIN Customers C
	  ON  C.CustomerID = B.BranchID;

--70. Display all employees and badges (even if missing).

	CREATE TABLE Badges (
		BadgeID INT PRIMARY KEY,
		EmployeeID INT,
		BadgeNumber VARCHAR(50),
		IssueDate DATE,
		FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
	);

	-- Badges
	INSERT INTO Badges (BadgeID, EmployeeID, BadgeNumber, IssueDate) VALUES
	(101, 1, 'EMP1001', '2024-05-01'),
	(102, 2, 'EMP1002', '2024-05-03'),
	(103, 3, 'EMP1003', '2024-05-05'),
	(104, 4, 'EMP1004', '2024-05-06');

		  SELECT * FROM Employees;
		  SELECT * FROM Badges;

		  SELECT E.EmployeeName , B.BadgeNumber , B.IssueDate FROM Employees E
		  FULL OUTER JOIN Badges B
		  ON E.EmployeeID = B.EmployeeID;



	  --🔹 **SELF JOIN (71–80)**

--71. Find all employees who report to someone (supervisor).

       SELECT * FROM Employees
	   where ManagerID is not null;

--72. List employees and their managers' names.
	   SELECT  E.EmployeeName AS Employee,  M.EmployeeName AS ManagerName
	   FROM Employees E
	JOIN Employees M 
	ON E.ManagerID = M.EmployeeID;

--73. Find all products that are substitutes of other products.
       SELECT * FROM Products;


	   SELECT P1.ProductName AS Product, P2.ProductName AS Substitute
     FROM Products P1
     JOIN Products P2 ON P1.CategoryID = P2.CategoryID AND P1.ProductID <> P2.ProductID;

--74. List students and their mentors (who are also students).
          SELECT * FROM Students;     
	 SELECT T1.StudentName AS STUDENTS , T2.StudentName AS MENTER FROM Students  T1
	  JOIN Students T2
	  ON T1.MentorID = T2.StudentID;
		
--75. Find users who referred other users.

	    
		ALTER TABLE USERS
		ADD REFUSERS INT 

		UPDATE Users
		SET REFUSERS = 2
		WHERE UserID = 1;

		UPDATE Users
		SET REFUSERS = 4
		WHERE UserID = 2;

		UPDATE Users
		SET REFUSERS = 1
		WHERE UserID = 3;

		UPDATE Users
		SET REFUSERS = NULL
		WHERE UserID = 4;
 
	       SELECT * FROM Users;
		SELECT U1.UserName , U2.UserName  AS REFUSERS FROM Users U1 , Users U2
		WHERE U1.REFUSERS = U2.UserID AND U1.UserID <> U2.UserID;

--76. Display a list of employees with the same job title.
      
	   UPDATE Employees
	   set JobTitle = 'QA Analyst'
	   where EmployeeID = 1;
    
       SELECT E1.EmployeeName , E2.JobTitle FROM Employees E1
	   JOIN Employees E2
	   ON E1.JobTitle = E2.JobTitle AND E1.EmployeeID <> E2.EmployeeID;

--77. Find customers who live in the same city.

        SELECT * FROM Customers;
		SELECT C1.CustomerName , C2.Country FROM Customers C1
		JOIN  Customers C2
		ON C1.Country = C2.Country AND C1.CustomerID <> C2.CustomerID;

--78. List products with the same price.
       
	   UPDATE Products
	   set Price = 49.99
	   where ProductID = 201;
    
	  
       SELECT * FROM Products;
	   SELECT P1.ProductName , P2.Price  FROM Products P1, Products P2
	   WHERE P1.Price = P2.Price AND P1.ProductID <> P2.ProductID;

--79. Find employees working in the same department.

       SELECT * FROM Employees;
	   SELECT E1.EmployeeName, E2.DepartmentID FROM Employees E1, Employees E2
	   WHERE E1.DepartmentID =E2.DepartmentID AND E1.EmployeeID <> E2.EmployeeID;

--80. Display employees with the same hire date.
      
	  SELECT * FROM Employees;
	   SELECT E1.EmployeeName, E2.HireDate FROM Employees E1, Employees E2
	   WHERE E1.HireDate = E2.HireDate AND E1.EmployeeID <> E2.EmployeeID;
    

	-- 🔹 **Advanced Join Practice (81–100)**

--81. Get the top 3 customers with most orders using JOIN.

        SELECT * FROM Customers;
        SELECT * FROM Orders;

		SELECT TOP 3 C.CustomerName , O.TotalAmount FROM Customers C
		 JOIN Orders O
		 ON C.CustomerID =  O.CustomerID
		 ORDER BY O.TotalAmount DESC

--82. List each department with the number of employees.

      SELECT * FROM Departments;
        SELECT * FROM Employees;
   
    SELECT D.DepartmentName, COUNT(E.EmployeeName)  FROM  Departments D
	LEFT JOIN  Employees E
	ON D.DepartmentID = E.DepartmentID
	GROUP BY D.DepartmentName;

--83. Show total sales by product category.
      SELECT * FROM Sales;
	  SELECT * FROM Products;
	  SELECT * FROM Categories;
	  SELECT C.CategoryName, SUM(S.Amount) AS TotalSales
FROM Sales S
JOIN Products P ON S.SaleID = P.SupplierID
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName;


 /*SELECT C.CategoryName, SUM(S.Quantity * P.Price) AS TotalSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName; **/


--84. Find the most expensive product in each category.
   
		SELECT * FROM Products;
		SELECT * FROM Categories;
	 
	SELECT C.CategoryName, MAX(P.Price) AS MaxPrice
    FROM Products P
   JOIN Categories C ON P.CategoryID = C.CategoryID
    GROUP BY C.CategoryName;

--85. Get all orders with product names and total price.

			SELECT * FROM Orders;
			SELECT * FROM Products;
			SELECT * FROM  OrderDetails;

			SELECT O.OrderID, P.ProductName, OD.Quantity * P.Price AS TotalPrice
	FROM Orders O
	JOIN OrderDetails OD ON O.OrderID = OD.OrderID
	JOIN Products P ON OD.ProductID = P.ProductID;

--86. Display each student’s average grade.
     
	  SELECT * FROM Students
	 SELECT * FROM Enrollments
	 SELECT S.StudentName, AVG(CASE 
    WHEN E.Grade = 'A' THEN 1.0
    WHEN E.Grade = 'B' THEN 2.0
    WHEN E.Grade = 'C' THEN 3.0
    WHEN E.Grade = 'D' THEN 4.0
    ELSE 0.0 END) AS AvgGrade
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
GROUP BY S.StudentName;






select * from Student;
SELECT * FROM Enrollments;

select S.Name , avg(S.Marks) as avggrade,
case when avg(s.Marks) > 90 then 'A' 
    when avg(s.Marks) > 80 then  'B'
    when avg(s.Marks) > 70 then  'c'
    when avg(s.Marks) > 60 then  'd' END  AS GRADE  
from Student  S
join Enrollments E
ON S.StudentID = E.StudentID
GROUP BY S.Name


--87. List all authors and the number of books they've written.
    
		 SELECT * FROM Authors;  
		 SELECT * FROM Books;
		 SELECT Authors.AuthorName , COUNT(Books.AuthorID) AS NUMBERS FROM Authors
		 LEFT JOIN Books 
		 ON Authors.AuthorID = Books.AuthorID
		 GROUP BY Authors.AuthorName,   Authors.AuthorID



--88. Get customers who ordered more than 5 times.
      
	   SELECT * FROM Customers;
	   SELECT * FROM  Orders;

	   SELECT C.CustomerName, COUNT(O.OrderID) AS OrderCount
       FROM Customers C
       JOIN Orders O ON C.CustomerID = O.CustomerID
        GROUP BY C.CustomerName
        HAVING COUNT(O.OrderID) > 5;


--89. List customers who never placed an order. 
       
	   
	   SELECT * FROM Customers;
	   SELECT * FROM  Orders

	   SELECT C.CustomerName, C.City 
      FROM Customers C
      LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
      WHERE O.OrderID IS NULL;

--90. Show products not ordered in the last 6 months.
		SELECT * FROM Products;
		SELECT * FROM Orders;
		SELECT * FROM OrderDetails;
	
		 SELECT P.ProductName 
FROM Products P
WHERE NOT EXISTS (
    SELECT 1 
    FROM OrderDetails OD
    JOIN Orders O ON OD.OrderID = O.OrderID
    WHERE OD.ProductID = P.ProductID 
      AND O.OrderDate > DATEADD(MONTH, -6, GETDATE())
);





--91. Find employees with the same manager.

		SELECT * FROM Employees;
		SELECT E1.EmployeeName , E2.EmployeeName  AS MANAGERNAME FROM Employees E1 , Employees E2
		WHERE E1.ManagerID = E2.EmployeeID  AND E1.EmployeeID <> E2.EmployeeID	
	

--92. List pairs of students enrolled in the same course.
		 SELECT * FROM Students;
		 SELECT * FROM Courses;	
		 WITH Same_DATA AS(
		 SELECT S1.StudentName ,S2.MentorID FROM Students S1 , Students S2
		 WHERE S1.MentorID = S2.MentorID AND S1.StudentID <> S2.StudentID
	)	 
	-- select * from Same_DATA;
	SELECT  Same_DATA.STUDENTNAME, Same_DATA.MentorID, Courses.CourseName FROM Same_DATA
	JOIN Courses
	ON Same_DATA.MentorID = Courses.CourseID;
	


--93. Display products with no matching supplier or category. (QUERY)
       SELECT * FROM Products;
	   SELECT * FROM Suppliers;
	   SELECT * FROM Categories;

	   SELECT Products.ProductName , Suppliers.SupplierName , Categories.CategoryName FROM Products
	LEFT  JOIN Suppliers
	      ON Products.SupplierID = Suppliers.SupplierID
    LEFT JOIN  Categories 
	  ON Products.CategoryID = Categories.CategoryID
	  where ProductName is null OR SupplierName is null;


	   
--94. Get the number of songs in each album.

      SELECT * FROM Songs;
	  SELECT * FROM Albums;
	  SELECT A.AlbumName, COUNT(S.SongID) AS SongCount
FROM Albums A
LEFT JOIN Songs S ON A.AlbumID = S.AlbumID
GROUP BY A.AlbumName;

--95. Find stores with below-average number of products.
       SELECT * FROM Stores;
	   SELECT * FROM Inventory;


	   WITH StoreProductCounts AS (
    SELECT S.StoreName, COUNT(I.StoreID) AS ProductCount
    FROM Stores S
    LEFT JOIN Inventory I ON S.StoreID = I.StoreID
    GROUP BY S.StoreName),
	AvgProductCount AS (
    SELECT AVG(CONVERT(FLOAT ,ProductCount  )) AS AvgCount
    FROM StoreProductCounts
)
SELECT SPC.StoreName, SPC.ProductCount
FROM StoreProductCounts SPC, AvgProductCount APC
WHERE SPC.ProductCount < APC.AvgCount;

--96. Show projects with no tasks assigned.

    SELECT * FROM Projects;
	select * from ProjectAssignments
	
	SELECT Projects.ProjectName , ProjectAssignments.ProjectID  FROM Projects 
	LEFT JOIN  ProjectAssignments
	ON Projects.ProjectID = ProjectAssignments.ProjectID
	WHERE ProjectAssignments.ProjectID IS NULL;

--97. Get number of reviews per product.

          SELECT * FROM Reviews
		  SELECT * FROM Products

		SELECT P.ProductName, COUNT(R.ReviewID) AS ReviewCount
        FROM Products P
        LEFT JOIN Reviews R ON P.ProductID = R.ProductID
        GROUP BY P.ProductName;

--98. List teachers who teach in more than one department.
      
	   INSERT INTO Teachers values(106, 'Tony Stark', 'Physics') 

	  SELECT * FROM Teachers;
	  SELECT * FROM Classes;

	   
	  SELECT  T1.TeacherName , T2.Department  FROM Teachers T1 , Teachers T2
	  WHERE T1.Department = T2.Department AND T1.TeacherID <> T2.TeacherID
	 --  COUNT(T1.Department) AS TEACHER
	 --  GROUP BY T1.Department, T2.Department 

--99. Show the latest order for each customer.

        UPDATE Orders
		SET OrderDate = '2025-05-03'
		WHERE OrderID = 103;

	   INSERT INTO Orders 
	   values(106, '2025-05-05', 6 , 500.00), 
		(107, '2025-05-06', 4 , 478.42)		

	   INSERT INTO OrderDetails 
	      values(6, 106, 201 , 4), 
		      (7, 107, 203, 3)		
		
		SELECT * FROM Orders
		SELECT * FROM OrderDetails
		SELECT * FROM Customers
		

		SELECT C.CustomerName , C.City , O.OrderDate , O.TotalAmount FROM Customers C
		JOIN Orders O
		ON C.CustomerID =  O.CustomerID
		WHERE OrderDate > DATEADD(DAY , -7 , GETDATE());

--100. Get all items with their category, vendor, and inventory status.
          
          SELECT * FROM Categories
          SELECT * FROM Vendors
          SELECT * FROM Inventory
          SELECT * FROM Products


SELECT P.ProductName, C.CategoryName, V.VendorName, 
       CASE WHEN I.Quantity > 0 THEN 'In Stock' ELSE 'Out of Stock' END AS InventoryStatus
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.CategoryID
LEFT JOIN Vendors V ON P.CategoryID = V.VendorID
LEFT JOIN Inventory I ON P.SupplierID = I.InventoryID;



