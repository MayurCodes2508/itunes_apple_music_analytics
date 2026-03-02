{{ config(materialized = 'view') }}

SELECT CAST(playlist_id AS INT64) AS playlist_id,
       CAST(track_id AS INT64) AS track_id
FROM {{ source('raw_apple_music', 'playlist_track') }}