{{ config(materialized = 'view') }}

SELECT CAST(customer_id AS INT64) AS customer_id,
       TRIM(CAST(first_name AS STRING)) AS first_name,
	   TRIM(CAST(last_name AS STRING)) AS last_name,
	   TRIM(CAST(company AS STRING)) AS company,
	   TRIM(CAST(address AS STRING)) AS address,
	   TRIM(CAST(city AS STRING)) AS city,
	   TRIM(CAST(state AS STRING)) AS state,
	   TRIM(CAST(country AS STRING)) AS country,
	   TRIM(CAST(postal_code AS STRING)) AS postal_code,
	   TRIM(CAST(phone AS STRING)) AS phone,
	   TRIM(CAST(fax AS STRING)) AS fax,
	   TRIM(CAST(email AS STRING)) AS email,
       CAST(support_rep_id AS INT64) AS support_rep_id
FROM {{ source('raw_apple_music', 'customer') }}
	   