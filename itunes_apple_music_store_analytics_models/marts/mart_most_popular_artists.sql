{{ config(materialized = 'table') }}

SELECT dt.artist_name,
       SUM(f.quantity) AS units_sold
FROM {{ ref('fact_invoice_line') }} f
JOIN {{ ref('dim_track') }} dt
ON f.track_key = dt.track_key
GROUP BY dt.artist_name
ORDER BY units_sold DESC
LIMIT 100