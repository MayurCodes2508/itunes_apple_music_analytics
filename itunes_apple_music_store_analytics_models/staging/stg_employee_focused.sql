{{ config(materialized = 'view') }}

SELECT CAST(employee_id AS INT64) AS employee_id,
       TRIM(CAST(last_name AS STRING)) AS last_name,
	   TRIM(CAST(first_name AS STRING)) AS first_name,
	   TRIM(CAST(title AS STRING)) AS title,
	   CAST(reports_to AS INT64) AS reports_to,
	   TRIM(CAST(levels AS STRING)) AS levels,
	   DATE(PARSE_TIMESTAMP('%d-%m-%Y %H:%M', birthdate)) AS birth_date,
	   DATE(PARSE_TIMESTAMP('%d-%m-%Y %H:%M', hire_date)) AS hire_date,
	   TRIM(CAST(address AS STRING)) AS address,
	   TRIM(CAST(city AS STRING)) AS city,
	   TRIM(CAST(state AS STRING)) AS state,
	   TRIM(CAST(country AS STRING)) AS country,
	   TRIM(CAST(postal_code AS STRING)) AS postal_code,
	   TRIM(CAST(phone AS STRING)) AS phone,
	   TRIM(CAST(fax AS STRING)) AS fax,
	   TRIM(CAST(email AS STRING)) AS email
FROM {{ source('raw_apple_music', 'employee') }}