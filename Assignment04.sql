create database Assignment04Db
use Assignment04Db

create Table Products
(PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float,
PTax as PPrice * 0.10 Persisted,
PCompany nvarchar(50),PQty int Default 10 check (PQty>=1))

select * from Products

insert into Products(PName,PPrice,PCompany) values 
('Mobile' , 25000,'Samsung'),
('Earbuds',12000,'Apple'),
('Laptop',90000,'Redmi'),
('Mobile',35000,'HTC'),
('Earphone',6000,'RealMe'),
('TV',45000,'Xiaomi'),
('Tablet',89000,'Apple'),
('SmartWatch',11000,'Samsung'),
('Earbuds',5000,'Realme'),
('Laptop',150000,'Apple')

select * from Products

create proc usp_Prod
with encryption
as
begin
select PId,PName,(PPrice+PTax) as PricewithTax,PCompany,
(PQty * (PPrice+PTax)) as TotalPrice from Products
end

exec sp_helptext usp_prod

create proc usp_prod2
@comp nvarchar(50),
@tottax float output
with encryption
as
select @tottax =SUM(PTax)
from Products where PCompany = @comp
declare @ProdTax float
exec usp_prod2 
@comp='Apple', @tottax = @ProdTax output
print @tottax

execute sp_helptext usp_prod2


