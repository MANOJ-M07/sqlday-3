use joinExDb

select * from Emps order by Id
select * from Depts order by DId

--outer :left, right , full
--left outer join

select e.Id,e.Fname,e.Lname,d.DId,e.Salary,e.Designation,d.DName 'Department'
from Emps e left outer join Depts d on e.DId = d.DId

--right outer join

select e.Id,e.Fname,e.Lname,d.DId,e.Salary,e.Designation,d.DName 'Department'
from Emps e right outer join Depts d on e.DId = d.DId

--full outer join

select e.Id,e.Fname,e.Lname,d.DId,e.Salary,e.Designation,d.DName 'Department'
from Emps e full outer join Depts d on e.DId = d.DId

create table Sizes(SId int primary key,
Size nvarchar(50) not null unique)

create table Colors(CId int primary key,
Color nvarchar(50) not null unique)

insert into Sizes values (1, 'short'),(2, 'Medium'),(3,'Large')
insert into Colors values(1,'Light blue'),(2,'Green'),(3,'Whitesmoke'),(4,'Pink')

--table1 m rows , table2 n rows cross join m*n rows
--sizes 3, COLOR 4,cross join 12
select Size,Color from Sizes cross join Colors

insert into Sizes values (4,'Extra Large')
--Sizes 4, color 4, cross join 16
select Size,Color from Sizes cross join Colors

--self join
create table Employee (Id int primary key,
Fname nvarchar(50) not null,
Lname nVarchar(50) not null,
ManagerId int)
insert into Employee (Id,Fname,Lname) values(1,'Sam','Dicosta')
insert into Employee values (3,'Niraj','kumar',1)
insert into Employee values (4,'Varun','kumar',5)
insert into Employee values (6,'Vipin','Singh',1)
insert into Employee values (8,'Gagan','kumar',2)
insert into Employee values (9,'Gaurav','kumar',2)
insert into Employee values (10,'Rohit','kumar',1)
insert into Employee(Id,Fname,Lname) values(5,'Raj','M')
insert into Employee(Id,Fname,Lname) values(2,'Mukesh','K')
select * from Employee

select e1.Fname+' '+e1.Lname as 'EmployeeName',e2.Fname+' '+e2.Lname as 'Manager Name'
from Employee e1
join Employee e2
on e1.ManagerId=e2.Id

select e1.Fname+' '+e1.Lname as 'EmployeeName',e2.Fname+' '+e2.Lname as 'Manager Name'
from Employee e1
join Employee e2
on e1.ManagerId=e2.Id order by e1.ManagerId
-----------------------------------------------functions---------------------------------
--Built in functions
--Aggergate function
select * from Emps
select sum(Salary) as 'Total Salary' from Emps
select sum(Salary) as 'Average Salary' from Emps
select sum(Salary) as 'Max Salary' from Emps
select sum(Salary) as 'Min Salary' from Emps
--string

select  UPPER ('india')
select lower ('india')
select left('india', 2)
select right('india',3)
select ltrim ('              india      ')
select rtrim('           india         ')
select trim('         india         ')

select UPPER (fname), upper (lname) from Emps

create table Customer
(Id int primary key,
Name nVarchar(50) not null,
ODLimit float not null,
SStartDate date not null,
SEndDate date not null)
insert into Customer values (1,'Sam',598000,'12/12/2010','12/12/2024')
insert into Customer values (2,'Ravi',798000,'02/20/2022','12/12/2025')
insert into Customer values (3,'Raj',698000,'01/23/2023','12/12/2025')
--Date function

select GETDATE()
select DATEPART(day,getDate())
select DATEPART(MONTH,getDate())
select DATEPART(year,getDate())
select DATEDIFF(year,'12/12/2000',GETDATE())
select DATEPART(month,SStartDate) from Customer
select DATEPART(month,SEndDate) as 'End Month', DatePart(year,SEndDate) as 'End Year' from Customer
----------------------------------------------------------------------------------------------------
create function fnFullName
(
@fn nvarchar(50),
@ln nvarchar(50)
)
returns nvarchar(101)
as
begin --{
return(select @fn + ' ' + @ln)
end --}

select dbo.fnFullName('Raj', 'Kumar') as 'Full Name'

select Fname,Lname,dbo.fnFullName(fname,lname) as 'Full Employee Name' from Emps
------------------------------------------
create function BonusCalc(@sal float)
returns float
as
begin
return (select @sal*0.15)
end

select dbo.BonusCalc(50000)

select Fname,Lname,Salary ,dbo.BonusCalc(Salary) as 'Bonus' from Emps

-------------create schema 

create table Products
(PId int primary key,
PName nvarchar(50) not null,
Pprice float)

create schema samsung

create table samsung.Products
(PId int primary key,
PName nvarchar(50),
Pprice float)
insert into samsung.Products values (1,'AC',42000)
create schema lg;

create table lg.Products
(PId int primary key,
PName nvarchar(50)not null,
Pprice float)
insert into lg.Products values (1,'Washing Machine',42000)
insert into lg.Products values (2,'TV',45000)
insert into lg.Products values (12,'Mobile',34000)

create function lg.fnTax
(
@price float
)
returns float
as 
begin
declare @tax float;
if(@price>=25000)
begin
select @tax=@price*0.18
end
else
begin
select @tax=@price*0.10
end
return @tax;
end 
select lg.fnTax(42000) as 'Tax'
----------------------------------------------
drop table Products
create table Products
(PId int primary key,
PName nvarchar(50)not null,
Pprice float,
PCategory nvarchar(50) not null check (PCategory in('Clothing','Grooming','Electric','other')))
insert into Products values (1,'FaceWash',230,'Grooming')
insert into Products values (1,'TV',450000,'Electronic')
insert into Products values (1,'Mobile',34000,'Electronic')
insert into Products values (1,'Face Cream',250,'Grooming')
select * from Products


drop table Products
create table Products
(PId int primary key,
PName nvarchar(50) not null,
Pprice float,
PCategory nvarchar(50) not null check (PCategory in ('Clothing', 'Grooming','Electronic','Other')))

insert into Products values(1,'FaceWash',230,'Grooming')
insert into Products values(2,'TV',46000,'Electronic')
insert into Products values(12,'Mobile',34000,'Electronic')
insert into Products values(5,'Face Cream',250,'Grooming')

select * from Products
select sum(Pprice) as 'Total Products Values' from Products
select sum(Pprice) as 'Sub Total', PCategory from Products group by PCategory
----------------------------------------------------------------------------------------
create table Expenses
(ExpId int primary key identity,
ExpAmount float,
ExpCat nvarchar(50) not null check (ExpCat in ('Stationary','Electronic','Other')),
ExpDate date default getdate())

insert into Expenses values (1200.50,'Stationary','12/12/2022')
insert into Expenses(ExpAmount, ExpCat) values (72000.50,'Electronic')
insert into Expenses values (52400.50,'Electronic','12/12/2022')
insert into Expenses values (2300.50,'Stationary','12/12/2022')
insert into Expenses values (1500.50,'Stationary','12/12/2022')
insert into Expenses values (2300.50,'other','12/12/2022')
insert into Expenses(ExpAmount, ExpCat) values( 1300.50,'Stationary')
insert into Expenses values (1400.50,'other','12/12/2022')

select * from Expenses


select sum(ExpAmount) as 'Category wise Total', ExpCat from Expenses
group by ExpCat

select sum (ExpAmount) as 'Category wise Total', ExpCat from Expenses where
ExpAmount>=(select avg(ExpAmount)from Expenses)
group by ExpCat having ExpCat = 'Electronic'



