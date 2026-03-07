{{ config(materialized = 'table') }}

WITH top_customer AS (
SELECT di.billing_country,
       dc.customer_key,
       dc.first_name,
	   dc.last_name,
	   SUM(f.total_revenue) AS invoice_total
FROM {{ ref('dim_invoice') }} di
JOIN {{ ref('fact_invoice_line') }} f
ON di.invoice_key = f.invoice_key
JOIN {{ ref('dim_customer_current') }} dc
ON f.customer_key = dc.customer_key
GROUP BY 1,
         2,
		 3,
		 4
),

invoice_total_ranking AS (
SELECT *,
       DENSE_RANK() OVER(PARTITION BY billing_country ORDER BY invoice_total DESC) AS ranking
FROM top_customer
)

SELECT *
FROM invoice_total_ranking
WHERE ranking = 1