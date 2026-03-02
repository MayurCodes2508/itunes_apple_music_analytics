{{ config(materialized = 'table') }}

WITH purchases AS (
SELECT di.billing_country,
       dt.genre_name,
	   SUM(f.quantity) AS total_purchases
FROM {{ ref('dim_invoice') }} di
JOIN {{ ref('fact_invoice_line') }} f
ON di.invoice_key = f.invoice_key
JOIN {{ ref('dim_track') }} dt
ON f.track_key = dt.track_key
GROUP BY 1,
         2
),

genre_ranking AS (
SELECT *,
       DENSE_RANK() OVER(PARTITION BY billing_country ORDER BY total_purchases DESC) AS ranking
FROM purchases
)

SELECT *
FROM genre_ranking
WHERE ranking = 1