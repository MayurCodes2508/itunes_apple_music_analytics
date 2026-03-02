{{ config(materialized = 'table') }}

SELECT d.billing_country,
       COUNT(DISTINCT f.invoice_key) AS invoice_count
FROM {{ ref('fact_invoice_line') }} f
JOIN {{ ref('dim_invoice') }} d
ON f.invoice_key = d.invoice_key
GROUP BY billing_country
ORDER BY invoice_count DESC
LIMIT 5