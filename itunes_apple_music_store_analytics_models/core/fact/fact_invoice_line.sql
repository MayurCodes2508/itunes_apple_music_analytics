{{ config(materialized = 'incremental',
          unique_key = 'invoice_line_id',
          incremental_strategy = 'merge',
          cluster_by = ['customer_key',
		                'track_key']) }}

SELECT {{ dbt_utils.generate_surrogate_key(['invoice_line_id']) }} AS invoice_line_key,
	   sil.invoice_line_id,
       di.invoice_key,
	   di.date_key,
	   di.customer_key,
	   dt.track_key,
       si.invoice_date,
	   sil.unit_price,
	   sil.quantity,
	   sil.unit_price * sil.quantity AS total_revenue
FROM {{ ref('stg_invoice_line_focused') }} sil
JOIN {{ ref('stg_invoice_focused') }} si
ON sil.invoice_id = si.invoice_id
JOIN {{ ref('dim_invoice') }} di
ON si.invoice_id = di.invoice_id
JOIN {{ ref('dim_customer_current') }} dc
ON di.customer_key = dc.customer_key
JOIN {{ ref('dim_track') }} dt
ON sil.track_id = dt.track_id

{% if is_incremental() %}

WHERE sil.invoice_line_id > (
      SELECT MAX(invoice_line_id)
      FROM {{ this }})
      OR si.invoice_date >=
      DATE_SUB(CURRENT_DATE(), INTERVAL 3 DAY)

{% endif %}
