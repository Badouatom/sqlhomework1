DROP TABLE IF EXISTS dept_emp ;
DROP TABLE IF EXISTS dept_manager ;
DROP TABLE IF EXISTS salaries ;
DROP TABLE IF EXISTS titles ;
DROP TABLE IF EXISTS departments ;
DROP TABLE IF EXISTS employees ;
CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    birth_date date   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hired_date date   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

	
	CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL

);

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary money   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE titles (
    emp_no INT   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

----- WE START THE HOME WORK QUERIES-------
------ List the following details of each employees: employee number , last name , first name gender and salary-----
 SELECT employees.emp_no AS "employees number", employees.last_name AS"last name", employees.first_name AS "first name" 
 ,employees.gender AS " gender", salaries.salary 
 FROM employees
 INNER JOIN salaries ON
 employees.emp_no=salaries.emp_no;
 
 ---- employees hired in 1986----
 SELECT * FROM employees 
 WHERE  to_char(hired_date,'yyyy')='1986';
 /* this following query ,list List the manager of each department with the following information:
 department number, department name, the manager's employee number, last name, first name,
 and start and end employment dates.*/
 
 SELECT departments.dept_no AS "department number", departments.dept_name AS " departments name",employees.emp_no AS " manager employee number",
 employees.first_name AS" manager first name", employees.last_name AS "manager last name", dept_manager.from_date AS "manager employement start date", dept_manager.to_date AS " manager employement end  date"
 FROM departments
  JOIN  dept_manager ON 
  departments.dept_no=dept_manager.dept_no
  JOIN employees ON 
  employees.emp_no=dept_manager.emp_no;
  /* this next query is about to List the department of each employee with the following information: employee number, 
  last name, first name, and department name.*/
  
 SELECT  dept_emp.emp_no AS "employees number" ,employees.last_name AS "employees last name", employees.first_name "employees last name",
 departments.dept_name AS "employees name"
 FROM dept_emp  
INNER JOIN employees ON
dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
ORDER BY "employees number" ASC
;
-----List all employees whose first name is "Hercules" and last names begin with "B."------
SELECT * FROM employees
WHERE first_name = 'Hercules' AND
	  last_name LIKE 'B%';

-----List all employees in the Sales department, including their employee number, last name, first name, and department name.-----
SELECT dept_emp.emp_no  AS "employees number", employees.last_name AS "employees last name ", employees.first_name AS "employees first name",
departments.dept_name AS "employees departments name"
FROM dept_emp
LEFT OUTER JOIN employees ON
 dept_emp.emp_no=employees.emp_no
 LEFT OUTER JOIN departments ON
 dept_emp.dept_no=departments.dept_no
 WHERE dept_name IN ('Sales');
 
 -------
/*ist all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.*/
 
 SELECT dept_emp.emp_no  AS "employees number", employees.last_name AS "employees last name ", employees.first_name AS "employees first name",
departments.dept_name AS "employees departments name"
FROM dept_emp
LEFT OUTER JOIN employees ON
 dept_emp.emp_no=employees.emp_no
 LEFT OUTER JOIN departments ON
 dept_emp.dept_no=departments.dept_no
 WHERE dept_name IN ('Sales','Development');
 
 -----In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.------
 
 
SELECT last_name,
COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;