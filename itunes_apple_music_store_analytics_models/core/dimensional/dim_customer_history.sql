{{ config(materialized = 'table') }}

WITH base AS (
SELECT customer_id,
	   first_name,
	   last_name,
	   company,
	   address,
	   city,
	   state,
	   country,
	   postal_code,
	   phone,
	   fax,
	   email,
	   support_rep_id,
       dbt_valid_from,
       dbt_valid_to
FROM {{ ref('snapshot_customer') }}
)

SELECT {{ dbt_utils.generate_surrogate_key(['customer_id', 'dbt_valid_from']) }} AS customer_key,
       b.customer_id,
	   b.first_name,
	   b.last_name,
	   b.company,
	   b.address,
	   b.city,
	   b.state,
	   b.country,
	   b.postal_code,
	   b.phone,
	   b.fax,
	   b.email,
	   de.employee_key,
       b.dbt_valid_from,
       b.dbt_valid_to
FROM base b
LEFT JOIN {{ ref('dim_employee') }} de
ON b.support_rep_id = de.employee_id