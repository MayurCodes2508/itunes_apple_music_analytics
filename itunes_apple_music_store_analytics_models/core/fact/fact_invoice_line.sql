{{ config(materialized = 'table') }}

WITH base AS (
SELECT invoice_line_id,
	   invoice_id,
       track_id,
       unit_price,
       quantity
FROM {{ ref('stg_invoice_line_focused') }}
)

SELECT {{ dbt_utils.generate_surrogate_key(['invoice_line_id']) }} AS invoice_line_key,
       b.invoice_line_id,
       di.invoice_key,
	   di.date_key,
	   di.customer_key,
	   de.employee_key,
	   dt.track_key,
	   b.unit_price,
	   b.quantity,
	   b.unit_price * b.quantity AS total_revenue
FROM base b
JOIN {{ ref('dim_invoice') }} di
ON b.invoice_id = di.invoice_id
JOIN {{ ref('dim_customer') }} dc
ON di.customer_key = dc.customer_key
JOIN {{ ref('dim_employee') }} de
ON dc.employee_key = de.employee_key
JOIN {{ ref('dim_track') }} dt
ON b.track_id = dt.track_id
