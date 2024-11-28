/*
Answer: What are the top skills based on salary?
- Look at the average salary for each skill for data analyst jobs.
- Focuses on the roles with specified salaries regardless of location.
- Why? It reveals how 
*/
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

/*
Here is a breakdown of the top paying skills remotely
[
  {
    "skill": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skill": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skill": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill": "watson",
    "avg_salary": "160515"
  },
  {
    "skill": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skill": "swift",
    "avg_salary": "153750"
  },
  {
    "skill": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skill": "pandas",
    "avg_salary": "151821"
  },
  {
    "skill": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skill": "golang",
    "avg_salary": "145000"
  },
  {
    "skill": "numpy",
    "avg_salary": "143513"
  },
  {
    "skill": "databricks",
    "avg_salary": "141907"
  },
  {
    "skill": "linux",
    "avg_salary": "136508"
  },
  {
    "skill": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skill": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skill": "twilio",
    "avg_salary": "127000"
  },
  {
    "skill": "airflow",
    "avg_salary": "126103"
  },
  {
    "skill": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skill": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skill": "notion",
    "avg_salary": "125000"
  },
  {
    "skill": "scala",
    "avg_salary": "124903"
  },
  {
    "skill": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skill": "gcp",
    "avg_salary": "122500"
  },
  {
    "skill": "microstrategy",
    "avg_salary": "121619"
  }
]
*/