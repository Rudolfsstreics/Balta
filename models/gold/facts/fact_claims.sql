/*

*/

SELECT 
C.id_claim
,C.id_customer
,C.id_policy
,{{ dbt_utils.generate_surrogate_key(['policy_product_code','policy_product_variant_name','policy_version']) }} AS id_product
,C.d_claim_date
,C.amt_claim_amount
,P.amt_policy_written_premium
,P.amt_policy_sum_insured
,P.policy_currency_code
FROM  {{ ref('claim_silver') }} as C
JOIN  {{ ref('policy_silver') }} as P
ON C.id_policy = P.id_policy



