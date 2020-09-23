--Import csv on tables--
COPY titles  FROM '/tmp/titles.csv'  DELIMITER ',' CSV HEADER;
COPY employees FROM '/tmp/employees.csv' DELIMITER ',' CSV HEADER;
COPY deparments FROM '/tmp/departments.csv' DELIMITER ',' CSV HEADER;
COPY manager FROM '/tmp/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY dep_emp FROM '/tmp/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM '/tmp/salaries.csv' DELIMITER ',' CSV HEADER;

--1.-List the following details of each employee: employee number, last name, first name, sex, and salary.--
CREATE VIEW analysis1 AS
SELECT employees.emp_no, 
	employees.first_name, 
	employees.last_name, 
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries on emp_no=emp_id_s;
--2.-List first name, last name, and hire date for employees who were hired in 1986.--
--*First we need to convert birh_date and hire_date into DATE format--
ALTER TABLE employees
ALTER COLUMN birth_date TYPE DATE USING(to_date(employees.birth_date,'mm/dd/yyyy'));
ALTER TABLE employees
ALTER COLUMN hire_date TYPE DATE USING(to_date(employees.hire_date,'mm/dd/yyyy'));

--*Then we filter employees hired in 1986--
CREATE VIEW analysis2 AS
SELECT employees.first_name,
       employees.last_name,
	   employees.hire_date
FROM employees	   
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';
SELECT * FROM analysis2;

--3.-List the manager of each department with the following information: 
--department number, department name, the manager’s employee number, last name, first name.
--*First we make the inner join between Manager and departmets tables
CREATE VIEW analysis3 AS
SELECT manager.dept_no_m,
       manager.emp_id_m,
	   deparments.dept_name
FROM manager 
INNER JOIN deparments ON manager.dept_no_m = deparments.dept_no;
--*The we make the inner join between employees and previous analysis
CREATE VIEW analysis4 AS
SELECT analysis3.dept_no_m,
       analysis3.emp_id_m,
	   analysis3.dept_name,
	   employees.first_name,
	   employees.last_name
FROM analysis3
INNER JOIN employees ON analysis3.emp_id_m = employees.emp_no;	
SELECT * FROM analysis4;

--4.-List the department of each employee with the following information: employee number, last name, first name, and department name.
--*The same process followed for the previous instrution is used here--
CREATE VIEW analysis5 AS
SELECT dep_emp.emp_id_d,
       dep_emp.dept_no_e,
	   deparments.dept_name
FROM  dep_emp
INNER JOIN deparments ON dep_emp.dept_no_e = deparments.dept_no;
CREATE VIEW analysis6 AS
SELECT analysis5.emp_id_d,
       analysis5.dept_no_e,
	   analysis5.dept_name,
	   employees.first_name,
	   employees.last_name
FROM  analysis5
INNER JOIN employees ON analysis5.emp_id_d = employees.emp_no;
SELECT * FROM analysis6;

--5.-List first name, last name, and sex for employees whose first name is “Hercules” and last names begin with “B.”
CREATE VIEW analysis7 AS
SELECT employees.first_name,
       employees.last_name,
	   employees.sex
FROM employees	   
WHERE first_name = 'Hercules' and last_name LIKE 'B%';
SELECT * FROM analysis7;

--6.-List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW analysis8 AS
SELECT analysis6.emp_id_d,
       analysis6.last_name,
	   analysis6.first_name,
	   analysis6.dept_name
FROM analysis6
WHERE dept_name = 'Sales';
SELECT * FROM analysis8;

--7.-List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW analysis9 AS
SELECT analysis6.emp_id_d,
       analysis6.last_name,
	   analysis6.first_name,
	   analysis6.dept_name
FROM analysis6
WHERE dept_name = 'Sales' or dept_name ='Development';
SELECT * FROM analysis9;

--8.-In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE VIEW analysis10 AS
SELECT
	last_name,
	COUNT (last_name)
FROM
	employees
GROUP BY
	last_name
ORDER BY count DESC;
SELECT * FROM analysis10;



