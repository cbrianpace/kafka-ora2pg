CREATE DATABASE hr;

\c hr

DROP TABLE IF EXISTS employees;

CREATE TABLE employees 
   (employee_id   BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, 
	first_name     VARCHAR(20), 
	last_name      VARCHAR(25), 
	email          VARCHAR(25), 
	phone_number   VARCHAR(20), 
	hire_date      DATE, 
	job_id         VARCHAR(10), 
	salary         NUMERIC(8,2), 
	commission_pct NUMERIC(2,2), 
	manager_id     NUMERIC(6,0), 
	department_id  NUMERIC(4,0)
   );

ALTER TABLE employees ADD CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id);

CREATE INDEX emp_department_ix ON employees (department_id) ;

DROP TABLE IF EXISTS departments;

CREATE TABLE departments 
   (department_id  BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, 
	department_name VARCHAR(30), 
	manager_id      NUMERIC(6,0), 
	location_id     NUMERIC(4,0) 
   );

ALTER TABLE departments ADD CONSTRAINT dept_id_pk PRIMARY KEY (department_id);

CREATE INDEX dept_location_ix ON departments (location_id) ;


DROP TABLE IF EXISTS jobs;

CREATE TABLE jobs 
   (job_id    VARCHAR(10), 
	job_title  VARCHAR(35), 
	min_salary NUMERIC(6,0), 
	max_salary NUMERIC(6,0)
   );

ALTER TABLE jobs ADD CONSTRAINT job_id_pk PRIMARY KEY (job_id);

DROP TABLE IF EXISTS locations;

CREATE TABLE locations 
   (location_id   BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, 
	street_address VARCHAR(40) , 
	postal_code    VARCHAR(12) , 
	city           VARCHAR(30), 
	state_province VARCHAR(25) , 
	country_id     CHAR(2) 
   );

ALTER TABLE locations ADD CONSTRAINT loc_id_pk PRIMARY KEY (location_id);

