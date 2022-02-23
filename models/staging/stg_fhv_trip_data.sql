{{ config(materialized='view') }}
 
with tripdata as 
(
  select *
  from {{ source('staging','fhv_trip') }}
)
select
   -- identifiers
    dispatching_base_num,
	cast(pickup_datetime as timestamp) as pickup_datetime,
	cast(dropoff_datetime as timestamp) as dropoff_datetime,
    cast(PULocationID as integer) as  pickup_locationid,
    cast(DOLocationID as integer) as dropoff_locationid,
	cast(SR_Flag as integer) as SR_Flag
from tripdata

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}
