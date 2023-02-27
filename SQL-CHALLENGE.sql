-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles
--List the employee number, last name, first name, sex, and salary of each employee (2 points)
Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
join salaries as s on e.emp_no = s.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
select first_name, last_name, hire_date from employees
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31'

--List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
select m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM employees as e
join dept_manager as m on e.emp_no = m.emp_no
join departments as d on d.dept_no = m.dept_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
select e.emp_no, e.last_name, e.first_name, dt.dept_name
FROM employees as e
join dept_emp as d on e.emp_no = d.emp_no
join departments as dt on d.dept_no = dt.dept_no; 

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
select * 
FROM employees
WHERE first_name = 'Hercules' AND  last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT d.dept_name,  dt.emp_no, e.last_name, e.first_name
FROM departments as d
JOIN dept_emp as dt on d.dept_no = dt.dept_no
join employees as e on dt.emp_no = e.emp_no
WHERE d.dept_name = 'Sales'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT dt.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments as d
JOIN dept_emp as dt on d.dept_no = dt.dept_no
join employees as e on dt.emp_no = e.emp_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
select last_name, count(last_name) as "Frequency counts"
from employees
GROUP BY last_name


