{{ config(materialized = 'view') }}

SELECT CAST(track_id AS INT64) AS track_id,
       TRIM(CAST(name AS STRING)) AS name,
	   CAST(album_id AS INT64) AS album_id,
	   CAST(media_type_id AS INT64) AS media_type_id,
	   CAST(genre_id AS INT64) AS genre_id,
	   TRIM(CAST(composer AS STRING)) AS composer,
	   CAST(milliseconds AS INT64) AS milliseconds,
	   CAST(bytes AS INT64) AS bytes,
	   ROUND(CAST(unit_price AS NUMERIC), 2) AS unit_price
FROM {{ source('raw_apple_music', 'track') }}