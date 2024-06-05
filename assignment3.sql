/* 1 Employee Management System:
Consider three tables: employees, departments, and salaries.
 
employees table: employee_id, employee_name, department_id, hire_date
departments table: department_id, department_name
salaries table: employee_id, salary_amount, salary_date
Write a SQL query to retrieve the names of employees along with their department names and the latest salary amount. */

create table Department(dept_id int primary key,dept_name varchar(15));

create table Employee(emp_id int primary key,emp_name varchar(15),dept_id int not null foreign key references Department(dept_id),hire_date date);

create table Salary(emp_id int foreign key references Employee(emp_id),salary_amount int,salary_date date);


insert into Department values(101,'Designer');
insert into Department values(102,'ASE');
insert into Department values(103,'SE');
insert into Department values(104,'Data Analyst');


insert into Employee values(1,'a',102,'2023-02-27');
insert into Employee values(2,'b',104,'2024-03-19');
insert into Employee values(3,'c',101,'2023-12-27');
insert into Employee values(4,'d',101,'2021-11-29');
insert into Employee values(5,'e',103,'2023-12-05');

insert into Salary values(1,50000,'2023-03-27');
insert into Salary values(2,55000,'2024-04-19');
insert into Salary values(3,60000,'2024-01-27');
insert into Salary values(1,60000,'2023-04-27');
insert into Salary values(4,53000,'2021-12-29');
insert into Salary values(2,50000,'2024-05-19');
insert into Salary values(5,63000,'2024-01-05');


select e.emp_name,d.dept_name,latest_amount.salary_amount as latest_salary from Employee e inner join Department d on e.dept_id=d.dept_id
cross apply (
select top 1 salary_amount from Salary sal where sal.emp_id=e.emp_id order by salary_date desc
) as latest_amount;




--------------------------------------------------------------------------------------------


/* 2 Product Inventory:
You have tables products, categories, and orders.
 
products table: product_id, product_name, category_id, price
categories table: category_id, category_name
orders table: order_id, product_id, quantity, order_date
Write a SQL query to find out the total revenue generated from each category in the last month. */


create table categories(category_id int primary key,category_name varchar(15));

create table products(product_id int primary key,product_name varchar(15),category_id int foreign key references categories(category_id),price int);

create table orders(order_id int primary key,product_id int foreign key references products(product_id),quantity int,order_date date);



INSERT INTO categories (category_id, category_name) VALUES (1, 'Electronics');
INSERT INTO categories (category_id, category_name) VALUES (2, 'Clothing');
INSERT INTO categories (category_id, category_name) VALUES (3, 'Books');



INSERT INTO products (product_id, product_name, category_id, price) VALUES (101, 'Laptop', 1, 20000);
INSERT INTO products (product_id, product_name, category_id, price) VALUES (102, 'T-shirt', 2, 200);
INSERT INTO products (product_id, product_name, category_id, price) VALUES (103, 'Book', 3, 150);
INSERT INTO products (product_id, product_name, category_id, price) VALUES (104, 'Mobile', 1, 15000);


INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1001, 101, 2, '2024-06-04');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1002, 102, 3, '2024-06-03');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1003, 103, 1, '2024-06-02');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1004, 101, 1, '2024-05-12');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1005, 102, 1, '2024-05-02');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1006, 101, 1, '2024-05-22');
INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES (1007, 103, 2, '2024-05-08');


--1st query
select c.category_name, sum(p.price*o.quantity) as Revenue from categories c inner join
products p on c.category_id=p.category_id inner join orders o on p.product_id=o.product_id
where o.order_date>=dateadd(month,-1,getdate()) group by c.category_name;


--2nd query
select c.category_name, sum(p.price*o.quantity) as Revenue from categories c inner join
products p on c.category_id=p.category_id inner join orders o on p.product_id=o.product_id
where datepart(month,o.order_date)=(datepart(month,getdate())-1) group by c.category_name;







---------------------------------------------------------------------------------------------

/* 3 Library Management System:
You're dealing with books, authors, and borrowers tables.
 
books table: book_id, book_title, author_id, publication_date
authors table: author_id, author_name, author_country
borrowers table: borrower_id, book_id, borrower_name, borrow_date, return_date
Write a SQL query to list all books along with their authors and the borrowers who borrowed them, including the borrow and return dates. */

create table authors(author_id int primary key,author_name varchar(15),author_country varchar(15));

create table books(book_id int primary key,book_title varchar(15),author_id int not null foreign key references authors(author_id),publication_date date not null);

create table borrowers(borrower_id int primary key,book_id int foreign key references books(book_id),borrower_name varchar(15),borrow_date date,return_date date);


