-- 4) For a certain artist/band, find the average review (rendition) and average total rating

-- SELECT a.artist_id, a.artist_name, 
--     AVG(r.rendition) AS avg_rendition, 
--     AVG(r.total) AS avg_total,
-- FROM artist a
-- JOIN performance p ON a.artist_id = p.artist_id
-- JOIN review r ON p.performance_id = r.performance_id
-- WHERE a.artist_name = 'Billie Eilish'
-- GROUP BY a.artist_id;

SELECT performer_id, performer_name, AVG(r.rendition) AS avg_rendition, ROUND(AVG(r.total), 2) AS avg_total
FROM (
  SELECT a.artist_id AS performer_id, a.artist_name AS performer_name
  FROM artist a
  JOIN performance p ON a.artist_id = p.artist_id
  WHERE a.artist_name = 'Billie Eilish'

  UNION ALL

  SELECT b.band_id AS performer_id, b.band_name AS performer_name
  FROM band b
  JOIN performance p ON b.band_id = p.band_id
  WHERE b.band_name = 'Billie Eilish'
) AS perf
JOIN review r ON r.performance_id = perf.performance_id
GROUP BY performer_id, performer_name

-- Alternative query plan using indexes
SELECT 
  a.artist_id,
  a.name,
  ROUND(AVG(r.interpretation_score), 2) AS avg_interpretation,
  ROUND(AVG(r.overall_score), 2) AS avg_overall
FROM artist a
JOIN performance p FORCE INDEX (idx_artid) ON p.artist_id = a.artist_id
JOIN review r FORCE INDEX (idx_perffo) ON r.performance_id = p.performance_id
WHERE a.artist_name = 'Billie Eilish'
GROUP BY a.artist_id;

-- TRACE/EXPLAIN

-- Nested Loop Join

-- Hash Join

-- Merge Join