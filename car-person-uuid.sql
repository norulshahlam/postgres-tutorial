create table car (
	car_uid UUID NOT NULL PRIMARY KEY,
	make VARCHAR(50)NOT NULL,
	model VARCHAR(50)NOT NULL,
	price INT NOT NULL
);

create table person (
	person_uid UUID NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50),
    car_uid UUID REFERENCES car(car_uid),
    UNIQUE(car_uid)
);


insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'Lamborghini', 'Diablo', 74879);
insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'Saab', '9000', 99259);
insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'Kia', 'Optima', 49353);
insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'Saab', '9-3', 70327);
insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'Pontiac', 'Grand Prix', 42531);



insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Halsey', '1938-08-12', 'Greece');
insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Judith',  '1958-06-13', 'Brazil');
insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Hilliary', '1920-08-25', 'Macedonia');
insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Noelyn', '1930-09-02', 'Croatia');
insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Winnie', '1914-01-05', 'China');
insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Penrod', '1981-03-08', 'Japan');
insert into person (person_uid, first_name, date_of_birth, country_of_birth) values (uuid_generate_v4(), 'Rochella', '1917-05-07', 'China');
