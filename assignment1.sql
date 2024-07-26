

/* 1. Write a script to extracts all the numerics from Alphanumeric String */
create function dbo.extractnumeric(@input nvarchar(max))
returns nvarchar(max)
as
begin
declare @numeric nvarchar(max)='';
declare @position int = 1;
declare @len int =len(@input);
declare @char nvarchar(1);
while @position <= @len
begin
set @char=substring(@input,@position,1);
if patindex('%[0-9]%',@char)>0
begin
set @numeric=@numeric+@char;
end
set @position=@position+1;
end
return @numeric;
end;


declare @alphanumeric nvarchar(max)='a1b2c3d4e5';
select dbo.extractnumeric(@alphanumeric) as numerics;


-------------------------------------------------------

/* 2. Write a script to calculate age based on the Input DOB */

 create function dbo.calculateAge(@dob date)
 returns int
as
begin
declare @today date=getdate()
declare @age int
set @age=datediff(year,@dob,@today);
if(month(@today)<month(@dob)) or (month(@today) = month(@dob) and day(@today) < day(@dob))
begin
set @age=@age-1;
end
return @age;
end;

declare @dob date='2002-11-02';
select dbo.calculateAge(@dob);


--------------------------------------------------------

/* 3. Create a column in a table and that should throw an error when we do SELECT * or SELECT of that column. If we select other columns then we should see results */

create table error(eid int,ename varchar(15),error as (eid/0));
insert into error values(1,'a');
select * from error;
select error from error;




---------------------------------------------------------

/* 4. Display Calendar Table based on the input year. */

create table calender([Date] DATE PRIMARY KEY,DayOfYear INT,[Week] INT,DayOfWeek INT,[Month] INT,DayOfMonth INT);

CREATE PROCEDURE dbo.CalendarInfo
    @year INT
AS
BEGIN 
	truncate table calender;
    WITH CalendarDetails AS (
        SELECT DATEFROMPARTS(@year, 1, 1) AS [Date]
        UNION ALL
        SELECT DATEADD(DAY, 1, [Date])
        FROM CalendarDetails
        WHERE YEAR([Date]) = @year AND YEAR(DATEADD(DAY, 1, [Date])) = @year
    )
    INSERT INTO calender ([Date], DayOfYear, [Week], DayOfWeek, [Month], DayOfMonth)
    SELECT 
        [Date],
        DATEPART(DAYOFYEAR, [Date]) AS DayOfYear,
        DATEPART(WEEK, [Date]) AS [Week],
        DATEPART(WEEKDAY, [Date]) AS DayOfWeek,
        MONTH([Date]) AS [Month],
        DAY([Date]) AS DayOfMonth
    FROM 
        CalendarDetails
    WHERE [Date] NOT IN (SELECT [Date] FROM calender)
    OPTION (MAXRECURSION 0);
END;



exec dbo.CalendarInfo @year=2024;
select * from calender;






------------------------------------------------------------------------------------------

/* 5. Display Emp and Manager Hierarchies based on the input till the topmost hierarchy. */

create table employees(empid int primary key,ename varchar(15),managerid int null,foreign key(managerid) references employees(empid));

insert into employees values(1,'Abhi',null);
insert into employees values(2,'Balaji',1);
insert into employees values(3,'Dinesh',2);
insert into employees values(4,'Fanish',2);
insert into employees values(5,'Ganesh',3);
insert into employees values(6,'Harish',5);
insert into employees values(7,'Jayanth',4);
insert into employees values(8,'Kishore',6);
insert into employees values(9,'Mourya',3);
insert into employees values(10,'Naresh',7);
insert into employees values(11,'Vijay',1);

select * from employees;



create procedure dbo.EmployeeHierarchy
@inputempid int
as
begin
WITH EmployeeHierarchy AS (
    SELECT empid, ename, managerid, 1 AS HierarchyLevel
    FROM employees
    WHERE empid = @inputempid

    UNION ALL

    SELECT e.EmpId, e.ename, e.managerid, eh.HierarchyLevel + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.empid = eh.managerid
)

SELECT 
    eh.empid, 
    eh.ename, 
    COALESCE(mgr.ename, 'Top Management') AS ManagerName, 
    eh.HierarchyLevel
FROM 
    EmployeeHierarchy eh
LEFT JOIN 
    employees mgr ON eh.managerid = mgr.empid
ORDER BY 
    eh.HierarchyLevel DESC;
end;

exec dbo.EmployeeHierarchy @inputempid=7;




----------------------------------------------------------------------------------------------



