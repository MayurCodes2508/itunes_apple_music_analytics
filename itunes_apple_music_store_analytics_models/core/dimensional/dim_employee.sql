{{ config(materialized = 'table') }}

SELECT {{ dbt_utils.generate_surrogate_key(['employee_id']) }} AS employee_key,
       employee_id,
       last_name,
	   first_name,
	   title,
	   reports_to,
	   levels,
	   birth_date,
	   hire_date,
	   address,
	   city,
	   state,
	   country,
	   postal_code,
	   phone,
	   fax,
	   email
FROM {{ ref('stg_employee_focused') }}