with source_data as (
    select 
       [customer_id] AS id_customer
      ,[first_name] AS customer_first_name
      ,[last_name] AS customer_last_name
      ,[birth_date] AS d_customer_birth_date
      ,[gender] AS customer_gender
      ,[city] AS customer_city_name
      ,[segment] AS customer_segment_name
      ,[created_at] AS d_customer_created_at
      ,[country] AS customer_country_code
    from {{ source('insurance_raw','customers') }}

)

select *
from source_data
