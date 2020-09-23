--Inspect the information and and sketch out an ERD of the tables--
Titles
-
emp_title_id INT PK FK - Employees.emp_title_id
title VARCHAR
Salaries
-
emp_id_s INTEGER FK - Employees.emp_no
salary INTEGER
Manager
-
dept_no_m INTEGER FK - Departments.dept_no
emp_id_m INTEGER FK - Employees.emp_no
Employees
-
emp_no INTEGER PK
emp_title_id INTEGER
bith_date DATE
first_name VARCHAR
last_name VARCHAR
sex VARCHAR
hire_date DATE
Departments
-
dept_no INTEGER PK
dept_name VARCHAR
Dep_emp
-
emp_id_d INTEGER FK - Employees.emp_no
dept_no_e INTEGER FK - Departments.dept_no

--Create tables to import csv--

CREATE TABLE titles (
		emp_title_id VARCHAR unique,
		title VARCHAR,
		PRIMARY KEY (emp_title_id)
);
CREATE TABLE deparments (
              dept_no VARCHAR unique,
              dept_name VARCHAR,
              PRIMARY KEY (dept_no)
);
CREATE TABLE employees (
              emp_no Int unique,
              emp_title_id VARCHAR REFERENCES titles(emp_title_id),
              birth_date VARCHAR,
              first_name VARCHAR,
              last_name VARCHAR,
              sex VARCHAR,
              hire_date VARCHAR,
              PRIMARY KEY(emp_no)
              );
CREATE TABLE dep_emp (
              emp_id_d INT REFERENCES employees(emp_no) ,
              dept_no_e VARCHAR REFERENCES deparments(dept_no)
);
CREATE TABLE salaries (
              emp_id_s INT REFERENCES employees(emp_no),
              salary INT
);
CREATE TABLE manager (
              dept_no_m VARCHAR REFERENCES deparments(dept_no),
              emp_id_m INT REFERENCES employees(emp_no)            
);






