-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.
-- The hire_date had to be cast as a date to compare the date for current active employees

CREATE VIEW emp_hired_year AS
  SELECT emp_no, last_name, first_name, hire_date, 
         EXTRACT(YEAR FROM employees.hire_date) AS hired_year
  FROM employees;

SELECT emp_no, last_name, first_name, hire_date
FROM emp_hired_year
WHERE hired_year = 1986;

DROP VIEW emp_hired_year;

-- 3. List the manager of each department with the following information: department number, department name, 
--    the manager's employee number, last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, 
       e.first_name, dm.from_date, dm.to_date
FROM departments AS d
INNER JOIN  dept_manager AS dm ON
d.dept_no = dm.dept_no
INNER JOIN employees AS e ON
dm.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: employee number, 
--    last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
INNER JOIN employees AS e ON 
e.emp_no = de.emp_no
INNER JOIN departments AS d ON
d.dept_no = de.dept_no
WHERE de.to_date::date = '9999-01-01'
ORDER BY e.emp_no

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT emp_no, last_name, first_name 
FROM employees
WHERE first_name = 'Hercules' AND
last_name LIKE 'B%'

-- 6. List all employees in the Sales department, including their employee number, 
--    last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
INNER JOIN employees AS e ON
de.emp_no = e.emp_no
INNER JOIN departments AS d ON 
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'

-- 7. List all employees in the Sales and Development departments, including their 
--    employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
INNER JOIN employees AS e ON
de.emp_no = e.emp_no
INNER JOIN departments AS d ON
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR
d.dept_name = 'Development'

--8. In descending order, list the frequency count of employee last names, 
--   i.e., how many employees share each last name.

SELECT last_name, count(last_name) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC;
