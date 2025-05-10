-- 7) Find the festival year with the least average experience of technical staff

SELECT f.fest_year,
    AVG(
        CASE s.experience
            WHEN 'Intern' THEN 1
            WHEN 'Beginner' THEN 2
            WHEN 'Intermediate' THEN 3
            WHEN 'Experienced' THEN 4
            WHEN 'Master' THEN 5
            ELSE NULL
        END
    ) AS avg_experience
FROM festival f
JOIN shows sh ON f.fest_year = sh.fest_year
JOIN show_staff ss ON sh.show_id = ss.show_id
JOIN staff s ON ss.staff_id = s.staff_id
WHERE s.specialty = 'Technical'
GROUP BY f.fest_year
ORDER BY avg_experience ASC
LIMIT 1;