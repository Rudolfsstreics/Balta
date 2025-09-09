
{{ config(materialized='view') }}

with source_data as (
    select 
    [claim_id] AS id_claim
    ,[policy_id] AS id_policy
    ,[claim_date] AS d_claim
    ,[claim_amount] AS amt_claim
    from {{ source('insurance_raw','claims') }}

)

select *
from source_data
