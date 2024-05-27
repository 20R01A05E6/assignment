select Name , Age from emplist;
select distinct Name from emplist;
select count(distinct Name) from emplist;
select * from emplist order by Mobile;
select * from emplist order by Name ASC,Age DESC;
insert into emplist values(123,'abc','bbc@gmail.com',7774118522,46);
select * from emplist;
select * from emplist where NOT Age=21;
select * from emplist where Age NOT BETWEEN 21 and 46;

select TOP 50 PERCENT * from emplist;
--select * from emplist fetch FIRST 50 PERCENT ROWS ONLY;
select TOP 3 * from emplist order by ID asc;
select TOP 4 * from emplist where Age between 20 and 46 order by Age desc ;
--select * from emplist LIMIT 4;

select min(Age) from emplist;
select max(Age) from emplist;   select max(Age) as max_age from emplist;
select count(Age) from emplist;
select avg(Age) from emplist;
select sum(Age) from emplist;
select max(Age) as max_age,ID from emplist group by ID;
select count(*) as [Number of Records],ID from emplist group by ID;
select ID,max(Age) as Age from emplist group by ID having max(Age)>24;
--select ID,Name,max(Age) as Age from emplist group by ID having max(Age)>24;


create table customer
(c_id int primary key,c_name varchar(15) not null,
Email varchar(20) not null unique,Mobile varchar(10) not null unique,
Age int not null);
insert into customer values(1001,'aa','aa@gmail.com',7410442963,21);
insert into customer values(1002,'bb','bb@gmail.com',7410338583,25);
insert into customer values(1003,'cc','cc@gmail.com',7410465674,24);
insert into customer values(1004,'dd','dd@gmail.com',8410772963,29);
insert into customer values(1005,'ee','ee@gmail.com',6410888963,31);
insert into customer values(1006,'ff','ff@gmail.com',8960992963,45);
insert into customer values(1007,'gg','gg@gmail.com',7752252963,51);
insert into customer values(1008,'hh','hh@gmail.com',9630052963,26);
select * from customer;
truncate table customer;

create table orders(oid int primary key,Order_Number int unique not null,c_id int foreign key references customer(c_id));

select * from orders;

insert into orders values(101,1231,1001);
insert into orders values(102,1232,1002);
insert into orders values(103,1233,1003);
insert into orders values(104,1234,1004);
insert into orders values(105,1235,1005);
insert into orders values(106,1236,NULL);

update orders set c_id=1005 where oid=102;

update customer set age=23 where c_id=008;
delete from customer where c_id in (1,2,3,4,5,6,7);

create table product(
	pid int not null,
	p_name varchar(15) not null,
	oid int,
	primary key (pid),
	constraint Fk_Order foreign key (oid) references orders(oid) 
);

alter table product drop constraint Fk_Order;
alter table product add constraint Fk_Order foreign key (oid) references orders(oid) ON update cascade;
delete from orders where oid=101;
update orders set Order_Number=1007 where oid=102;

select * from customer;
select * from orders;
select * from product;

alter table customer add check(Age>15);
insert into customer values(1088,'th','th@gmail.com',9632112963,8);

select c_name,Email,Order_Number,oid from customer inner join orders on customer.c_id=orders.c_id;                 --inner join
select c_name,Order_Number from customer left join orders on customer.c_id = orders.c_id order by customer.Age;    --left join
select Order_Number,p_name from orders right join product on orders.oid = product.oid;                             --right join
select Order_Number,p_name from orders full outer join product on orders.oid = product.oid;                        --full outer join

insert into product values(201,'apple',101);
insert into product values(202,'banana',102);
insert into product values(203,'cherry',103);
insert into product values(204,'guvva',NULL);
insert into product values(205,'pineapple',NULL);
insert into product values(206,'mango',NULL);
insert into product values(207,'grape',NULL);



create table tt(id int,ttdate date default getdate());
select * from tt;
alter table tt add tt_name varchar(10);
insert into tt values(1,default,'a');

begin try
	begin transaction
	update tt set tt_name='b' where id=3/0;
	commit
	print 'Transaction committed'
end try
begin catch
	print 'error'
	rollback
end catch


create table emp(id int,name varchar(10),age int,salary int);
insert into emp(id,name,salary) values(1,'a',45000);
update emp set age=23 where id=1;
insert into emp values(2,'b',24,46000);
insert into emp values(3,'c',25,49000);
insert into emp values(4,'d',34,42000);
insert into emp values(5,'e',27,65000);
insert into emp values(6,'f',21,39000);
insert into emp values(7,'g',28,29000);
insert into emp values(8,'h',22,37000);
insert into emp values(9,'i',37,56000);
insert into emp values(1,'aa',25,46000);

select id,salary from emp where salary between 30000 and 600000;
create index index_salary on emp (salary asc);
alter table emp alter column id int not null;
alter table emp add Primary key (id);
delete from emp where name='aa';
exec sp_helpindex emp;
drop index emp.[PK__emp__3213E83FB0A811B8];
alter table emp drop constraint [PK__emp__3213E83FB0A811B8];
create clustered index composite_cluster on emp(id asc,salary desc);
drop index emp.composite_cluster;

create table person(id int,first_name varchar(15),lastname varchar(10),age int);
select * from person;
exec sp_helpindex person;
alter 
