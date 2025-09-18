-- queries.sql
USE salary_management;

-- 1. Department-wise average salary (for latest month)
SELECT d.name AS department,
       ROUND(AVG(s.net_pay),2) AS avg_net_pay
FROM departments d
JOIN employees e ON e.department_id = d.dept_id
JOIN salaries s ON s.emp_id = e.emp_id
WHERE (s.year, s.month) = (2025,7)
GROUP BY d.name
ORDER BY avg_net_pay DESC;

-- 2. Top 5 highest paid employees this month (net pay)
SELECT e.emp_id, CONCAT(e.first_name,' ',e.last_name) AS employee, r.title, s.net_pay
FROM salaries s
JOIN employees e ON e.emp_id = s.emp_id
JOIN roles r ON r.role_id = e.role_id
WHERE (s.year, s.month) = (2025,7)
ORDER BY s.net_pay DESC
LIMIT 5;

-- 3. Employees with more than 3 absences this month
SELECT e.emp_id, CONCAT(e.first_name,' ',e.last_name) AS employee, COUNT(*) AS absences
FROM attendance a
JOIN employees e ON e.emp_id = a.emp_id
WHERE a.status='A' AND YEAR(a.att_date)=2025 AND MONTH(a.att_date)=7
GROUP BY e.emp_id
HAVING absences > 3;

-- 4. Pay gap by gender (average net pay)
SELECT e.gender, ROUND(AVG(s.net_pay),2) AS avg_net
FROM employees e
JOIN salaries s ON s.emp_id = e.emp_id
WHERE (s.year, s.month) = (2025,7)
GROUP BY e.gender;

-- 5. Running yearly bonus summary (window function)
SELECT emp_id, sum(amount) OVER (PARTITION BY emp_id) AS total_bonus
FROM bonuses;

-- 6. Find employees eligible for promotion (simple heuristic: >3 years, role level L1 or L2)
SELECT e.emp_id, CONCAT(e.first_name,' ',e.last_name) AS employee, e.joining_date,
DATEDIFF(CURDATE(), e.joining_date)/365 AS years_served, r.title, r.level
FROM employees e
JOIN roles r ON r.role_id = e.role_id
WHERE DATEDIFF(CURDATE(), e.joining_date)/365 >= 3 AND r.level IN ('L1','L2');

-- 7. Detect salary anomalies: monthly net_pay change > 50% vs previous month
SELECT s.emp_id, CONCAT(e.first_name,' ',e.last_name) AS employee, s.year, s.month, s.net_pay,
       LAG(s.net_pay) OVER (PARTITION BY s.emp_id ORDER BY s.year, s.month) AS prev_net,
       CASE WHEN LAG(s.net_pay) OVER (PARTITION BY s.emp_id ORDER BY s.year, s.month) IS NOT NULL
            THEN ROUND((s.net_pay - LAG(s.net_pay) OVER (PARTITION BY s.emp_id ORDER BY s.year, s.month)) / LAG(s.net_pay) OVER (PARTITION BY s.emp_id ORDER BY s.year, s.month) * 100,2)
            ELSE NULL END AS pct_change
FROM salaries s
JOIN employees e ON e.emp_id = s.emp_id
HAVING pct_change IS NOT NULL AND ABS(pct_change) > 50;
