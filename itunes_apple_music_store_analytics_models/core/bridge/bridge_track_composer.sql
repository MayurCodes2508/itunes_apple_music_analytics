{{ config(materialized = 'table') }}

WITH base AS (
SELECT track_id,
       composer_name
FROM {{ ref('int_exploded_composer') }} 
)

SELECT dt.track_key,
       dc.composer_key
FROM base b
JOIN {{ ref('dim_track') }} dt
ON b.track_id = dt.track_id
JOIN {{ ref('dim_composer') }} dc
ON TRIM(LOWER(b.composer_name)) = dc.normalized_composer_name