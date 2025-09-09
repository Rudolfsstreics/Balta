/*
2.c)Uzrakstīt optimizētu SQL, kas aprēķina vidējo prēmiju un vidējo atlīdzību pa klientu vecuma grupām
*/

with customer_claims as (
    SELECT 
    id_customer
    ,id_claim
    ,amt_claim_amount
    FROM {{ ref('claim_silver') }} as C
    )
,customer_age as (
    SELECT 
    id_customer
    ,DATEDIFF(YEAR, d_customer_birth_date,CAST(GETDATE() as DATE)) AS age
    FROM {{ ref('customer_silver') }} 
)
,customer_age_groups_and_individual_claims as(
    SELECT 
        CASE
                WHEN C.age BETWEEN 0 AND 30 THEN 'Under 30' 
                WHEN C.age BETWEEN 31 AND 40 THEN '31 - 40'
                WHEN C.age BETWEEN 41 AND 50 THEN '41 - 50'
                WHEN C.age BETWEEN 50 AND 60 THEN '50 - 60'
                WHEN C.age BETWEEN 60 AND 110 THEN 'Over 60'
                ELSE 'Invalid Birthdate'
            END AS age_groups
        ,CC.amt_claim_amount
    FROM customer_age AS C 
    left join customer_claims as CC
    ON C.id_customer=CC.id_customer
    )
select 
age_groups
,AVG(cast(amt_claim_amount as float)) AS avg_claim
from customer_age_groups_and_individual_claims
group by age_groups


