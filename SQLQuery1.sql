create database EBillDB;

create table tbl_BillDetails(ID int primary key identity,
CustomerName varchar(255), MobileNumber varchar(255),
Address varchar(255),TotalAmount int);


create table tbl_BillItems(Id int primary key identity,
ProductName varchar(255),Price int,Quantity int,
BillId int foreign key references tbl_BillDetails(Id));





--saving all bill details
create procedure spt_saveEBillDetails
@CustomerName varchar(255),
@MobileNumber varchar(255),
@Address varchar(255),
@TotalAmount int,
@Id int output 
as
begin
insert into tbl_BillDetails(CustomerName,MobileNumber,Address,TotalAmount)
values(@CustomerName,@MobileNumber,@Address,@TotalAmount);

select @Id = SCOPE_IDENTITY()
end



create procedure spt_getAllEBillDetails
as
begin
select * from tbl_BillDetails;
end


create procedure spt_getEBillDetails
@Id int
as
begin
select d.Id as'BillId' ,d.CustomerName, d.MobileNumber, d.Address,d.TotalAmount,
i.Id as 'ItemId', i.ProductName,i.Price,i.Quantity
from tbl_BillDetails d inner join tbl_BillItems i
on d.Id = i.BillId
where d.Id = @Id;
end







delete from tbl_BillDetails;