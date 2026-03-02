{{ config(materialized = 'table') }}

SELECT {{ dbt_utils.generate_surrogate_key(['s.invoice_id']) }} AS invoice_key,
       s.invoice_id,
	   s.customer_id,
	   d.date_key,
	   s.billing_address,
	   s.billing_city,
	   s.billing_state,
	   s.billing_country,
	   s.billing_postal_code
FROM {{ ref('stg_invoice_focused') }} s
JOIN {{ ref('dim_date') }} d
ON s.invoice_date = d.date