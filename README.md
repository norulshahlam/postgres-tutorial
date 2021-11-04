# Postgres tutorial using Docker

## [Video Source](https://www.youtube.com/watch?v=5hzZtqCNQKk&t=4034s)
## [Postgres documentation - Datatypes](https://www.postgresql.org/docs/14/datatype.html)
## [Postgres documentation - Functions and operators](https://www.postgresql.org/docs/14/functions.html)
## [Postgres documentation - Aggregate functions](https://www.postgresql.org/docs/14/functions-aggregate.html)  

SQL file can be found here

### Run this

	docker run --name postgres-tutorial -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres

### Check if container is running & copy container id. Copy the container id.

	docker container ps

### Copy all your SQL file into your Docker environment

Make sure file is in current directory. 'bebbbff75bfd' is the container id. So make sure you copy your container id.

	docker cp person.sql bebbbff75bfd:/person.sql
	docker cp car.sql bebbbff75bfd:/car.sql
	docker cp car-person.sql bebbbff75bfd:/car-person.sql
	docker cp car-person-uuid.sql bebbbff75bfd:/car-person-uuid.sql

### Enter your container environment

	docker exec -it postgres-tutorial bash

### Help

	psql --help

### Connect to Postgres

	psql -U postgres

### Create new database

	create database test;

### Connect to database

	\c test;

### Create new table (or read from SQL file)

	create table person (
		id BIGSERIAL NOT NULL PRIMARY KEY,
		first_name VARCHAR(50) NOT NULL,
		last_name VARCHAR(50) NOT NULL,
		email VARCHAR(50),
		gender VARCHAR(50) NOT NULL,
		date_of_birth DATE NOT NULL,
		country_of_birth VARCHAR(50)
	);

### Read this sql file to create new tables and insert data

	\i person.sql;

	// Test if table and data is created and inserted
	select * from person;

### [Understanding table property](https://www.postgresql.org/docs/9.1/sql-createtable.html)         


`PRIMARY KEY`  
A constraint uniquely identifies each record in a table. Primary keys must contain UNIQUE values, and cannot contain NULL values. A table can have only ONE primary key; 

`FOREIGN KEY`
A constraint is used to prevent actions that would destroy links between tables. A FOREIGN KEY is a field (or collection of fields) in one table, that refers to the PRIMARY KEY in another table. The table with the foreign key is called the child table, and the table with the primary key is called the referenced or parent table.


	\d person;

### Queries  

	select * from person;
	select * from person limit 10;
	select * from person offset 5 limit 10;
	select * from person order by gender;
	select * from person order by country_of_birth desc;
	select distinct country_of_birth from person order by country_of_birth desc;
	select * from person where country_of_birth='Poland';
	select * from person where country_of_birth='Poland' OR country_of_birth='Australia';
	select * from person where country_of_birth in ('Poland', 'Australia');
	select * from person where date_of_birth between date '1900-01-01' and '1950-01-01';

### Wildcard

	// any matching on the left - case sensitive
	select * from person where email like '%@google.com';

	// any matching on the left - NOT case sensitive
	select * from person where email ilike '%@google.com';

	// any match from left and right
	select * from person where email like '%@google%';

	// any match with 14 char
	select * from person where email like '______________';

	// grouping
	select distinct country_of_birth, count(*) from person group by country_of_birth  order by country_of_birth desc;

	// using alias
	select distinct country_of_birth as "country", count(*) as "total" from person group by country_of_birth  order by country_of_birth desc;

	// further filter
	select distinct country_of_birth, count(*) from person group by country_of_birth having count(*)>50  order by country_of_birth desc;

### Create new table (or read from SQL file)

	create table car (
		id BIGINT NOT NULL PRIMARY KEY,
		make VARCHAR(50)NOT NULL,
		model VARCHAR(50)NOT NULL,
		price INT NOT NULL
	);

### Read this sql file to create new tables and insert data

	\i car.sql

### Queries

`Aggregation`

	select max(price) from car;
	select min(price) from car;
	select avg(price) from car;
	select round(20.356363);
	select round(avg(price),1) from car;
	
	// minprice of a car grouped by make and model
	select make, model, min(price) from car group by make, model order by make;

	// minprice of a car grouped by model
	select make, min(price) from car group by make order by make;

	// total price of each make
	select make, sum(price) from car group by make;

	// normal price
	select make, model, price from car;

	// discounted price
	select make, model, price, round(price* .10,2) from car;

	// after disconted price 
	select make, model, price, round(price* .10,1), round(price*.9,1) from car;

