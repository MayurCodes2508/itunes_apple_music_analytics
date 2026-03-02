{{ config(materialized = 'table') }}

SELECT d.customer_key,
       d.first_name,
	   d.last_name,
	   SUM(f.total_revenue) AS total_invoice
FROM {{ ref('fact_invoice_line') }} f
JOIN {{ ref('dim_customer') }} d
ON f.customer_key = d.customer_key
GROUP BY 1,
         2,
		 3
ORDER BY total_invoice DESC
LIMIT 1