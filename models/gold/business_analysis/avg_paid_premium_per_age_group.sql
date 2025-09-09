/*
2.c)Uzrakstīt optimizētu SQL, kas aprēķina vidējo prēmiju un vidējo atlīdzību pa klientu vecuma grupām;
*/
{{ config(materialized='table') }}

;with customer_claims as (
    SELECT 
    P.[customer_id]
    ,C.[claim_id]
    ,C.[claim_amount]
    FROM {{ ref('insurance_data_claims') }} as C
    join {{ ref('insurance_data_policies') }}  as P
    on C.[policy_id] = P.[policy_id]
    )
,customer_age as (
    SELECT 
    C.[customer_id]
    ,DATEDIFF(YEAR, C.[birth_date],GETDATE()) AS age
    FROM {{ ref('insurance_data_customers') }} AS C 
)
,customer_age_groups_and_individual_claims as(
SELECT 
       --C.[customer_id],
       CASE
             WHEN C.age BETWEEN 0 AND 30 THEN 'Under 30' -- Edited to include 30 YO
             WHEN C.age BETWEEN 31 AND 40 THEN '31 - 40'
             WHEN C.age BETWEEN 41 AND 50 THEN '41 - 50'
             WHEN C.age BETWEEN 50 AND 110 THEN 'Over 50'
             ELSE 'Invalid Birthdate'
         END AS [age_groups]
      -- ,CC.[claim_id]
       ,CC.[claim_amount]
  FROM customer_age AS C 
  left join customer_claims as CC
  ON C.[customer_id]=CC.[customer_id]
  )
select 
age_groups
,AVG(cast(claim_amount as float))
from customer_age_groups_and_individual_claims
group by age_groups


