# Introduction
💡 Dive into the Indian data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and ✅ where high demand meets high salary in data analytics.

☕ SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from Luke's [SQL Course](https://lukebarousse.com/sql) and is limited to 2023. It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my
SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data
analysts?
4. Which skills are associated with higher
salaries?
5. What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the Indian data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating
specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analysts Jobs
To identify the highest-paying roles I filtered
data analyst positions by average yearly salary
and location, focusing on remote jobs. This query
highlights the high paying opportunities in the
field.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id    
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '_%India%' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC    
LIMIT 10    
```

![Top Paying Roles](Asset/TopPayingJobs.png)
*Graphs visualizing the datsets; Claude generated this
graph from my SQL query results*

### 2. Top Demand Skills
To understand what skills are in demand, i joined the job posting with the skills data to get our demand trends
```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
JOIN 
    skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '_%India%'   
GROUP BY
    skills
ORDER BY
    demand_count DESC     
LIMIT 5       
```

![Top Demanded Skills](Asset/TopDemandedSkills.png)
*Graphs visualizing the datsets; Claude generated this
graph from my SQL query results*

### 3. Skills for Top Paying Jobs
To understand what skills are required for the top paying jobs, i joined the job posting with the skills data 
```sql
WITH top_paying_jobs AS
(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id    
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location LIKE '_%India%' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC    
    LIMIT 10   
) 

SELECT 
    top_paying_jobs.*,
    skills 
FROM 
    top_paying_jobs
JOIN 
    skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
```
![Top Highest Paying Skills](Asset/TopSkills.png)
*Graphs visualizing the datsets; Claude generated this
graph from my SQL query results*

### 4. The Most Optimal Skills
This is all about maximising benefits to looks at skills that are in demand as well as of great value.
```sql
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
``` 
![Optimal Skills](Asset/OptimalSkills.png)
*Graphs visualizing the datsets; Claude generated this
graph from my SQL query results*

**Key Analysis Findings**

- The highest paying job is Staff Applied Research Engineer at ServiceNow with an annual salary of $177,283.
- SQL is the most in-demand skill with 1,550 job postings requiring it.
- The top 3 most valuable skills (combining demand and salary) are SQL, Python, and Excel.
- GitLab, Linux, and MySQL are among the highest-paying skills with average salaries of $165,000.
- Data Architect roles appear multiple times in the top-paying jobs list.

# What I Learned

Throughout this adventure, I've turbocharged my
SQL toolkit with some serious firepower:

- **Complex Query Crafting :** Mastered the art
of advanced SQL, merging tables like a pro and
wielding WITH clauses for ninja-level temp table
maneuvers.
- **Data Aggregation :** Got cozy with GROUP BY
and turned aggregate functions like COUNT() and AVG
() into my data-summarizing sidekicks.
- **Analytical Wizardry :** Leveled up my
real-world puzzle-solving skills, turning
questions into actionable, insightful SQL queries.

# Conclusion

### 📊 Insights

**Top Paying Jobs**

Our analysis identified the highest-paying roles in the tech industry:

Staff Applied Research Engineer at ServiceNow - $177,283/year
Data Architect roles at Bosch Group - $165,000/year
Technical Data Architect - Healthcare at Srijan Technologies - $165,000/year

These findings indicate that specialized engineering and architecture roles command the highest compensation in the current market.

**Most In-Demand Skills**

The skills with the highest demand across job postings are:

1. SQL - 1,550 job postings
2. Python - 1,120 job postings
3. Excel - 1,003 job postings

Database management and data manipulation skills continue to be foundational requirements across the industry.

**Highest Paying Skills**

The skills associated with the highest average salaries are:

1. GitLab - $165,000
2. Linux - $165,000
3. MySQL - $165,000

DevOps and infrastructure skills command premium compensation in the current market.

**Optimal Skills (High Demand × High Salary)**

When considering both demand and salary, these skills offer the best return on investment for professionals:

1. SQL - High demand (37 jobs in our sample) with average salary of $94,829
2. Python - Significant demand (30 jobs) with average salary of $99,683
3. Excel - Steady demand (31 jobs) with average salary of $89,591

### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.

