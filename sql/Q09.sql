-- 9) Find the people who have the same number of shows attended in the same year (more than 3)

WITH attendance_per_year AS (
    SELECT t.person_id, sh.fest_year, COUNT(DISTINCT t.show_id) AS num_shows
    FROM ticket t
    JOIN shows sh ON t.show_id = sh.show_id
    WHERE t.activation = TRUE
    GROUP BY t.person_id, sh.fest_year
    HAVING num_shows > 3
),
same_attendance AS (
    SELECT a1.person_id AS person1, a2.person_id AS person2, a1.fest_year,a1.num_shows
    FROM attendance_per_year a1
    JOIN attendance_per_year a2 
        ON a1.fest_year = a2.fest_year 
        AND a1.num_shows = a2.num_shows
        AND a1.person_id < a2.person_id
)
SELECT 
    p1.first_name AS first_name_1,
    p1.last_name AS last_name_1,
    p2.first_name AS first_name_2,
    p2.last_name AS last_name_2,
    s.fest_year,
    s.num_shows
FROM same_attendance s
JOIN person p1 ON s.person1 = p1.person_id
JOIN person p2 ON s.person2 = p2.person_id;