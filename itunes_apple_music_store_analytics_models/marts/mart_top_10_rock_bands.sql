{{ config(materialized = 'table') }}

SELECT artist_name,
       COUNT(*) AS track_count
FROM {{ ref('dim_track') }}
WHERE genre_name = 'Rock'
GROUP BY artist_name
ORDER BY track_count DESC
LIMIT 10