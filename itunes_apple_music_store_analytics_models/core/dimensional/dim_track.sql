{{ config(materialized = "table") }}

WITH track_degeneration AS (
SELECT t.track_id,
       t.name AS track_name,
	   al.title AS album_name,
	   ar.name AS artist_name,
	   t.media_type_id,
	   t.genre_id,
	   t.milliseconds,
	   t.bytes
FROM {{ ref('stg_track_focused') }} t
JOIN {{ ref('stg_album_focused') }} al
ON t.album_id = al.album_id
JOIN {{ ref('stg_artist_focused') }} ar
ON al.artist_id = ar.artist_id
),

genre_degeneration AS (
SELECT td.track_id,
       td.track_name,
	   td.album_name,
	   td.artist_name,
	   g.name AS genre_name,
	   td.media_type_id,
	   td.milliseconds,
	   td.bytes
FROM track_degeneration td
JOIN {{ ref('stg_genre_focused') }} g
ON td.genre_id = g.genre_id
),

media_type_degeneration AS (
SELECT gd.track_id,
       gd.track_name,
	   gd.album_name,
	   gd.artist_name,
	   gd.genre_name,
	   mt.name AS media_type_name,
	   gd.milliseconds,
	   gd.bytes
FROM genre_degeneration gd
JOIN {{ ref('stg_media_type_focused') }} mt
ON gd.media_type_id = mt.media_type_id
)

SELECT {{ dbt_utils.generate_surrogate_key(['track_id']) }} AS track_key,
       track_id,
	   track_name,
	   album_name,
	   artist_name,
	   genre_name,
	   media_type_name,
	   milliseconds,
	   bytes
FROM media_type_degeneration