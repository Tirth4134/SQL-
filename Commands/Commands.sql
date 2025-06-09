
create table Employees (
   id int primary key,
   Name varchar(50),
   Department  varchar(50),
   Salary int  
);


insert into Employees 
values
(1,'tirth', 'software developer', 55000 ),
(2,'astha', 'CRM', 45000 ),
(3,'gautam', '.net', 27000 ),
(4,'jeet', 'web designer', 40000 ),
(5,'abhishek', 'QA', 34000 ),
(6,'dhyey', 'power bi', 60000 ),
(7,'mihir', 'backend develoeper', 46000 ),
(8,'param', 'node', 60000 ),
(9,'manthan', 'Sr web designer', 70000 ),
(10,'apurv', 'HR', 75000 );

 ------2) modify  (add column JoiningDate with datatype DATE)
alter table Employees
 Add  JoiningDate  date;

 -----4) modify  (drop column JoiningDate with datatype DATE)
alter table Employees
drop column JoiningDate;


    -- 2) change datatype of salary
alter table  Employees
alter column Salary DECIMAL(10,2);

 ------5) rename the table name
EXEC sp_rename  'Employees', 'Staff';


 ------6) Truncate all records from the Staff 
truncate  table Staff;

--
drop table Staff;

 ------ 7)drop table Employees;

/**8)Insert five records into the Employees table, also 13) question null value insert 
note: need again first create a Employees table
**/
 insert into Employees
 values 
 (11,'nilesh', 'sales', 45000 ),
(12,'chirag', 'TL manager', 120000 ),
(13,'samiksha', 'project manager', 77000 ),
(14,'sahil' ,'',  50000 ),
(15,'parth', 'froentend dveloper', 34000 );

------9) Update the salary of an employee with ID = 3 to 60,000
update  Employees 
set salary = 60000
where id = 3;

------10)Delete all employees in the 'HR' department
delete from Employees where Department = 'HR';

------11) Update multiple columns 
update Employees
set name = 'glory', Department = 'QA', Salary = 40000
where id = 4;

 -----12)Use a WHERE clause in DELETE to remove specific records
delete from Employees
WHERE  id = 8;


 ------15) Insert a record and commit it. Then insert another and roll it back 
begin transaction ;
 
insert into Employees values
 (16,'parthiv', 'account manager', 48000 );

commit;

begin transaction;

insert into Employees values
   (17,'janvi', 'HR', 10000 );

rollback;

 update   Employees
 set salary = 50000
 where id = 16;

 select * from Employees;


------14) Begin a transaction to update two rows and then rollback if any update fails. 
    begin transaction;

	update   Employees
 set department = 'software developer'
 where id = 2;

 update   Employees
 set name = 'joseph'
 where id = 7;

 commit;

 -----17)Retrieve names and salaries of employees in the 'software developer' department
 select id , name from Employees
 where Department = 'software developer';

 -----18)Use WHERE to filter records based on a condition
 select name, salary from Employees
where salary > 50000;

 ------19)Retrieve distinct department names from the Employees table
select distinct  department from Employees;


------16) Select all records from the Employees table. 
select * from Employees;

