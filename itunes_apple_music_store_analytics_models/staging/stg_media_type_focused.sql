{{ config(materialized = 'view') }}

SELECT CAST(media_type_id AS INT64) AS media_type_id,
       TRIM(CAST(name AS STRING)) AS name
FROM {{ source('raw_apple_music', 'media_type') }}