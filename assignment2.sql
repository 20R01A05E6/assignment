/* Assignment - 2 */



/* 1. Select all departments in all locations where the Total Salary of a Department is Greater than twice the Average Salary for the department.
And max basic for the department is at least thrice the Min basic for the department */

CREATE TABLE Emp_Data
(
  ID INT PRIMARY KEY IDENTITY(1,1),
  Name VARCHAR(100),
  EmailID VARCHAR(100),
  Gender VARCHAR(100),
  Department VARCHAR(100),
  Salary INT,
  Age INT,
  CITY VARCHAR(100)
)
select * from Emp_Data;
INSERT INTO Emp_Data VALUES('PRANAYA','PRANAYA@G.COM','Male', 'IT', 25000, 30,'MUMBAI')
INSERT INTO Emp_Data VALUES('TARUN','TARUN@G.COM','Male', 'Payroll', 30000, 27,'ODISHA')
INSERT INTO Emp_Data VALUES('PRIYANKA','PRIYANKA@G.COM','Female', 'IT', 27000, 25,'BANGALORE')
INSERT INTO Emp_Data VALUES('PREETY','PREETY@G.COM','Female', 'HR', 35000, 26,'BANGALORE')
INSERT INTO Emp_Data VALUES('RAMESH','RAMESH@G.COM','Male','IT', 26000, 27,'MUMBAI')
INSERT INTO Emp_Data VALUES('PRAMOD','PRAMOD@G.COM','Male','HR', 29000, 28,'ODISHA')
INSERT INTO Emp_Data VALUES('ANURAG','ANURAG@G.COM','Male', 'Payroll', 27000, 26,'ODISHA')
INSERT INTO Emp_Data VALUES('HINA','HINA@G.COM','Female','HR', 26000, 30,'MUMBAI')
INSERT INTO Emp_Data VALUES('HA','HA@G.COM','Female','IT', 260000, 30,'MUMBAI')
INSERT INTO Emp_Data VALUES('FINA','FINA@G.COM','Female','HR', 16000, 30,'MUMBAI')
INSERT INTO Emp_Data VALUES('SAMBIT','HINA@G.COM','Male','Payroll', 30000, 25,'ODISHA')
INSERT INTO Emp_Data VALUES('MANOJ','MANOJ@G.COM','Male','HR', 30000, 28,'ODISHA')
INSERT INTO Emp_Data VALUES('SWAPNA','SWAPNA@G.COM','Female', 'Payroll', 28000, 27,'MUMBAI')
INSERT INTO Emp_Data VALUES('LIMA','LIMA@G.COM','Female','HR', 30000, 30,'BANGALORE')
INSERT INTO Emp_Data VALUES('DIPAK','DIPAK@G.COM','Male','Payroll', 32000, 25,'BANGALORE')
INSERT INTO Emp_Data VALUES('abc','abc@G.COM','Male','Payroll', 65000, 25,'BANGALORE')
INSERT INTO Emp_Data VALUES('ghi','ghi@G.COM','Male','Payroll', 200000, 26,'BANGALORE')
INSERT INTO Emp_Data VALUES('def','def@G.COM','Male','Payroll', 90000, 26,'BANGALORE')
INSERT INTO Emp_Data VALUES('ghi','ghi@G.COM','Male','Payroll', 200000, 26,'BANGALORE')


select department,city from emp_data group by department,city having (sum(salary)>2*(avg(salary)) and max(salary)>3*(min(salary)));

-----------------------------------------------------------------------------------------------------

/* 2. As per the companies rule if an employee has put up service of 1 Year 3 Months and 15 days in office, Then She/he would be eligible for a Bonus.
the Bonus would be Paid on the first of the Next month after which a person has attained eligibility. Find out the eligibility date for all the employees. 
And also find out the age of the Employee On the date of Payment of the First bonus. Display the Age in Years, Months, and Days.
 Also Display the weekday Name, week of the year, Day of the year and week of the month of the date on which the person has attained the eligibility */

