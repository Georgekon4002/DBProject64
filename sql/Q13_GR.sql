-- 13) Find all artists who have performed in at least 3 different continents

WITH artist_continent_participation AS (
    SELECT p.artist_id, l.continent
    FROM performance p
    JOIN shows s ON p.show_id = s.show_id
    JOIN festival f ON s.fest_year = f.fest_year
    JOIN location l ON f.latitude = l.latitude AND f.longtitude = l.longtitude
    WHERE p.artist_id IS NOT NULL

    UNION

    SELECT m.artist_id, l.continent
    FROM performance p
    JOIN shows s ON p.show_id = s.show_id
    JOIN festival f ON s.fest_year = f.fest_year
    JOIN location l ON f.latitude = l.latitude AND f.longtitude = l.longtitude
    JOIN membership m ON p.band_id = m.band_id -- Artists or Bands?
    WHERE p.band_id IS NOT NULL
),

artist_continent_counts AS (
    SELECT artist_id, COUNT(DISTINCT continent) AS continent_count
    FROM artist_continent_participation
    GROUP BY artist_id
)

SELECT a.artist_id, a.artist_name, acc.continent_count
FROM artist_continent_counts acc
JOIN artist a ON a.artist_id = acc.artist_id
WHERE acc.continent_count >= 3;