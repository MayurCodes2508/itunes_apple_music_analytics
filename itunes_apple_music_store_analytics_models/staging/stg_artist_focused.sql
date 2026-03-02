{{ config(materialized = 'view') }}

SELECT CAST(artist_id AS INT64) AS artist_id,
       TRIM(CAST(name AS STRING)) AS name 
FROM {{ source('raw_apple_music', 'artist') }}