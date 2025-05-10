-- 5) Find all the artists under 30 that have performed the most at festivals

SELECT a.artist_name, COUNT(DISTINCT s.fest_year) AS festival_count
FROM artist a
JOIN performance p ON a.artist_id = p.artist_id
JOIN shows s ON p.show_id = s.show_id
WHERE TIMESTAMPDIFF(YEAR, a.birth_date, CURDATE()) < 30

UNION ALL

SELECT a.artist_name, COUNT(DISTINCT s.fest_year) AS festival_count
FROM membership m
JOIN artist a ON m.artist_id = a.artist_id
JOIN performance p ON m.band_id = p.band_id
JOIN shows s ON p.show_id = s.show_id
WHERE TIMESTAMPDIFF(YEAR, a.birth_date, CURDATE()) < 30

GROUP BY artist_name
ORDER BY festival_count DESC;