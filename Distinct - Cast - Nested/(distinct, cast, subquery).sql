CREATE TABLE #Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO #Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Sales'),
(5, 'Engineering'),    
(6, 'IT Support'),
(7, 'Finance');        

CREATE TABLE #Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    JoinDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO #Employees (EmployeeID, Name, DepartmentID, Salary, JoinDate) VALUES
(101, 'Alice Johnson', 3, 75000.00, '2021-05-10'),
(102, 'Bob Smith', 2, 62000.00, '2020-03-15'),
(103, 'Charlie Davis', 4, 58000.00, '2022-01-12'),
(104, 'Diana Evans', 1, 54000.00, '2019-07-01'),
(105, 'Ethan Brown', 6, 50000.00, '2023-08-20'),
(106, 'Fiona White', 5, 60000.00, '2021-11-30'),
(107, 'George Harris', 7, 62000.00, '2020-09-25'),  
(108, 'Harsh Mehta', 3, 85000.50, '2022-02-14'),    
(109, 'Ishita Verma', 3, 91000.00, '2024-01-01');   

SELECT * FROM #Departments
SELECT * FROM #Employees




-- 🔹 DISTINCT (Questions 1–15)

--1. Retrieve all distinct department IDs from the Employees table.
    
	SELECT DISTINCT DepartmentID from #Employees;
      

--2. List all distinct salaries in the Employees table.

      SELECT DISTINCT SALARY FROM #Employees;

--3. How many distinct departments have employees?
    
        SELECT COUNT(DISTINCT DepartmentID) AS DistinctDepa FROM #Employees;
		
--4. Find distinct joining years of employees.

     SELECT DISTINCT YEAR(JOINDATE) AS JOININGYEAR FROM #Employees;
      

--5. List all distinct combinations of DepartmentID and Salary.
  
     SELECT DISTINCT DEPARTMENTID , SALARY  FROM #Employees; 

--6. Count the number of distinct employee names.
  
     SELECT COUNT(DISTINCT NAME) FROM #Employees; 
--7. Get all distinct names of employees who joined after 2020.
  
     SELECT DISTINCT NAME FROM #Employees
	 WHERE YEAR(JoinDate) > 2020;

--8. List all distinct employee IDs that belong to department 3.
 
      SELECT DISTINCT EMPLOYEEID FROM #Employees
	  WHERE DepartmentID = 3;

--9. Retrieve distinct salary values greater than 50,000.

     SELECT DISTINCT SALARY FROM #Employees
	 WHERE Salary > 50000;

--10. List distinct departments from Employees who joined before 2022.
   
       SELECT DISTINCT DEPARTMENTID FROM #Employees
	   WHERE YEAR(JoinDate) < 2022;

--11. Get the number of distinct JoinDates.

     SELECT COUNT(DISTINCT JOINDATE) FROM #Employees;

--12. Show distinct salaries in ascending order.

        SELECT DISTINCT SALARY FROM #Employees
		ORDER BY Salary ;

--13. Retrieve all distinct employee names having salary above 30,000.

       SELECT DISTINCT NAME FROM #Employees
	   WHERE Salary > 30000;

