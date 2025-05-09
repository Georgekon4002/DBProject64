-- 8) Find the assistant staff that doesn't have anything to do on a certain day
SELECT s.staff_id, s.first_name, s.last_name
FROM staff s
WHERE s.specialty = 'Assistant' AND s.staff_id NOT IN (
    SELECT ss.staff_id
    FROM staff ss
    JOIN shows sh ON ss.show_id = ss.show_id
    WHERE sh.show_date = '2023-06-15'
);