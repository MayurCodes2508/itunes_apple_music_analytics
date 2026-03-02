{{ config(materialized = 'view') }}

SELECT CAST(invoice_line_id AS INT64) AS invoice_line_id,
       CAST(invoice_id AS INT64) AS invoice_id,
	   CAST(track_id AS INT64) AS track_id,
	   ROUND(CAST(unit_price AS NUMERIC), 2) AS unit_price,
	   CAST(quantity AS INT64) AS quantity
FROM {{ source('raw_apple_music', 'invoice_line') }}