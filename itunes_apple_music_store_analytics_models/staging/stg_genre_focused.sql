{{ config(materialized = 'view') }}

SELECT CAST(genre_id AS INT64) AS genre_id,
       TRIM(CAST(name AS STRING)) AS name
FROM {{ source('raw_apple_music', 'genre') }}
