{{ config(materialized = 'table') }}

SELECT invoice_key,
       SUM(total_revenue) AS total_invoice
FROM {{ ref('fact_invoice_line') }}
GROUP BY invoice_key
ORDER BY total_invoice DESC
LIMIT 3