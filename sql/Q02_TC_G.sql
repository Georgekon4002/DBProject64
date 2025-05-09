-- 2) Find all artists of a certain genre with an index if they participated in shows of a certain year's festival
-- SELECT a.artist_id, a.artist_name, a.genre
-- FROM artist a
-- WHERE genre = 'rock' AND 
--     a.artist_id IN (
--         SELECT 1 
--         FROM performance p
--         JOIN shows s ON p.show_id=s.show_id
--         JOIN festival f ON s.fest_year=f.fest_year
--         WHERE f.fest_year=2022 AND p.artist_id = a.artist_id
--     )
-- ;

SELECT performer_id, performer_name, performer_genre
FROM (
  SELECT a.artist_id AS performer_id, a.artist_name AS performer_name, a.genre AS performer_genre
  FROM artist a
  WHERE genre = 'Rock'
    AND EXISTS (
      SELECT 1
      FROM performance p
      JOIN shows s ON p.show_id = s.show_id
      JOIN festival f ON f.fest_year = s.fest_year
      WHERE f.fest_year = 2022 AND p.artist_id = a.artist_id
    )

  UNION

  SELECT b.band_id AS performer_id, b.band_name AS name, b.genre AS performer_genre
  FROM band b
  WHERE genre = 'Rock'
    AND EXISTS (
      SELECT 1
      FROM performance p
      JOIN shows s ON p.show_id = s.show_id
      JOIN festival f ON f.fest_year = s.fest_year
      WHERE f.fest_year = 2022 AND p.band_id = b.band_id
    )
)