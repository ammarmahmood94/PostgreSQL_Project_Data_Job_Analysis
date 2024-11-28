# Introduction

📊 This project involves analyzing a comprehensive dataset related to job postings in the data industry. The dataset includes information on companies, job postings, required skills, and salaries.

🎯 The primary objective of this analysis is to identify trends and insights related to data analytics that can help job seekers and employers understand the current job market.

💼 By examining factors such as top-paying jobs, in-demand skills, and optimal skill sets for data analysts, this project aims to provide valuable information for career development and strategic hiring.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

🔍 In our quest to search for data analyst jobs more effectively, we utilized a dataset that hails from a SQL course by [Luke Barousse](https://lukebarousse.com/sql). 

This dataset is packed with insights on job titles, companies, required skills, and salaries. By leveraging this rich dataset, we aimed to uncover valuable trends and patterns in the data job market.

### The questions I answered were?

1. What are the top-paying data analyst jobs?
2. What are the skills required for the top-paying data analyst jobs?
3. What are the top demanded skills for data analyst jobs?
4. What are the top skills based on salary?
5. What are the most optimal skills for data analyst jobs (aka the top paying and most demanded skills)?

# Tools I Used

🛠️ For this project, I utilized a variety of tools to analyze the data job market effectively:

- **Visual Studio Code (VS Code)**: An open-source code editor that provided a robust environment for writing and debugging code.
- **Git**: A version control system that helped in tracking changes and collaborating with others.
- **GitHub**: A platform for hosting and sharing the project repository, facilitating collaboration and version control.
- **PostgreSQL**: A powerful, open-source relational database system used to store and manage the dataset.
- **SQL**: The language used to query and manipulate the data within PostgreSQL, enabling the extraction of meaningful insights from the dataset.

# The Analysis

Each query for this project was aimed at investigating specific aspects of the data analyst job market. Here how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field. 

```sql
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
```

### 2. Top Paying Data Analyst jobs by Skills

To identify the skills required for the top-paying data analyst jobs, we first identified the top 10 highest paying data analyst roles. We then added the specific skills required for these roles. This analysis provides a detailed look at which top-paying jobs demand certain skills, helping job seekers understand which skills to develop to align with top salaries.

```sql
WITH top_paying_jobs AS (
    SELECT
        jpf.job_id,
        jpf.job_title,
        jpf.salary_year_avg,
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
    LIMIT 10
)

SELECT
    tpj.*,
    skills_dim.skills AS job_skills
FROM    
    top_paying_jobs AS tpj
INNER JOIN skills_job_dim ON tpj.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    tpj.salary_year_avg DESC
LIMIT 10;
```

### 3. Top Demanded Skills for Data Analyst jobs

To identify the top demanded skills for data analyst jobs, we joined the job postings using an inner join and focused on all job postings. We identified the top 5 in-demand skills for data analysts. This analysis retrieves the skills with the highest demand, offering insights into the most valuable skills for job seekers.

```sql
SELECT 
    skills as top_demanded_skills,
    COUNT(jpf.job_id) as job_count
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    job_count DESC
LIMIT 5;

```
### 4. Top Skills required for Data Analyst jobs by Salary

To determine the top skills based on salary for data analyst jobs, we examined the average salary for each skill, focusing on roles with specified salaries regardless of location. This analysis reveals which skills are associated with higher salaries, providing valuable insights for job seekers aiming to maximize their earning potential.

```sql
SELECT
    skills_dim.skills AS skill,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = 'True'
GROUP BY
    skill
ORDER BY
    avg_salary DESC
LIMIT 25;

```

### 5. Most Optimal Skills based on Salary and Job Demand

To identify the most optimal skills for data analyst jobs, we focused on skills that are in high demand and associated with high average salaries, specifically concentrating on remote positions with specified salaries. This analysis targets skills that offer both job security and financial benefits, providing strategic insights for career development in data analysis.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills as top_demanded_skills,
        COUNT(jpf.job_id) as job_count
    FROM 
        job_postings_fact AS jpf
    INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id

), average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact AS jpf
    INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = 'True'
    GROUP BY
        skills_job_dim.skill_id

)

SELECT
    sd.skill_id,
    sd.top_demanded_skills,
    sd.job_count,
    av.avg_salary
FROM
    skills_demand AS sd
INNER JOIN average_salary AS av ON sd.skill_id = av.skill_id
WHERE
    sd.job_count > 10
ORDER BY
    av.avg_salary DESC, sd.job_count DESC
LIMIT 25;

```

# What I learned


- From this SQL project, I gained a deeper understanding of how to effectively use various tools to analyze and extract insights from a comprehensive dataset. Utilizing Visual Studio Code (VS Code) provided a robust environment for writing and debugging SQL queries, while Git and GitHub facilitated version control and collaboration. PostgreSQL served as a powerful database management system for storing and querying the dataset, and SQL was essential for manipulating and analyzing the data.

- Working with the dataset from Luke Barousse's SQL course, I learned how to identify key trends and patterns in the data job market. By examining job titles, companies, required skills, and salaries, I was able to uncover valuable insights that can help job seekers and employers understand the current job market for data-related roles.

- Overall, this project enhanced my skills in SQL and data analysis, and provided practical experience in using industry-standard tools. It also reinforced the value of leveraging comprehensive datasets to gain actionable insights, ultimately helping to inform better career and hiring decisions in the data industry.

# Conclusions

### Insights

1. **Top-Paying Jobs**: The analysis revealed the top-paying data analyst jobs, providing a clear picture of which roles offer the highest salaries. This information is crucial for job seekers aiming to maximize their earning potential.

2. **In-Demand Skills**: By identifying the top 5 in-demand skills for data analysts, the project highlighted the skills that are most sought after by employers. This insight helps job seekers focus on developing the skills that will make them more competitive in the job market.

3. **Skills Associated with High Salaries**: The project identified the skills that are associated with higher average salaries for data analyst jobs. This information is valuable for job seekers who want to align their skill development with higher-paying opportunities.

4. **Optimal Skills for Remote Positions**: The analysis concentrated on remote positions with specified salaries, identifying the skills that offer both job security and financial benefits. This insight is particularly useful for those seeking remote work opportunities in the data industry.

5. **Comprehensive Market Understanding**: Overall, the project provided a comprehensive understanding of the data job market, including trends in job titles, companies, required skills, and salaries. These insights are valuable for both job seekers and employers looking to make informed decisions in the data industry.

### Closing Thoughts

This project has been an invaluable learning experience, providing deep insights into the data job market and the skills that are most valuable for data analysts. By leveraging powerful tools and comprehensive datasets, we were able to uncover trends and patterns that can guide both job seekers and employers in making informed decisions. The knowledge gained from this analysis not only enhances our understanding of the current job landscape but also equips us with the strategic insights needed for career development and effective hiring practices. As the data industry continues to evolve, staying informed about these trends will be crucial for success.