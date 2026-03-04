{{ config(materialized = 'table') }}

WITH composer_normalization AS (
SELECT TRIM(composer_name) AS composer_name_clean,
	   TRIM(LOWER(composer_name)) AS normalized_composer_name
FROM {{ ref('int_exploded_composer') }}
WHERE composer_name IS NOT NULL
),

deduplication AS (
SELECT normalized_composer_name,
       MIN(composer_name_clean) AS composer_name
FROM composer_normalization
GROUP BY 1
)

SELECT {{ dbt_utils.generate_surrogate_key(['normalized_composer_name']) }} AS composer_key,
       composer_name,
       normalized_composer_name
FROM deduplication
