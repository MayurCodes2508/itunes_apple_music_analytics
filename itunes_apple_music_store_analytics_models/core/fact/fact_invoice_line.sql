{{ config(materialized = 'table') }}

WITH invoice_line_joining AS (
SELECT invoice_line_id,
       invoice_id,
       track_id,
       unit_price,
       quantity
FROM {{ ref('stg_invoice_line_focused') }}
),

invoice_joining AS (
SELECT il.invoice_line_id,
       i.invoice_key,
	   i.date_key,
       c.customer_key,
       e.employee_key,
       il.track_id,
       il.unit_price,
       il.quantity
FROM invoice_line_joining il
JOIN {{ ref('dim_invoice') }} i
ON il.invoice_id = i.invoice_id
JOIN {{ ref('dim_customer') }} c
ON i.customer_id = c.customer_id
JOIN {{ ref('dim_employee') }} e
ON c.support_rep_id = e.employee_id
)

SELECT {{ dbt_utils.generate_surrogate_key(['ij.invoice_line_id']) }} AS invoice_line_key,
       ij.invoice_line_id,
       ij.invoice_key,
	   ij.date_key,
	   ij.customer_key,
	   ij.employee_key,
	   dt.track_key,
	   ij.unit_price,
	   ij.quantity,
	   ij.unit_price * ij.quantity AS total_revenue
FROM invoice_joining ij
JOIN {{ ref('dim_track') }} dt
ON ij.track_id = dt.track_id
