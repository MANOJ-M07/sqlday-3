create database ThirdExerciseDb

use ThirdExerciseDb


create table CompanyInfo
(CId int primary key,
CName nvarchar(50)not null)
insert into CompanyInfo values (1,'SamSung')
insert into CompanyInfo values (2,'HP')
insert into CompanyInfo values (3,'Apple')
insert into CompanyInfo values (4,'Dell')
insert into CompanyInfo values (5,'Toshiba')
insert into CompanyInfo values (6,'Redmi')

select * from CompanyInfo

create table ProductInfo
(PId int primary key,
PName nvarchar(50),
PPrice float,
PMDate date,
CId int)
insert into ProductInfo values (101,'Laptop',55000.90,'12/12/2023',1)
insert into ProductInfo values (102,'Laptop',35000.90,'12/12/2012',2)
insert into ProductInfo values (103,'Mobile',15000.90,'12/12/2012',2)
insert into ProductInfo values (104,'Laptop',135000.90,'12/03/2012',3)
insert into ProductInfo values (105,'Mobile',65000.90,'12/12/2012',3)
insert into ProductInfo values (106,'Laptop',35000.90,'12/12/2012',5)
insert into ProductInfo values (107,'Mobile',35000.90,'12/01/2012',5)
insert into ProductInfo values (108,'Earpod',1000.90,'12/01/2022',3)
insert into ProductInfo values (109,'Laptop',85000.90,'12/12/2021',6)
insert into ProductInfo values (110,'Mobile',55000.70,'12/12/2020',1)

select * from ProductInfo

---to show all company names and their product details-----------------
select C.CName, p.*
from CompanyInfo C
inner join ProductInfo P on C.CId = P.CId;

----- to show all product names and their respective company names--------------
select P.PName, C.CName
from ProductInfo P
inner join CompanyInfo C on P.CId = C.CId;

----to show all possible combinations of company and products-------------------
select C.CName, P.PName
from CompanyInfo C
cross join ProductInfo P;

