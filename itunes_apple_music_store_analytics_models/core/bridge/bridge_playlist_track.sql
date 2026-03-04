{{ config(materialized = 'table') }}

WITH base AS (
SELECT playlist_id,
       track_id
FROM {{ ref('stg_playlist_track_focused') }} 
)

SELECT dp.playlist_key,
       dt.track_key
FROM base b
JOIN {{ ref('dim_playlist') }} dp
ON b.playlist_id = dp.playlist_id
JOIN {{ ref('dim_track') }} dt
ON b.track_id = dt.track_id