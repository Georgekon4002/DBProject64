WITH artist_festival_participations AS (
    SELECT
        p.artist_id,
        s.fest_year
    FROM
        performance p
    JOIN shows s ON p.show_id = s.show_id
    WHERE p.artist_id IS NOT NULL

    UNION

    SELECT
        m.artist_id,
        s.fest_year
    FROM
        performance p
    JOIN shows s ON p.show_id = s.show_id
    JOIN membership m ON p.band_id = m.band_id
    WHERE p.band_id IS NOT NULL
),

participation_counts AS (
    SELECT
        artist_id,
        COUNT(DISTINCT fest_year) AS festival_count
    FROM
        artist_festival_participations
    GROUP BY
        artist_id
),

max_participation AS (
    SELECT MAX(festival_count) AS max_count FROM participation_counts
)

SELECT
    a.artist_id,
    a.artist_name,
    pc.festival_count
FROM
    participation_counts pc
JOIN artist a ON a.artist_id = pc.artist_id
JOIN max_participation mp
WHERE
    pc.festival_count <= mp.max_count - 5;
