{{ config(materialized = 'table') }}

WITH composer_normalization AS (
SELECT DISTINCT TRIM(composer_name) AS composer_name,
                TRIM(LOWER(composer_name)) AS normalized_composer_name
FROM {{ ref('int_exploded_composer') }}
)

SELECT {{ dbt_utils.generate_surrogate_key(['normalized_composer_name']) }} AS composer_key,
       composer_name
FROM composer_normalization
