{{ config(materialized = 'table') }}

SELECT di.billing_country,
       SUM(f.quantity) AS total_purchases
FROM {{ ref('fact_invoice_line') }} f
JOIN {{ ref('dim_invoice') }} di
ON f.invoice_key = di.invoice_key
GROUP BY di.billing_country
ORDER BY total_purchases DESC
