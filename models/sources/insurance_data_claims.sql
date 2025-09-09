/*
*/

{{ config(materialized='view') }}

with source_data as (
    select 
    [claim_id]
    ,[policy_id]
    ,[claim_date]
    ,[claim_amount]
    from {{ source('raw','claims') }}

)

select *
from source_data
