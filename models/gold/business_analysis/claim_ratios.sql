/*
2.b)Aprēķināt Claim Ratio = Sum(claim_amount) / Sum(earned_premium) pēc produktiem
*/
WITH claimed_amounts_calculated as (
    SELECT 
    C.[id_policy]
    ,CAST(SUM(C.[amt_claim_amount]) AS float) AS amt_claim_amount
    FROM  {{ ref('claim_silver') }} as C
    GROUP BY id_policy
)
,earned_premiums as (
    SELECT 
    id_policy
    ,amt_earned_premium
    FROM {{ ref('earned_premiums') }} 
)
,earned_n_claimed_amounts as (
    select 
    sum(ep.amt_earned_premium) AS amt_earned_premium
    ,sum(ISNULL(ca.amt_claim_amount,0)) AS amt_claim_amount
    from earned_premiums as ep
    left join claimed_amounts_calculated as ca
    on ep.id_policy = ca.id_policy
)
SELECT amt_claim_amount/amt_earned_premium as claim_ratio 
FROM earned_n_claimed_amounts



