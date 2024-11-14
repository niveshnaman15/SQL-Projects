
-- Employee Management
-- Total salary expense per department
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- Average salary by job title
SELECT job_title, AVG(salary) AS avg_salary
FROM employees
GROUP BY job_title;

-- Departments with the longest-serving employees
SELECT department_id, employee_id, hire_date
FROM employees
ORDER BY hire_date ASC;
