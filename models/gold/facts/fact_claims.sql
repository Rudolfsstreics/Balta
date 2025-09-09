/*

*/

SELECT 
C.id_claim
,C.id_customer
,C.id_policy
,C.d_claim_date
,C.amt_claim_amount
,P.amt_policy_written_premium
,P.amt_policy_sum_insured
,P.policy_currency_code
FROM  {{ ref('claim_silver') }} as C
JOIN  {{ ref('policy_silver') }} as P
ON C.id_policy = P.id_policy



