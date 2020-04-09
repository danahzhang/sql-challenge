-- CREATE titles Table
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
	titles_id SERIAL   NOT NULL,
    emp_no int   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_titles_id PRIMARY KEY (
        titles_id
     )
);

DROP TABLE IF EXISTS salary;
CREATE TABLE salary (
    salary_id SERIAL   NOT NULL,
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_salary PRIMARY KEY (
        salary_id
     )
);
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    emp_no int   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender CHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (
        emp_no
     )
);
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
    dept_man_id SERIAL   NOT NULL,
	dept_no VARCHAR   NOT NULL,
    emp_no int   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        dept_man_id
     )
);
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
    dept_emp_id SERIAL   NOT NULL,
    emp_no int   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        dept_emp_id
     )
);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employee (emp_no);

ALTER TABLE salary ADD CONSTRAINT fk_salary_emp_no FOREIGN KEY(emp_no)
REFERENCES employee (emp_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employee (emp_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employee (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

--COPIED CSV FILES THROUGH TABLES TAB
--First Import Department and Employee

Select * From departments;
Select * From dept_emp;
Select * From dept_manager;
Select * From employee;
Select * From salary;
Select * From titles;

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employee.emp_no, employee.first_name, employee.last_name, employee.gender, salary.salary 
FROM employee INNER JOIN salary ON employee.emp_no=salary.emp_no;


--2. List employees who were hired in 1986.
Select employee.emp_no, employee.first_name, employee.last_name FROM employee WHERE hire_date between '1986-01-01' and '1986-12-31';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT departments.dept_no, departments.dept_name, employee.first_name, employee.last_name, dept_manager.from_date, dept_manager.to_date 
FROM dept_manager INNER JOIN departments ON departments.dept_no=dept_manager.dept_no
INNER JOIN employee ON dept_manager.emp_no=employee.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT departments.dept_name, employee.emp_no, employee.first_name, employee.last_name 
FROM dept_emp INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
INNER JOIN employee ON dept_emp.emp_no=employee.emp_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT employee.first_name, employee.last_name 
FROM employee WHERE first_name = 'Hercules' and last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT departments.dept_name, employee.emp_no, employee.first_name, employee.last_name 
FROM dept_emp INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
INNER JOIN employee ON dept_emp.emp_no=employee.emp_no
WHERE departments.dept_name='Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT departments.dept_name, employee.emp_no, employee.first_name, employee.last_name 
FROM dept_emp INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
INNER JOIN employee ON dept_emp.emp_no=employee.emp_no
WHERE departments.dept_name='Sales' OR departments.dept_name='Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT COUNT(employee.last_name), employee.last_name
FROM employee 
GROUP BY employee.last_name 
ORDER BY COUNT (employee.last_name) DESC;