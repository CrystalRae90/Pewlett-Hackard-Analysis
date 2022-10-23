# Pewlett-Hackard-Analysis

## Overview of the Analysis 
The purpose of this analysis was to be able to deliver concise data to HP Team regarding retirement by title as well mentorship elegibility. This was to be achieved by merging and looking at mutiple datasets. 

## Results
Using sql, we are able to perform an analysis for HP for two major categories 1.) Number of Retiring Employees Per title and 2.) Employees that are eligibile for the mentorship program 

 -- As the titles of the employees and the employee data was listed in two seperate tables, we first had to merge the tables to grab one cohesive list. Once merged we are able to filter to the approprriate retirement dates and sort appropriately. 

        SELECT em.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
        INTO retirement_titles
        FROM employees em
        INNER JOIN titles ti ON em.emp_no = ti.emp_no
        WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
        ORDER BY em.emp_no

-- As the previous list shows all titles each person held, it was needed to then be to show their current titles. Using the previous data, we filtered by all current titles and ensureded that each employee only had one distinct row. 

        SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
        INTO unique_titles
        FROM retirement_titles rt
        WHERE to_date = '9999-01-01'
        ORDER BY emp_no, to_date DESC;

-- Last step was to provide a cohesive list by job title of how many retiring employees they had. Using the previous table (unique titles), we are able to count the titles listed and group them by the title itself.  This provided a list of the titles pertaining to retiring employees and the corresponding count. 

        SELECT COUNT(title), title
        INTO retiring_titles
        FROM unique_titles
        GROUP BY title
        ORDER BY count(title) DESC

-- To determine those eligible for the mentorship prgram, we needed to merge three tables: employees, dept_em, and titles. The common column in each was the employee number. Using both their current job, as determined by the to_date or "9999-01-01" and their DOB in the year 1965, a list was able to be generated. 

        SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name,em.birth_date, dm.from_date, dm.to_date, ti.title
        INTO mentorship_eligibilty
        FROM employees em
        JOIN dept_emp dm on em.emp_no = dm.emp_no
        JOIN titles ti on ti.emp_no = em.emp_no
        WHERE dm.to_date = '9999-01-01'
        AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
        ORDER BY em.emp_no 



## Summary 

-- How many roles will need to be filled as the "silver tsunami" begins to make an impact?

There are 7 major roles that will need to filled. This relates to over seventy thousand employees (72458).

![Unique_Titles](unique_titles.png)

-- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

Looking solely at the sheer volume of retirement-ready employees, one would say yes, but you would need more details in order to come to a better consensus. 

-- Additional Queries 

One additional query would be to compare job titles/roles of the retirement ready employees with those eligible to for the mentorship programs. Are there enough of each role to be able to provide adequate mentorship. 

Another query would be to expand further than only those born in 1965. Would it be help to start expanding further to see how future mentorship could be planned. 