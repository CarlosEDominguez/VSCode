SELECT * FROM company_dim limit 10;
SELECT * FROM job_postings_fact limit 10;
SELECT * FROM skills_dim limit 10;
SELECT * FROM skills_job_dim limit 10;



with skills_count AS(
    SELECT 
        skill_id,
        COUNT(*) AS recuento
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY recuento DESC
    LIMIT 5);

SELECT 
    skills_dim.skills 
FROM skills_dim
JOIN skills_count USING (skill_id);



SELECT 
    skills_dim.skills,
    skills_dim.skill_id
FROM skills_dim
JOIN (SELECT 
        skills_job_dim.skill_id,
        COUNT(*) AS recuento
    FROM skills_job_dim
    GROUP BY skills_job_dim.skill_id
    ORDER BY recuento DESC
    LIMIT 5) as top_skills USING (skill_id)
ORDER BY recuento DESC;




SELECT 
    CASE
    WHEN recuento > 50 THEN 'Large'
    WHEN recuento >= 10 THEN 'Medium'
    ELSE 'Small'
    END,
    tabla_recuento.recuento,
    company_dim.name
FROM
    (SELECT 
        company_id,
        COUNT(*) as recuento
    FROM job_postings_fact
    GROUP BY company_id) AS tabla_recuento
JOIN company_dim USING (company_id);


SELECT 
    company_dim.name,
    AVG(salary_year_avg) AS avg_salary
FROM job_postings_fact
JOIN company_dim USING (company_id)
GROUP BY 1
HAVING AVG(salary_year_avg) > (SELECT AVG(salary_year_avg) FROM job_postings_fact)
ORDER BY 2 DESC;


