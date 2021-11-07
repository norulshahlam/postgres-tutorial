create table employee (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	salary INT,
	manager_id INT
);
insert into employee (id,name,salary,manager_id) values (1,'joe',70,3);
insert into employee (id,name,salary,manager_id) values (2,'henry',80,4);
insert into employee (id,name,salary,manager_id) values (3,'sam',60,null);
insert into employee (id,name,salary,manager_id) values (4,'max',90,null);
-- Write an SQL query to find the employees who earn more than their managers.