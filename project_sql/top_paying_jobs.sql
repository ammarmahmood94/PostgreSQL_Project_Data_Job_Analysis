/* 
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest paying data analyst jobs that are available remotely.
- Focuses on job postings with specified salaries (removes nulls).
- Why? Highlight the top-paying opportunities for data analysts, offering insights into employment opportunities.   
*/

SELECT
    jpf.job_id,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim ON jpf.company_id = company_dim.company_id
WHERE
    job_title = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
