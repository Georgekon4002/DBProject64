-- 10) Find the top 3 pairs of genres that have appeared together -- in a certain festival year.

WITH genre_appearances AS (
  SELECT DISTINCT f.fest_year, g1.genre AS genre1, g2.genre AS genre2
  FROM performance p
  JOIN artist_genre g1 ON g1.artist_id = p.artist_id
  JOIN artist_genre g2 ON g2.artist_id = p.artist_id AND g1.genre < g2.genre
  JOIN shows s ON s.show_id = p.show_id
  JOIN festival f ON f.fest_year = s.fest_year
),
pair_counts AS (
  SELECT genre1, genre2, COUNT(DISTINCT fest_year) AS appearance_count
  FROM genre_appearances
  GROUP BY genre1, genre2
)
SELECT genre1, genre2, appearance_count
FROM pair_counts
ORDER BY appearance_count DESC
LIMIT 3;

