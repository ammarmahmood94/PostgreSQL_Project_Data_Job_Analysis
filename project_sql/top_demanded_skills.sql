/*
Question: What are the top demanded skills for data analyst jobs?
- Join the job postings to inner join similar to query 2
- Identify the top 5 in-demand skills for data analyst
- Focus on all job postings.
- Why? Retrieves the top 5 with skills with the highest demand for data analysts, 
    offering insights into the most valuable skills for job seekers.
*/

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

/*
Output:
[
  {
    "top_demanded_skills": "sql",
    "job_count": "92628"
  },
  {
    "top_demanded_skills": "excel",
    "job_count": "67031"
  },
  {
    "top_demanded_skills": "python",
    "job_count": "57326"
  },
  {
    "top_demanded_skills": "tableau",
    "job_count": "46554"
  },
  {
    "top_demanded_skills": "power bi",
    "job_count": "39468"
  }
]
*/


