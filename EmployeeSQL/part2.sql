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