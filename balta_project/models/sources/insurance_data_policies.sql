/*
*/

{{ config(materialized='view') }}

with source_data as (
    select 
       [policy_id]
      ,[customer_id]
      ,[product_code]
      ,[product_variant]
      ,[start_date]
      ,[end_date]
      ,[policy_status]
      ,[written_premium]
      ,[sum_insured]
      ,[currency]
      ,[sales_channel]
      ,[policy_version]
    from {{ source('raw','policies') }}

)

select *
from source_data
