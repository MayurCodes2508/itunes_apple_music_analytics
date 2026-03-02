{{ config(materialized = 'table') }}

WITH track AS (
SELECT DISTINCT dt.track_key,
       s.playlist_id
FROM {{ ref('dim_track') }} dt
JOIN {{ ref('stg_playlist_track_focused') }} s
ON dt.track_id = s.track_id
)

SELECT t.track_key,
       dp.playlist_key
FROM track t
JOIN {{ ref('dim_playlist') }} dp
ON t.playlist_id = dp.playlist_id