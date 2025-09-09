/*
*/

{{ config(materialized='view') }}

with source_data as (
    select 
       [policy_id] AS id_policy
      ,[customer_id] AS id_customer
      ,[product_code] AS policy_product_code
      ,[product_variant] AS policy_product_variant_name
      ,[start_date] AS d_policy_start_date
      ,[end_date] AS d_policy_end_date
      ,[policy_status] AS policy_status_code
      ,[written_premium] AS amt_policy_written_premium
      ,[sum_insured] AS amt_policy_sum_insured
      ,[currency] AS policy_currency_code
      ,[sales_channel] AS policy_sales_channel_code
      ,[policy_version] AS policy_version
    from {{ source('insurance_raw','policies') }}

)

select *
from source_data
