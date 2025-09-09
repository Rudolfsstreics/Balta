/*
*/

{{ config(materialized='view') }}

with source_data as (
    select 
       [offer_id]
      ,[customer_id]
      ,[product_code]
      ,[product_variant]
      ,[offer_datetime]
      ,[premium_offered]
      ,[sales_source]
      ,[sum_insured]
      ,[coverage_hash]
    from {{ source('raw','offers') }}

)

select *
from source_data
