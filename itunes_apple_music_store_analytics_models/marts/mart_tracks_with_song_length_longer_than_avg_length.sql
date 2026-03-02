{{ config(materialized = 'table') }}

WITH milliseconds_calculation AS (
SELECT AVG(milliseconds) AS avg_milliseconds
FROM {{ ref('dim_track') }}
)

SELECT dt.track_key,
       dt.track_name,
	   dt.milliseconds
FROM milliseconds_calculation mc
JOIN {{ ref('dim_track') }} dt
ON mc.avg_milliseconds > dt.milliseconds
ORDER BY dt.milliseconds DESC
LIMIT 100
