-- Retiring Employees by tile - - Steps 1 through 7
SELECT em.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees em
INNER JOIN titles ti ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no


-- Use Dictinct with Orderby to remove duplicate rows Steps 8 to 15
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles rt
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retiring Titles - Deliverable 1 
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC

-- DELIVERABLE 2

SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name,em.birth_date, dm.from_date, dm.to_date, ti.title
INTO mentorship_eligibilty
FROM employees em
JOIN dept_emp dm on em.emp_no = dm.emp_no
JOIN titles ti on ti.emp_no = em.emp_no
WHERE dm.to_date = '9999-01-01'
AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY em.emp_no 


-- SELECT count(title), title
-- FROM mentorship_eligibilty
-- group by title
