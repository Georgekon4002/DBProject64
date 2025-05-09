-- 12) Find the staff needed for everyday of a festival providing an analysis per specialty.
SELECT sh.show_date, s.specialty, SUM(s.quantity) AS total_required
FROM staff_req s
JOIN shows s ON sh.show_date = s.show_date
WHERE s.fest_year=2023
GROUP BY sh.show_date, s.specialty
ORDER BY sh.show_date, s.specialty;