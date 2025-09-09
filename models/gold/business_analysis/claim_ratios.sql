/*
2.b)Aprēķināt Claim Ratio = Sum(claim_amount) / Sum(earned_premium) pēc produktiem;
*/
{{ config(materialized='table') }}


;WITH claimed_amounts_calculated as (
    SELECT 
    C.[policy_id]
    ,CAST(SUM(C.[claim_amount]) AS float) AS claim_amount
    FROM  {{ ref('insurance_data_claims') }} as C
    GROUP BY policy_id
)
,earned_premiums as (
    SELECT 
    *
    FROM {{ ref('earned_premiums') }} 
)
,earned_n_claimed_amounts as (
    select 
    sum(ep.amt_earned_premium) AS amt_earned_premium
    ,sum(ISNULL(ca.claim_amount,0)) AS claim_amount
    from earned_premiums as ep
    left join claimed_amounts_calculated as ca
    on ep.id_policy = ca.policy_id
)
SELECT claim_amount/amt_earned_premium as claim_ratio 
FROM earned_n_claimed_amounts