`Coalesce`

	// some dont have email so it will show blank
	select email from person;

	// we can replace this blank with our custom data
	select coalesce(email,'NO EMAIL') from person;

`DATE TIME`

	select now();

	// show date only
	select now()::date;

	// show time only
	select now()::time;
	select now() - interval '1 year';
	select now() - interval '1 month';
	select now() + interval '1 month';
	select now()::time + interval '1 month';

	// show date only
	select (now() + interval '1 month')::date;

	// extract value from date
	select extract(year from now());
	select extract(week from now());
	select extract(month from now());
	select extract(dow from now());
	select extract(century from now());

	//AGE
	select age(now(), '1985-12-20');
	select extract(year from(select age(now(), '1985-12-20')));
	select first_name, date_of_birth from person;
	select first_name, date_of_birth, age(now(), date_of_birth) from person;

	// extract only age from results
	select first_name, date_of_birth, extract(year from(age(now(), date_of_birth))) from person;


## RELATIONAL TABLE  

### Drop this 2 existing tables as we will be using another version of this 2 tables in car-person.sql
	
	drop table car;
	drop table person;
	// check if tables are deleted
	\d

### Create new table (or read from SQL file)

	create table car (
		id BIGSERIAL NOT NULL PRIMARY KEY,
		make VARCHAR(50)NOT NULL,
		model VARCHAR(50)NOT NULL,
		price INT NOT NULL
	);

	create table person (
		id BIGSERIAL NOT NULL PRIMARY KEY,
		first_name VARCHAR(50) NOT NULL,
		last_name VARCHAR(50) NOT NULL,
		gender VARCHAR(50) NOT NULL,
		email VARCHAR(50),
		date_of_birth DATE NOT NULL,
		country_of_birth VARCHAR(50),
		car_id BIGINT REFERENCES car(id),
		UNIQUE(car_id)
	);


### Read this sql file to create new tables and insert data

	\i car-person.sql

	// test
	\d
	select * from person;
	select * from car;


### Queries  

`Inner joins` - Return only matching rows

	select * from person join car on person.car_id=car.id;
	select person.first_name, car.make,car.model, car.price from person join car on person.car_id=car.id;

`Left joins` - Return all rows from the left (Person table) that matches on the right

	select * from person left join car on person.car_id=car.id;
	select person.id, person.first_name, car.make,car.model, car.price from person left join car on person.car_id=car.id;

### Extensions

PostgreSQL Extensions are a plug and play set of enhancements that add an extra feature-set to a PostgreSQL cluster. Some of these features are as simple as reading or writing to an external database while others could be a sophisticated solution to implement database replication, monitoring, etc

	// View all extensions
	select * from pg_available_extensions;

	// Install UUID extension
	create extension if not exists "uuid-ossp";

	// View functions
	\df

	// Call function - This will return unique id
	select uuid_generate_v4();


### Drop this 2 exisiting tables as we will be using another version of this 2 tables in car-person-uuid.sql

	drop table person;
	drop table car;

	// test
	\d

### Read this sql file to create new tables and insert data

	\i car-person-uuid.sql

	// test
	\d
	select * from person;
	select * from car;


### Test if table is created and data inserted

	select * from car;
	select * from person;

Now we assign 2 cars to 2 person

	update person set car_uid = 'b571d6b0-ac1c-46cd-b717-a46f0186990d' where person_uid='27a9e026-9662-4b4f-8073-8cac0abda62e';
	update person set car_uid = 'b571d6b0-ac1c-46cd-b717-a46f0186990d' where person_uid='27a9e026-9662-4b4f-8073-8cac0abda62e';

### Queries

	// check
	select * from car;
	select * from person;

	// inner join
	select * from person join car on person.car_uid=car.car_uid;

	// since the comparison name is same, we canuse shortcut query:
	select * from person join car using (car_uid);

	// left join
	select * from person left join car on person.car_uid=car.car_uid;

	// save query results as csv
	\copy (select * from person left join car on person.car_uid=car.car_uid) to '/query-results.csv' delimiter ',' csv header; 

	// check if file is created in your target directory


# THE END

