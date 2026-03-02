{{ config(materialized = 'table') }}

SELECT {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_key,
       customer_id,
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
	   support_rep_id
FROM {{ ref('stg_customer_focused') }}