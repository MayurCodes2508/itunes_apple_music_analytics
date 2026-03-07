{{ config(materialized = 'table') }}

SELECT DISTINCT dc.email,
       dc.first_name,
	   dc.last_name,
	   dt.genre_name
FROM {{ ref('dim_customer_current') }} dc
JOIN {{ ref('fact_invoice_line') }} f
ON dc.customer_key = f.customer_key
JOIN {{ ref('dim_track') }} dt
ON f.track_key = dt.track_key
WHERE dt.genre_name = 'Rock' AND
      dc.email LIKE 'a%'
ORDER BY dc.email