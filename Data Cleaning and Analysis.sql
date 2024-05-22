CREATE DATABASE HRAnalytics;

USE HRAnalytics;


ALTER TABLE hr
CHANGE COLUMN empId emp_id VARCHAR(20) NULL;

SELECT * FROM hr;

SET SQL_SAFE_UPDATES = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


UPDATE hr
SET termdate = NULL
WHERE termdate IS NULL OR termdate = '' OR STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC') IS NULL;

UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '' AND STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC') IS NOT NULL;

  
ALTER TABLE hr
MODIFY COLUMN termdate DATE;


ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT min(age) AS youngest,
       max(age) AS Eldest
FROM hr;

SELECT count(*) FROM hr where age<18;

-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?

SELECT SUM(gender = 'Male') AS male_count,
	   SUM(gender = 'Female') AS Female_count
FROM hr ;

SELECT gender,count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY gender;
 

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT DISTINCT race FROM hr;

SELECT race,count(*)
FROM hr
WHERE AGE>=18 AND termdate IS NULL
GROUP BY race;
 

-- 3. What is the age distribution of employees in the company?
SELECT 
   CASE 
     WHEN age>=18 and age<=24 THEN '18-24'
     WHEN age>=25 and age<=34 THEN '25-34'
     WHEN age>=35 and age<=44 THEN '35-44'
     WHEN age>=45 and age<=54 THEN '45-54'
     WHEN age>=55 and age<=64 THEN '55-64'
   ELSE '65+'
END AS age_group, count(*) as count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;
     
-- 4. How many employees work at headquarters versus remote locations?

SELECT * FROM hr;
SELECT location,count(*)
FROM hr
WHERE AGE>=18 AND termdate IS NULL
GROUP BY location;


-- 5. What is the average length of employment for employees who have been terminated?

SELECT round(avg(datediff(termdate,hire_date))/365,0) AS avg_length_employement
FROM hr
WHERE age>=18 AND termdate IS NOT NULL AND termdate <=curdate() ;


-- 6. How does the gender distribution vary across departments and job titles?
SELECT * FROM hr;

SELECT department, gender,count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY department,gender
ORDER BY department;


-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle;



-- 8. Which department has the highest turnover rate?
-- The rate at which employees leave the company?

SELECT department,
	   total_count,
       termination_count,
       termination_count/total_count AS turnover_rate
FROM (
   SELECT department, 
   count(*) AS total_count,
   SUM(CASE WHEN termdate IS NOT NULL AND termdate <=curdate() THEN 1 ELSE 0 END) AS termination_count
   FROM hr
   WHERE age>=18 
   GROUP BY department) AS subquery
ORDER BY turnover_rate DESC;
   

-- 9. What is the distribution of employees across locations by city and state?


SELECT location_state, count(*) AS location_count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY location_state
ORDER BY location_count DESC;



-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT * FROM hr;

select year,
       hires,
       terminations,
       hires-terminations AS net_change,
       round((hires-terminations)/hires * 100,2) net_change_percent
FROM( select 
        year(hire_date) AS year,
        count(*) AS hires,
        SUM( CASE WHEN termdate IS NOT NULL AND termdate<= curdate() THEN 1 ELSE 0 END) AS terminations
        FROM hr
        WHERE age>=18
        GROUP BY year
        ) AS subquery
ORDER BY year ASC;



-- 11. What is the tenure distribution for each department?
-- How many years in average did people stay in one department

select department,
	   average_years
from (select department,
             round(AVG(datediff(termdate, hire_date)/365),0)AS average_years
             
	  FROM hr
      WHERE AGE>=18 AND termdate IS NOT NULL AND termdate<= curdate()
      GROUP BY department
      ) AS subquery
ORDER BY average_years DESC;
      




