{{ config(materialized = 'view') }}

SELECT CAST(album_id AS INT64) AS album_id,
       TRIM(CAST(title AS STRING)) AS title,
	   CAST(artist_id AS INT64) AS artist_id
FROM {{ source('raw_apple_music', 'album') }}