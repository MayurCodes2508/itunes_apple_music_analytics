{{ config(materialized = 'table') }}

SELECT dc.customer_key,
       dc.first_name,
	   dc.last_name,
	   dt.artist_name,
	   SUM(f.total_revenue) AS total_invoice
FROM {{ ref('dim_customer_current') }} dc
JOIN {{ ref('fact_invoice_line') }} f
ON dc.customer_key = f.customer_key
JOIN {{ ref('dim_track') }} dt
ON f.track_key = dt.track_key
GROUP BY 1,
         2,
		 3,
		 4
ORDER BY total_invoice DESC
LIMIT 100