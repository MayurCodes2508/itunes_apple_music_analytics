{{ config(materialized = 'table') }}

SELECT dt.genre_name,
       ROUND(AVG(f.unit_price), 2) AS avg_unit_price
FROM {{ ref('fact_invoice_line') }} f
JOIN {{ ref('dim_track') }} dt
ON f.track_key = dt.track_key
GROUP BY dt.genre_name
