--create table if not exists emp(id int,name varchar);
select object_id('emp') as result;
select name,object_id,object_id(name) as [object_name] from sys.objects where name='emp';

select object_id('emp7') as id;
create table emp1(id int);
if object_id('emp1') is NULL create table emp1(id int,name varchar);
select object_id('emp1') as id;
select db_id('EMPID264') as id;
select object_id(N'emp1') as id;
if object_id(N'dbo.emp1',N'U') is not null drop table emp1;


select * from emp;
select Top 0 id,name into emp2 from emp;
select Top 0 * into emp3 from emp;


--create table emp4(select 
--	id as emp_id,
--	name as emp_name,
--	age as emp_age,
--	salary as emp_salary
--from emp);

select id as empid, name as empname, age as empage,salary as empsalary into emp4 from emp;
select top 0 id as empid, name as empname, age as empage,salary as empsalary into emp5 from emp;
select * from emp6;
select id as empid, name as empname into emp6 from emp;
insert into emp4 select id as emp_id,name as emp_name;

--create table temp1(id int identity(1,1),name int identity(1,1));

create table temp(id int identity(1,1),name varchar(10));
alter table temp add constraint pk primary key (id);
insert into temp values('a');
insert into temp values('b');
insert into temp values('c');
insert into temp values('d');
insert into temp values(6,'d');
set identity_insert temp off;
delete from temp where id=6;
create nonclustered index fk on temp (name);

DBCC CHECKIDENT ('temp', RESEED, 12);

select * from temp3;
select * into temp3 from temp where 1=0;
select * from temp where id>3 group by name;


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'emp7')
BEGIN
    EXEC('
    CREATE TABLE emp7 (
        Column1 int,
        Column2 int
		);');
END;
select * from temp2;
create table temp2(id int ,name varchar);
create clustered index ci on temp2 (id);
insert into temp2 values(1,'a');
select %%physloc%% as address_no from temp2;

update temp2 set id=3 where id=2;



---------------------------------------

CREATE TABLE dbo.Products
   (
      ProductID int IDENTITY (1,1) NOT NULL
      , QtyAvailable smallint
      , UnitPrice money
      , InventoryValue AS QtyAvailable * UnitPrice
    );

-- Insert values into the table.
INSERT INTO dbo.Products (QtyAvailable, UnitPrice)
   VALUES (25, 2.00), (10, 1.5);

-- Display the rows in the table.
SELECT ProductID, QtyAvailable, UnitPrice, InventoryValue FROM dbo.Products;
SELECT * FROM dbo.Products;

-- Update values in the table.
UPDATE dbo.Products SET UnitPrice = 2.5 WHERE ProductID = 1;

ALTER TABLE dbo.Products ADD RetailValue AS (QtyAvailable * UnitPrice * 1.5);
alter table dbo.Products drop column RetailValue;
ALTER TABLE dbo.Products ADD RetailValue AS (QtyAvailable * UnitPrice * 1.5) PERSISTED;

delete from Products where ProductID=2;
rollback


---------------------------------------------------------

create table tb1(id int primary key identity,name nvarchar(50),email nvarchar(50),dept nvarchar(50));


declare @counter int =1
while(@counter<=1000000)
Begin
	declare @name nvarchar(50) ='ABC'+RTRIM(@counter)
	declare @email nvarchar(50)='abc'+RTRIM(@counter)+'@gmail.com'
	declare @dept nvarchar(50)='dept'+RTRIM(@counter)
	insert into tb1 values(@name,@email,@dept)
	set @counter=@counter+1
	if(@counter%100000=0)
		print rtrim(@counter)+'rows inserted'
end
select top 10000 * from tb1;
create nonclustered index nci on tb1(name);
select name from tb1 where name='ABC9999';
select id from tb1 where id=9999;
update tb1 set email='updated1@gmail.com' where name='ABC9999';
update tb1 set email='updated2@gmail.com' where name='ABC9998';
update tb1 set email='updated2@gmail.com' where id=9997;
delete from tb1 where name='ABC9998';
sp_spaceused tb1
insert into temp values('a');
select * from temp;
select name from temp group by name;
select distinct name from temp;

----------------------------------------------------------------------


CREATE FUNCTION fun1(@x INT)
RETURNS int
AS
BEGIN
  RETURN @x * @x *@x
END
select dbo.fun1(3);







CREATE FUNCTION CalculateAge1
(
  @DOB DATE
)
RETURNS INT
AS
BEGIN
  DECLARE @AGE INT
  SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())
  RETURN @AGE
END
select dbo.CalculateAge1('2002/11/02') as age;




CREATE FUNCTION CalculateAge
(
  @DOB DATE
)
RETURNS INT
AS
BEGIN
  DECLARE @AGE INT
  SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())-
  CASE
    WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
       (MONTH(@DOB) = MONTH(GETDATE()) AND
        DAY(@DOB) > DAY(GETDATE()))
    THEN 1
    ELSE 0
  END
  RETURN @AGE
END
select dbo.CalculateAge('2002/11/02') as age;