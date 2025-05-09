-- 14) Find the genres that had the same amount of appearances for 2 consecutive years with at leat 3 appearances per year
WITH genre_performances AS (
  SELECT s.fest_year AS fest, a.genre AS genre, COUNT(*) AS appearances
  FROM performance p
  JOIN shows s ON p.show_id = s.show_id
  JOIN artist a ON p.artist_id = a.artist_id
  GROUP BY fest, genre

  UNION ALL

  SELECT s.fest_year AS fest, b.genre AS genre, COUNT(*) AS appearances
  FROM performance p
  JOIN shows s ON p.show_id = s.show_id
  JOIN band b ON p.band_id = b.band_id
  GROUP BY fest, genre
),
filtered AS (
  SELECT *
  FROM genre_performances
  WHERE appearances >= 3
),
joined AS (
  SELECT 
    f1.genre,
    f1.year AS year1,
    f2.year AS year2,
    f1.appearances
  FROM filtered f1
  JOIN filtered f2 
    ON f1.genre = f2.genre
    AND f2.year = f1.year + 1
    AND f1.appearances = f2.appearances
)
SELECT genre, year1, year2, appearances
FROM joined
ORDER BY genre, year1;