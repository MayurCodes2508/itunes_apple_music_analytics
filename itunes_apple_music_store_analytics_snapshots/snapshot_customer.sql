{% snapshot snapshot_customer %}

{{ config(target_schema='snapshot',
          unique_key = 'customer_id',
          strategy = 'check',
          check_cols = [
	      'company',
	      'address',
	      'city',
	      'state',
	      'country',
	      'postal_code',
	      'phone',
	      'email']) }}
          
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
	   support_rep_id
FROM {{ ref('stg_customer_focused') }}

{% endsnapshot %}