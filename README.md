# HR_Analytics

## Task 1: Project Understanding

**Project Overview**

Data Source: HR data containing over 22,000 rows from the years 2000 to 2020.

[Data](https://github.com/bandhavi1/HR_-Analytics/blob/main/Human%20Resources.csv)

**Data Cleaning & Analysis**
Tool: MySQL Workbench

**Data Visualization**
Tool: PowerBI

**Key Questions Addressed**

Gender Breakdown: What is the gender breakdown of employees?
Race/Ethnicity Breakdown: What is the race/ethnicity breakdown of employees?
Age Distribution: What is the age distribution of employees?
Location Distribution: How many employees work at headquarters versus remote locations?
Average Length of Employment: What is the average length of employment for terminated employees?
Gender Distribution by Department/Job Title: How does gender distribution vary across departments and job titles?
Job Title Distribution: What is the distribution of job titles across the company?
Department Turnover Rates: Which department has the highest turnover rate?
Location Distribution by State: What is the distribution of employees across locations by state?
Employee Count Change Over Time: How has the employee count changed over time based on hire and termination dates?
Tenure Distribution by Department: What is the tenure distribution for each department?


## Task 2: Data Preparation

**Data Cleaning: Steps taken to clean the data:**

Standardized Date Formats: Converted all date fields to the YYYY-MM-DD format.
Remove Negative Ages: Excluded 967 records with negative ages.
Exclude Future Termination Dates: Excluded 1,599 records with termination dates far in the future; only current dates used.
Resulting Clean Data Sets.



## Task 3: Data Analysis

**Summary of Findings**

I have included the SQL file that contains the data cleaning and analysis steps. 
[SQL](https://github.com/bandhavi1/HR_-Analytics/blob/main/Data%20Cleaning%20and%20Analysis.sql)

Gender Breakdown: More male employees.
Race/Ethnicity: Predominantly White, with Native Hawaiian and American Indian being the least represented.
Age Distribution: Employees range from 20 to 57 years old, with most between 25-34 years.
Location: Majority work at headquarters.
Length of Employment: Average is around 7 years for terminated employees.
Gender Distribution by Department: Generally more males; balanced gender distribution across departments.
Turnover Rates: Highest in Marketing, followed by Training; lowest in Research and Development, Support, and Legal.
State Distribution: Most employees are from Ohio.
Employee Count Change: Increase in net employee count over the years.
Tenure Distribution: Average tenure is about 8 years; highest in Legal and Auditing, lowest in Services, Sales, and Marketing.

## Task 4: Data Visualization

**PowerBI Visualization**
[Dashboard](https://github.com/bandhavi1/HR_-Analytics/blob/main/HR_Analytics.pbix)
[PDF](https://github.com/bandhavi1/HR_-Analytics/blob/main/HR_Analytics.pdf)

Developed a PowerBI Dashboard to provide stakeholders with enhanced understanding and deeper insights.
