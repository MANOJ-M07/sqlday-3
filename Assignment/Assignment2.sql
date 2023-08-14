use ThirdExerciseDb

create table Product
(PId int primary key,
PQ int,
PPrice float,
Discount Float)
INSERT INTO Product VALUES (101, 5, 100.0, 10.0)
INSERT INTO Product VALUES (102, 10, 250.0, 15.0)
INSERT INTO Product VALUES (103, 2, 50.0, 5.0)

create function  DiscValue(@price float, @discount float)
returns float
as
begin
declare @discountedValue float
set @discountedValue = @price - (@price * @discount / 100)
return @discountedValue
end

select P.PId, P.PPrice AS Price, P.Discount, dbo.DiscValue(P.PPrice, P.Discount) AS PriceAfterDiscount
from Product P;





