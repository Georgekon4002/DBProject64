-- 2) Find all artists of a certain genre with an index if they participated in shows of a certain year's festival
SELECT a.artist_id, a.artist_name, a.genre
FROM artist a
WHERE genre = 'rock' AND 
    a.artist_id IN (
        SELECT 1 
        FROM performance p
        JOIN shows s ON p.show_id=s.show_id
        JOIN festival f ON s.fest_year=f.fest_year
        WHERE f.fest_year=2022 AND p.artist_id = a.artist_id
    )
;