--14. Count distinct DepartmentIDs where salary is more than average.


		SELECT COUNT(DISTINCT DepartmentID) AS DEPTCOUNT FROM #Employees
		WHERE Salary > (SELECT AVG(Salary) FROM #Employees )


 --15. List distinct employee names and their corresponding join dates.

       SELECT DISTINCT NAME , JOINDATE FROM #Employees;



	   
-- 🔹 CAST (Questions 16–30)

--16. Show all employee salaries casted as integers.

     SELECT CAST(SALARY AS INT) AS SALARYINT FROM #Employees;

--17. Convert JoinDate of employees into VARCHAR.
  
   SELECT CAST(JOINDATE AS VARCHAR(20)) AS DATEVARCHAR FROM #Employees;

--18. Show salaries divided by 1000 and cast to VARCHAR.

	SELECT CAST(SALARY /1000  AS VARCHAR(20))   FROM #Employees;

--19. Cast EmployeeID to CHAR and display along with name.

   SELECT CAST(EMPLOYEEID AS CHAR) , NAME FROM #Employees;

--20. Cast decimal salary to integer for employees in department 5.

    SELECT CAST(SALARY AS INT) FROM #Employees
	WHERE DepartmentID = 5

--21. Convert join date to a string format and show year only.

		SELECT CAST(YEAR(JOINDATE) AS VARCHAR(10)) FROM #Employees;

--22. Cast salary to FLOAT and display for each employee.

    SELECT CAST(SALARY AS float) , NAME FROM #Employees;

--23. Display employee name and salary with salary casted to VARCHAR.

     SELECT NAME , CAST(SALARY AS VARCHAR(20)) FROM #Employees;

--24. Cast JoinDate to DATETIME and add 1 day.

	SELECT  DATEADD(DAY , 1 , CAST(JOINDATE AS date)) FROM #Employees 

--25. Cast the average salary to an INT.

  SELECT  AVG(CAST( SALARY AS INT)) FROM #Employees

    select * from #Employees
--26. Cast NULL salaries to 0 using CAST.
update #Employees
set Salary = null
where EmployeeID =101;
  
    SELECT COALESCE(SALARY , 0)  FROM #Employees

--27. Show all employee names where salary casted to INT is less than 60000.

  SELECT NAME , CAST(SALARY AS INT) AS LESSSIXTY FROM #Employees
  WHERE Salary < 60000;

--28. Cast JoinDate to TIME (if supported).

		SELECT CAST(JOINDATE AS TIME) FROM #Employees;
		-- OR DATETIME
--29. Display salaries rounded to nearest integer using CAST.

		SELECT CAST(ROUND(SALARY , 0) AS INT)  FROM #Employees;

--30. Cast employee count to VARCHAR.


      
	  SELECT CAST(COUNT(EmployeeID) AS VARCHAR(10)) AS EMPLOYEECOUNT FROM #Employees;

	  
-- 🔹 Nested Queries (Questions 31–50)

--31. Find employees who earn more than the average salary.
 
      SELECT NAME FROM #Employees
	  WHERE Salary > (SELECT AVG(Salary) FROM #Employees);

--32. List employees who work in the 'HR' department.

		SELECT NAME FROM #Employees
		WHERE DepartmentID IN ( SELECT DepartmentID FROM #Departments WHERE DepartmentName = 'HR')

--33. Retrieve departments that do not have any employees.

		SELECT  DEPARTMENTNAME FROM #Departments
		WHERE DepartmentID IN (SELECT DISTINCT DepartmentID FROM #Employees WHERE  EmployeeID IS NULL)

	
--34. Get names of employees with the maximum salary.

     SELECT NAME  FROM  #Employees
	 WHERE Salary = (SELECT MAX(Salary) FROM #Employees)

--35. List employees who joined on the same date as any other employee.

		SELECT NAME FROM #Employees
		WHERE JoinDate IN (
	        SELECT JoinDate FROM #Employees
			GROUP BY JoinDate
			HAVING COUNT(*) > 1	
		)


--36. Show employees whose salary equals the second highest salary.

     
	 SELECT NAME FROM #Employees
	 WHERE Salary = (
	 SELECT MAX(Salary) FROM #Employees 
	 WHERE Salary < (
	 SELECT MAX(Salary) FROM #Employees
	 ))
	 
	 

--37. List department names where at least one employee earns more than 100000.

    SELECT DepartmentName FROM #Departments 
	WHERE DepartmentID IN (SELECT DepartmentID FROM #Employees 
	WHERE Salary > 100000);

--38. Get names of employees who earn more than all employees in department 2.

		SELECT NAME FROM #Employees
		WHERE Salary > ALL(SELECT Salary FROM #Employees WHERE DepartmentID = 2); 


--39. Find employees working in the same department as 'John' OR "HARSH MEHTA".

    SELECT NAME FROM #Employees
	WHERE DepartmentID  = (SELECT  DepartmentID FROM #Employees WHERE NAME = 'HARSH MEHTA' ) AND NAME <> 'HARSH MEHTA';

--40. Show employees who do not work in any department listed in Departments table.


   SELECT  NAME FROM #Employees
   WHERE DepartmentID NOT IN (SELECT DepartmentID FROM #Employees )


--41. List employees whose department name starts with 'S'.

    SELECT NAME FROM #Employees
	WHERE DepartmentID IN (SELECT DepartmentID FROM #Departments WHERE DepartmentName LIKE 'S%')


	

--42. Retrieve names of departments with more than 5 employees.
 
    
	    SELECT DepartmentName FROM #Departments
		WHERE DepartmentID = (SELECT DepartmentID FROM #Employees GROUP BY DepartmentID HAVING COUNT(*) > 5)


--43. Find names of employees earning the least salary.

  SELECT NAME FROM #Employees
  WHERE Salary = (SELECT MIN(Salary) FROM #Employees)

--44. List departments having average salary more than 70,000.

   SELECT DISTINCT DepartmentName FROM #Departments
   WHERE DepartmentID  IN (SELECT DepartmentID FROM #Employees
   GROUP BY DepartmentID  HAVING AVG(Salary) > 70000)


--45. Get employees who joined after the average JoinDate.

		SELECT  NAME FROM #Employees 
		WHERE JoinDate > (SELECT CAST(AVG(CAST(CAST(JoinDate AS DATETIME) AS FLOAT)) AS DATETIME) FROM #Employees)

--46. Show employees who have the same salary as any employee in department 1.

		SELECT NAME  FROM #Employees
		WHERE Salary = ANY(SELECT DISTINCT SALARY FROM #Employees  WHERE DepartmentID =1 ) AND DepartmentID <> 1 ;


--47. List employee names who joined before any employee in 'Finance'.

 
SELECT Name FROM #Employees
WHERE JoinDate < ( SELECT MIN(JoinDate)
    FROM #Employees
    WHERE DepartmentID IN ( SELECT DepartmentID FROM #Departments
        WHERE DepartmentName = 'Finance'
    )
);

--48. Find departments that have at least one employee with salary < 30,000.

    SELECT DepartmentName FROM #Departments 
	WHERE  DepartmentID IN (SELECT DepartmentID FROM #Employees 
	    WHERE Salary < 30000
	);

--49. Show names of employees who do not have the highest salary in their department.

			SELECT NAME, Salary FROM #Employees E
			WHERE Salary < (SELECT MAX(Salary) FROM #Employees
			  WHERE DepartmentID = E.DepartmentID
			); 
			
--50. Find employees who earn more than the average salary in their own department.

		SELECT NAME FROM #Employees E
		WHERE  SALARY > (SELECT AVG(Salary) FROM #Employees
		   WHERE DepartmentID = E.DepartmentID
		);


