/*
*/

{{ config(materialized='view') }}

with source_data as (
    select 
       [offer_id] AS id_offer
      ,[customer_id] AS id_customer
      ,[product_code] AS offer_product_code  
      ,[product_variant] AS offer_product_variant_name
      ,[offer_datetime] AS dt_offer
      ,[premium_offered] AS amt_offer_premium
      ,[sales_source] AS offer_sales_source_name
      ,[sum_insured] AS amt_offer_sum_insured
      ,[coverage_hash] AS offer_coverage_hash
    from {{ source('insurance_raw','offers') }}

)

select *
from source_data