create table emp_bonus_date(id int identity,joining_date date,dob date);
insert into emp_bonus_date values('2024-05-21','2002-05-13');
insert into emp_bonus_date values('2023-11-30','2001-07-23');
insert into emp_bonus_date values('2024-04-11','2004-06-30');
insert into emp_bonus_date values('2023-09-18','2002-05-13');
insert into emp_bonus_date values('2022-11-30','2000-03-17');
insert into emp_bonus_date values('2024-01-31','2001-08-13');
insert into emp_bonus_date values('2021-06-05','1999-12-09');
insert into emp_bonus_date values('2024-02-14','2003-01-15');
insert into emp_bonus_date values('2020-12-20','1997-08-22');
insert into emp_bonus_date values('2023-11-16','2001-05-19');
select * from emp_bonus_date;


with datedifference as(
select id,joining_date,dob,
dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date))) as eligible_date,
dateadd(month,datediff(month,0,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date))))+1,0) as BonusPaymentDate,
datename(weekday,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as EligibleWeekday_Name,
datepart(week,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as Eligible_WeekoftheYear,
datepart(dayofyear,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as Eligibile_DayoftheYear,
((datepart(day,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date))))/7)+1) as Eligibile_weekofthemonth from emp_bonus_date
)
select *,dbo.Age_difference(dob,eligible_date) as age_diff from datedifference;


CREATE FUNCTION Age_difference(
    @dob DATE,
    @curda DATE
)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @years INT,@months INT,@days INT,@tmpdate DATE;
SET @tmpdate = @dob;
SET @years = DATEDIFF(yy, @tmpdate, @curda) - 
CASE 
WHEN (MONTH(@dob) > MONTH(@curda)) OR (MONTH(@dob) = MONTH(@curda) AND DAY(@dob) > DAY(@curda)) 
THEN 1 
ELSE 0 
END;
SET @tmpdate = DATEADD(yy, @years, @tmpdate)
SET @months = DATEDIFF(m, @tmpdate, @curda) - 
CASE WHEN DAY(@dob) > DAY(@curda) THEN 1 ELSE 0 END;
SET @tmpdate = DATEADD(m, @months, @tmpdate);
SET @days = DATEDIFF(d, @tmpdate, @curda);
RETURN CAST(@years AS VARCHAR(10)) + ' years ' + CAST(@months AS VARCHAR(10)) + ' months ' + CAST(@days AS VARCHAR(10)) + ' days';
END;


/* select id,joining_date,dob,
dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date))) as eligible_date,
dateadd(month,datediff(month,0,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date))))+1,0) as BonusPaymentDate,
datediff(year,dob,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as Age_AtBonusTime,
datediff(month,dob,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as BonusAge_inMonths,
datediff(day,dob,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as BonusAge_inDays,
datename(weekday,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as EligibleWeekday_Name,
datepart(week,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as WeekoftheYear,
datepart(dayofyear,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date)))) as DayoftheYear,
((datepart(day,dateadd(month,3,dateadd(day,15,dateadd(year,1,joining_date))))/7)+1) as weekofthemonth
from emp_bonus_date; */

-----------------------------------------------------------------------------------------------------

/* 3. Company Has decided to Pay a bonus to all its employees. The criteria is as follows
1. Service Type 1. Employee Type 1. Minimum service is 10. Minimum service left should be 15 Years. Retirement age will be 60
Years
2. Service Type 1. Employee Type 2. Minimum service is 12. Minimum service left should be 14 Years . Retirement age will be 55
Years
3. Service Type 1. Employee Type 3. Minimum service is 12. Minimum service left should be 12 Years . Retirement age will be 55
Years
3. for Service Type 2,3,4 Minimum Service should Be 15 and Minimum service left should be 20 Years . Retirement age will be 65
Years
Write a query to find out the employees who are eligible for the bonus. */


create table bonus_eligibile(id int identity(1,1),name varchar(10),service_type int,employee_type int,dob date,joining_date date);
insert into bonus_eligibile values('aa',1,1,'1985-05-22','2014-03-14');
insert into bonus_eligibile values('bb',1,1,'1991-02-12','2013-11-27');
insert into bonus_eligibile values('cc',1,2,'1999-07-02','2012-08-09');
insert into bonus_eligibile values('dd',1,1,'1998-11-13','2013-04-20');
insert into bonus_eligibile values('ee',1,3,'1989-10-16','2011-09-29');
insert into bonus_eligibile values('ff',1,2,'2000-05-11','2015-11-15');
insert into bonus_eligibile values('gg',1,3,'1984-12-25','2011-04-19');
insert into bonus_eligibile values('hh',1,2,'1997-01-06','2012-03-25');
insert into bonus_eligibile values('aa',2,1,'1981-07-12','2009-07-17');
insert into bonus_eligibile values('aa',4,1,'1980-12-23','2008-11-13');
insert into bonus_eligibile values('aa',3,1,'1984-06-10','2009-03-18');
insert into bonus_eligibile values('aa',2,1,'1985-05-27','2014-09-14');

