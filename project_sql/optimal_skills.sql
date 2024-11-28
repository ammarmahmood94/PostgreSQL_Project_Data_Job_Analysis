/*
Answer: What are the most optimal skills for data analyst jobs (aka the top paying and most demanded skills)?
- Identify skills in high demand and associated with the high average salary for data analyst jobs.
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data analysis.
*/

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

/*
Output:
[
  {
    "skill_id": 95,
    "top_demanded_skills": "pyspark",
    "job_count": "49",
    "avg_salary": "208172"
  },
  {
    "skill_id": 102,
    "top_demanded_skills": "jupyter",
    "job_count": "37",
    "avg_salary": "152777"
  },
  {
    "skill_id": 93,
    "top_demanded_skills": "pandas",
    "job_count": "90",
    "avg_salary": "151821"
  },
  {
    "skill_id": 59,
    "top_demanded_skills": "elasticsearch",
    "job_count": "12",
    "avg_salary": "145000"
  },
  {
    "skill_id": 94,
    "top_demanded_skills": "numpy",
    "job_count": "54",
    "avg_salary": "143513"
  },
  {
    "skill_id": 75,
    "top_demanded_skills": "databricks",
    "job_count": "102",
    "avg_salary": "141907"
  },
  {
    "skill_id": 169,
    "top_demanded_skills": "linux",
    "job_count": "58",
    "avg_salary": "136508"
  },
  {
    "skill_id": 213,
    "top_demanded_skills": "kubernetes",
    "job_count": "26",
    "avg_salary": "132500"
  },
  {
    "skill_id": 219,
    "top_demanded_skills": "atlassian",
    "job_count": "15",
    "avg_salary": "131162"
  },
  {
    "skill_id": 96,
    "top_demanded_skills": "airflow",
    "job_count": "71",
    "avg_salary": "126103"
  },
  {
    "skill_id": 106,
    "top_demanded_skills": "scikit-learn",
    "job_count": "26",
    "avg_salary": "125781"
  },
  {
    "skill_id": 211,
    "top_demanded_skills": "jenkins",
    "job_count": "21",
    "avg_salary": "125436"
  },
  {
    "skill_id": 3,
    "top_demanded_skills": "scala",
    "job_count": "59",
    "avg_salary": "124903"
  },
  {
    "skill_id": 57,
    "top_demanded_skills": "postgresql",
    "job_count": "44",
    "avg_salary": "123879"
  },
  {
    "skill_id": 81,
    "top_demanded_skills": "gcp",
    "job_count": "78",
    "avg_salary": "122500"
  },
  {
    "skill_id": 191,
    "top_demanded_skills": "microstrategy",
    "job_count": "39",
    "avg_salary": "121619"
  },
  {
    "skill_id": 23,
    "top_demanded_skills": "crystal",
    "job_count": "76",
    "avg_salary": "120100"
  },
  {
    "skill_id": 8,
    "top_demanded_skills": "go",
    "job_count": "288",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "top_demanded_skills": "confluence",
    "job_count": "62",
    "avg_salary": "114210"
  },
  {
    "skill_id": 67,
    "top_demanded_skills": "db2",
    "job_count": "38",
    "avg_salary": "114072"
  },
  {
    "skill_id": 97,
    "top_demanded_skills": "hadoop",
    "job_count": "140",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "top_demanded_skills": "snowflake",
    "job_count": "241",
    "avg_salary": "112948"
  },
  {
    "skill_id": 210,
    "top_demanded_skills": "git",
    "job_count": "74",
    "avg_salary": "112000"
  },
  {
    "skill_id": 74,
    "top_demanded_skills": "azure",
    "job_count": "319",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "top_demanded_skills": "bigquery",
    "job_count": "84",
    "avg_salary": "109654"
  }
]
*/
    


