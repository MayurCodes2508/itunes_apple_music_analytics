{{ config(materialized = 'table') }}

SELECT *
FROM {{ ref('dim_employee') }}
WHERE reports_to IS NULL