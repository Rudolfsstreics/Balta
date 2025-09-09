/*

*/

{{ config(materialized='table') }}

SELECT 
  SELECT C.[claim_id] AS id_insurance_data_claims
        ,P.[customer_id]  AS id_insurance_data_customers 
        ,P.[policy_id] AS id_insurance_data_policies
        ,C.[claim_date] AS d_claim_date
        ,C.[claim_amount] AS amt_claim_amount
--      ,P.[product_code]
--      ,P.[product_variant]
--      ,P.[start_date]
--      ,P.[end_date]
--      ,P.[policy_status]
        ,P.[written_premium] AS amt_written_premium
        ,P.[sum_insured] AS amt_sum_insured
        ,P.[currency] AS currency_code
--      ,P.[sales_channel]
--      ,P.[policy_version]
  FROM  {{ ref('insurance_data_claims') }} [claims] as C
  JOIN  {{ ref('insurance_data_policies') }} [policies] as P
  ON C.policy_id = P.policy_id
