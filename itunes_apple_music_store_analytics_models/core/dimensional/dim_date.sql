{{ config(materialized = 'table') }}

WITH date_extraction AS (
SELECT DISTINCT invoice_date AS date,
       EXTRACT(YEAR FROM invoice_date) AS year,
	   EXTRACT(MONTH FROM invoice_date) AS month,
	   EXTRACT(DAY FROM invoice_date) AS day
FROM {{ ref('stg_invoice_focused') }}
)

SELECT {{ dbt_utils.generate_surrogate_key(['date']) }} AS date_key,
       date,
	   year,
	   month,
	   day
FROM date_extraction