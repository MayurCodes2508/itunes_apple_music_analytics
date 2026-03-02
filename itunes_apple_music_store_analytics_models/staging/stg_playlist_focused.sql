{{ config(materialized = 'view') }}

SELECT CAST(playlist_id AS INT64) AS playlist_id,
       TRIM(CAST(name AS STRING)) AS name
FROM {{ source('raw_apple_music', 'playlist') }}