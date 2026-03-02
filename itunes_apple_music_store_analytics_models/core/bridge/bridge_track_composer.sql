{{ config(materialized = 'table') }}

SELECT t.track_key,
       c.composer_key
FROM {{ ref('dim_track') }} t
JOIN {{ ref('int_exploded_composer') }} ec
ON t.track_id = ec.track_id
JOIN {{ ref('dim_composer') }} c
ON TRIM(LOWER(ec.composer_name)) = TRIM(LOWER(c.composer_name))