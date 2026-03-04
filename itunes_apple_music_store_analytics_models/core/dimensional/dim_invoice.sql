{{ config(materialized = 'table') }}

WITH base AS (
SELECT invoice_id,
       customer_id,
       invoice_date,
	   billing_address,
	   billing_city,
	   billing_state,
	   billing_country,
	   billing_postal_code
FROM {{ ref('stg_invoice_focused') }} 
)

SELECT {{ dbt_utils.generate_surrogate_key(['invoice_id']) }} AS invoice_key,
       b.invoice_id,
       dc.customer_key,
       dd.date_key,
	   b.billing_address,
	   b.billing_city,
	   b.billing_state,
	   b.billing_country,
	   b.billing_postal_code
FROM base b
JOIN {{ ref('dim_customer') }} dc
ON b.customer_id = dc.customer_id
JOIN {{ ref('dim_date') }} dd
ON b.invoice_date = dd.date