{{ config(materialized = 'view') }}

SELECT DISTINCT track_id,
       TRIM(exploded_composer) AS composer_name
FROM {{ ref('stg_track_focused') }}
CROSS JOIN UNNEST(SPLIT(composer, ',')) AS exploded_composer
WHERE composer IS NOT NULL AND
TRIM(exploded_composer) <> ''