insert into authors values(1,'vijay','hyd');
insert into authors values(2,'puneeth','mumbai');
insert into authors values(3,'srinivas','delhi');
insert into authors values(4,'rithvik','hyd');


insert into books values(101,'a1',1,'2020-03-22');
insert into books values(102,'b',2,'2021-04-25');
insert into books values(103,'c',3,'2022-05-16');
insert into books values(104,'d',4,'2021-08-12');
insert into books values(105,'a2',1,'2022-05-05');

insert into borrowers values(1001,101,'abhi','2020-04-12','2020-10-15');
insert into borrowers values(1002,102,'bob','2021-04-26','2021-10-14');
insert into borrowers values(1003,101,'jack','2020-05-18','2020-08-30');
insert into borrowers values(1004,104,'tony','2021-11-02','2022-02-11');
insert into borrowers values(1005,105,'hulk','2022-06-02','2022-12-11');


select b.book_title,a.author_name,br.borrower_name,br.borrow_date,br.return_date from books b 
inner join authors a on b.author_id=a.author_id inner join borrowers br on b.book_id=br.book_id;


-------------------------------------------------------------------------------------

/* 4 University Enrollment:
There are tables students, courses, enrollments, and grades.
 
students table: student_id, student_name, student_major
courses table: course_id, course_name, course_department
enrollments table: enrollment_id, student_id, course_id, enrollment_date
grades table: grade_id, enrollment_id, grade_value
Write a SQL query to calculate the average grade for each course. */
create table student(student_id int primary key, student_name varchar(15), student_major varchar(15));

create table courses(course_id int primary key, course_name varchar(15), course_department varchar(15));

create table enrollments(
enrollment_id int primary key, 
student_id int foreign key references student(student_id), 
course_id int foreign key references courses(course_id), 
enrollment_date date);

create table grades(
grade_id int primary key,
enrollment_id int foreign key references enrollments(enrollment_id),
grade_value DECIMAL(3,2));


INSERT INTO student (student_id, student_name, student_major) 
VALUES
(1, 'John Doe', 'Computer Science'),
(2, 'Jane Smith', 'Electrical Engineering'),
(3, 'Alice Johnson', 'Biology');


INSERT INTO courses (course_id, course_name, course_department) 
VALUES
(101, 'Introduction to Programming', 'Computer Science'),
(102, 'Circuit Theory', 'Electrical Engineering'),
(103, 'Cell Biology', 'Biology');


INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date) 
VALUES
(1, 1, 101, '2024-01-15'),
(2, 2, 102, '2024-02-01'),
(3, 3, 103, '2024-03-10'),
(4, 1, 102, '2024-02-01'),
(5, 2, 103, '2024-03-10');

INSERT INTO grades (grade_id, enrollment_id, grade_value) 
VALUES
(1, 1, 3.5),
(2, 2, 4.0),
(3, 3, 3.7),
(4, 4, 3.8),
(5, 5, 4.0);


select c.course_department,avg(g.grade_value) as course_avg from enrollments e 
inner join student s on e.student_id=s.student_id
inner join courses c on e.course_id=c.course_id 
inner join grades g on e.enrollment_id=g.enrollment_id
group by course_department;






----------------------------------------------------------------------------------------

/* 5 E-commerce Analysis:
You have tables customers, orders, and products.
 
customers table: customer_id, customer_name, customer_country
orders table: order_id, customer_id, product_id, order_date, order_quantity
products table: product_id, product_name, product_price
Write a SQL query to find out the total revenue generated from customers in each country. */

create table cust(customer_id int primary key, customer_name varchar(15), customer_country varchar(15));

create table prod(product_id int primary key, product_name varchar(15), product_price int);

create table ord(
order_id int primary key, 
customer_id int foreign key references cust(customer_id), 
product_id int foreign key references prod(product_id), 
order_date date, 
order_quantity int);


insert into cust values(1,'a','hyd');
insert into cust values(2,'b','delhi');
insert into cust values(3,'c','mumbai');
insert into cust values(4,'d','hyd');
insert into cust values(5,'e','delhi');

insert into prod values(101,'choc',20);
insert into prod values(102,'book',100);
insert into prod values(103,'mobile',20000);
insert into prod values(104,'cloth',500);

insert into ord values(1001,1,101,'2024-05-01',5);
insert into ord values(1002,2,102,'2024-05-01',1);
insert into ord values(1003,3,103,'2024-05-01',3);
insert into ord values(1004,2,104,'2024-05-01',2);
insert into ord values(1005,5,102,'2024-05-01',4);
insert into ord values(1006,4,102,'2024-05-01',2);




select c.customer_country,sum(p.product_price*o.order_quantity) as Revenue from ord o inner join prod p on o.product_id=p.product_id
inner join cust c on o.customer_id=c.customer_id group by c.customer_country;