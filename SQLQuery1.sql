create database EMPID264;

use EMPID264;
go
create table emplist(ID int primary key,Name varchar(15) not null,Email varchar(25) not null,Mobile varchar(10));

--alter table emplist MODIFY (Name varchar(20));
ALTER TABLE emplist ADD Age int;

select * from emplist;

insert into emplist values(264,'Purandhar','purandharkola@gmail.com',7981862413,21);
insert into emplist values(265,'Vijay','vijay@gmail.com',7898862413,21);
insert into emplist values(266,'Srinivas','srinivas@gmail.com',7989876543,21);
insert into emplist values(267,'Ruthvik','ruthvik@gmail.com',7983423344,21);
insert into emplist values(268,'Puneeth','puneeth@gmail.com',7234567813,21);



update emplist set Name='Srinivas Reddy' where ID=266;


update emplist set Age=22; --Every row is updated
update emplist set Age=NULL where ID=264;
update emplist set Age=45 where ID=267;
update emplist set Age=23 where Name='Ruthvik' and ID=267;
--alter table emplist RENAME COLUMN Age to AGE;
COMMIT;
delete from emplist where ID=267
ROLLBACK;

select * from emplist;

select Name,Email,Age,Mobile from emplist where ID=264;

truncate table emplist;

USE master;
GO
--RESTORE DATABASE EMPID264 from DISK='C://Users/Public/Backup' with REPLACE,RECOVERY;


alter database EMPID264 set RESTRICTED_USER with rollback IMMEDIATE;

alter database EMPID264 set MULTI_USER;
delete from emplist where ID=238;

begin transaction;
insert into emplist values(502,'abc','abc@gmail.com',7418529630,44);
rollback transaction;

select * from emplist;

delete from emplist where ID=302 or ID=303 or ID=306;

delete from emplist where ID=268 and ID=299;

create table prod(pid int primary key,pname varchar(15),pcolor varchar(10) foreign key);

begin transaction;
insert into emplist values(502,'abc','abc@gmail.com',7418529630,44);
commit transaction;
rollback transaction;

select * from emplist ORDER BY Age Desc;