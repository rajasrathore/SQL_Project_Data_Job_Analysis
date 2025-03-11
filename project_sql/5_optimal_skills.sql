WITH skils_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    JOIN 
        skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    JOIN 
        skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location LIKE '_%India%' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), paying_skills AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg)) AS avg_salary
    FROM job_postings_fact
    JOIN 
        skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    JOIN 
        skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND job_location LIKE '_%India%' 
        AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)        

SELECT
    skils_demand.skill_id,
    skils_demand.skills,
    demand_count,
    avg_salary
FROM
    skils_demand
JOIN paying_skills ON skils_demand.skill_id = paying_skills.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC, demand_count DESC
LIMIT 25 

-- rewriting in other manner

SELECT
    skills_dim.skill_id,
    skilLs_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg)) AS avg_salary
FROM job_postings_fact
JOIN 
    skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND job_location LIKE '_%India%' 
    AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC, 
    demand_count DESC
LIMIT 25   