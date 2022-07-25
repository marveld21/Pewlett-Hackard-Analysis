-- create retirement_titles table (retirement age employees)
DROP TABLE IF EXISTS retirement_titles;
SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
LEFT JOIN titles ON employees.emp_no = titles.emp_no
where birth_date >= '1952-01-01' and birth_date < '1955-01-01'
;

select * from retirement_titles;

--create unique_titles table (current unique employees)
DROP TABLE IF EXISTS unique_titles;
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name,
title, from_date, to_date
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC;

select * from unique_titles;

--create retiring_titles table (count of retiring titles)
select count(title) as count_of_title, title from unique_titles
group by title
order by count_of_title DESC ;

--create mentorship_eligibility table
drop table if exists mentorship_eligibility;
select distinct on (employees.emp_no) 
employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, 
dept_emp.from_date, dept_emp.to_date,
titles.title
into mentorship_eligibility
from employees
left join dept_emp on employees.emp_no = dept_emp.emp_no 
left join titles on employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' and birth_date >= '1965-01-01' and birth_date <= '1965-12-31'
order by emp_no
;

select * from mentorship_eligibility;

