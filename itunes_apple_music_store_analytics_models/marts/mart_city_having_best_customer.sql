{{ config(materialized = 'table') }}

SELECT d.city,
       SUM(f.total_revenue) AS total_invoice
FROM {{ ref('fact_invoice_line') }} f
JOIN {{ ref('dim_customer_current') }} d
ON f.customer_key = d.customer_key
GROUP BY d.city
ORDER BY total_invoice DESC
LIMIT 1