select * from bonus_eligibile;

select *,datediff(year,joining_date,getdate()) as service_years,
case 
	when service_type=1 and employee_type=1 and datediff(year,joining_date,getdate())>=10 and datediff(year,getdate(),dateadd(year,60,dob))>=15 then 'Eligible'
	when service_type=1 and employee_type=2 and datediff(year,joining_date,getdate())>=12 and datediff(year,getdate(),dateadd(year,55,dob))>=14 then 'Eligible'
	when service_type=1 and employee_type=3 and datediff(year,joining_date,getdate())>=12 and datediff(year,getdate(),dateadd(year,55,dob))>=12 then 'Eligible'
	when service_type in (2,3,4) and datediff(year,joining_date,getdate())>=15 and datediff(year,getdate(),dateadd(year,65,dob))>=20 then 'Eligible'
	else 'Not Eligible'
end
from bonus_eligibile;


----------------------------------------------------------------------------------------------------

/* 4.write a query to Get Max, Min and Average age of employees, service of employees by service Type , Service Status for each Centre(display in years and Months) */


alter table bonus_eligibile add service_status as CONCAT(DATEDIFF(YEAR,joining_date,GETDATE()),' years and ', DATEDIFF(MONTH,joining_date,GETDATE())%12,' months');
SELECT 
    service_Type,service_status,
    MAX(DATEDIFF(YEAR, dob, GETDATE())) AS max_age_years,
    MIN(DATEDIFF(YEAR, dob, GETDATE())) AS min_age_years,
    AVG(DATEDIFF(YEAR, dob, GETDATE())) AS avg_age_years
FROM 
    bonus_eligibile
GROUP BY 
    service_type,service_status;


/* SELECT 
    service_type,
    AVG(DATEDIFF(YEAR, dob, GETDATE())) AS avg_age_years,
    AVG(DATEDIFF(MONTH, dob, GETDATE())) % 12 AS avg_age_months,
    MIN(DATEDIFF(YEAR, dob, GETDATE())) AS min_age_years,
    MIN(DATEDIFF(MONTH, dob, GETDATE())) % 12 AS min_age_months,
    MAX(DATEDIFF(YEAR, dob, GETDATE())) AS max_age_years,
    MAX(DATEDIFF(MONTH, dob, GETDATE())) % 12 AS max_age_months,
    CASE 
        WHEN DATEDIFF(YEAR, joining_date, GETDATE()) >= 15 THEN 'Active'
        ELSE 'Inactive'
    END AS service_status
FROM 
    bonus_eligibile
GROUP BY 
    service_type,joining_date; */


/* select *,min(datediff(year,dob,getdate())) over(partition by service_type order by service_type)as minage,max(datediff(year,dob,getdate())) 
over(partition by service_type order by service_type) as maxage,avg(datediff(year,dob,getdate())) over(partition by service_type order by service_type) as avgage from bonus_eligibile; */







-----------------------------------------------------------------------------------------------------

/* 5. Write a query to list out all the employees where any of the words (Excluding Initials) in the Name starts and ends with the same
character. (Assume there are not more than 5 words in any name ) */

create table emp_name(id int,name varchar(10));
insert into emp_name values(1,'A David');
insert into emp_name values(2,'B Heath');
insert into emp_name values(3,'T Greg');
insert into emp_name values(4,'S Loyal');
insert into emp_name values(5,'P Bob');
insert into emp_name values(6,'Y Madhu');
insert into emp_name values(7,'A Vijay');
insert into emp_name values(8,'K Hersh');
insert into emp_name values(9,'G Madam');
insert into emp_name values(10,'Madam G');
select * from emp_name;

--select name from emp_name where left(name,1)=right(name,1);
select name from emp_name where substring(name,3,1)=substring(name,len(name),1) or substring(name,len(name)-2,1)=substring(name,1,1);
