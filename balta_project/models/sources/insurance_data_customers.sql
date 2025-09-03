/*
*/

{{ config(materialized='view') }}

with source_data as (
    select 
       [customer_id]
      ,[first_name]
      ,[last_name]
      ,[birth_date]
      ,[gender]
      ,[city]
      ,[segment]
      ,[created_at]
      ,[country]
    from {{ source('raw','customers') }}

)

select *
from source_data
