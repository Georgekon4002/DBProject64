-- 15) Find the top 5 visitors who have given the highest total score to an artist

SELECT CONCAT(p.first_name, ' ', p.last_name) AS visitor_name, a.artist_name, SUM(r.total) AS total_score
FROM review r
JOIN ticket t ON r.ticket_id = t.ticket_id
JOIN person p ON t.person_id = p.person_id
JOIN performance pf ON r.performance_id = pf.performance_id
JOIN artist a ON pf.artist_id = a.artist_id
WHERE pf.artist_id IS NOT NULL
GROUP BY p.person_id, pf.artist_id -- Artist and Group?
ORDER BY total_score DESC
LIMIT 5;