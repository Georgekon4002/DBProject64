SELECT
  artist_name,
  fest_year,
  COUNT(*) AS warmup_count
FROM (
  SELECT
    a.artist_name,
    s.fest_year
  FROM
    performance p
  JOIN
    shows s ON p.show_id = s.show_id
  JOIN
    artist a ON p.artist_id = a.artist_id
  WHERE
    p.style = 'Warm Up' AND p.band_id IS NULL

  UNION ALL

  SELECT
    a.artist_name,
    s.fest_year
  FROM
    performance p
  JOIN
    shows s ON p.show_id = s.show_id
  JOIN
    membership m ON p.band_id = m.band_id
  JOIN
    artist a ON m.artist_id = a.artist_id
  WHERE
    p.style = 'Warm Up' AND p.band_id IS NOT NULL
) AS combined
GROUP BY
  artist_name,
  fest_year
HAVING
  COUNT(*) > 2
ORDER BY
  warmup_count DESC;
