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


insert into car (id, make, model, price) values (1, 'Lamborghini', 'Diablo', 74879);
insert into car (id, make, model, price) values (2, 'Saab', '9000', 99259);
insert into car (id, make, model, price) values (3, 'Kia', 'Optima', 49353);
insert into car (id, make, model, price) values (4, 'Saab', '9-3', 70327);
insert into car (id, make, model, price) values (5, 'Pontiac', 'Grand Prix', 42531);



insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth, car_id) values ('Halsey', 'Kondratowicz', null, 'Female', '1938-08-12', 'Greece',1);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth, car_id) values ('Judith', 'Brogini', 'jbrogini1@taobao.com', 'Non-binary', '1958-06-13', 'Brazil',2);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth, car_id) values ('Hilliary', 'Rydeard', null, 'Agender', '1920-08-25', 'Macedonia',3);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth, car_id) values ('Noelyn', 'Howood', null, 'Genderfluid', '1930-09-02', 'Croatia',4);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth, car_id) values ('Winnie', 'Gioan', null, 'Agender', '1914-01-05', 'China',5);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth,car_id) values ('Penrod', 'Clynter', 'pclynter5@rambler.ru', 'Female', '1981-03-08', 'Japan',null);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth,car_id) values ('Rochella', 'Cordall', 'rcordall6@oakley.com', 'Genderfluid', '1917-05-07', 'China',null);
