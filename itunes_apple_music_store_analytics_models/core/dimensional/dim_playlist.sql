{{ config(materialized = 'table') }}

SELECT {{ dbt_utils.generate_surrogate_key(['playlist_id']) }} AS playlist_key,
       playlist_id,
	   name AS playlist_name
FROM {{ ref('stg_playlist_focused') }}