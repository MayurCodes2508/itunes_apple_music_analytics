{{ config(materialized = 'view') }}

SELECT CAST(invoice_id AS INT64) AS invoice_id,
       CAST(customer_id AS INT64) AS customer_id,
	   DATE(invoice_date) AS invoice_date,
	   TRIM(CAST(billing_address AS STRING)) AS billing_address,
	   TRIM(CAST(billing_city AS STRING)) AS billing_city,
       TRIM(CAST(billing_state AS STRING)) AS billing_state,
	   TRIM(CAST(billing_country AS STRING)) AS billing_country,
       TRIM(CAST(billing_postal_code AS STRING)) AS billing_postal_code,
	   ROUND(CAST(total AS NUMERIC), 2) AS total
FROM {{ source('raw_apple_music', 'invoice') }}
	   