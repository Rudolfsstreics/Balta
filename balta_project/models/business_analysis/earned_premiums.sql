/*
2.a)Aprēķināt nopelnīto prēmiju earned_premium katrai polisei
Definīcija - Nopelnītā prēmija ir tā parakstītās prēmijas daļa(written_premium), kas atbilst riskam, kas jau ir “iztērēts” jeb apdrošināšanas seguma periodam, kas līdz attiecīgajam datumam ir beidzies;


formula of Earned Premium Calculator

The formula to calculate earned premium is:

Earned Premium = Written Premium × (Number of Days Policy Active / Total Policy Term in Days)

Where:

    Written Premium = total premium amount recorded at the start of the policy
    Number of Days Policy Active = days the policy has been active within the reporting period
    Total Policy Term in Days = total duration of the policy (typically 365 days for annual coverage)

*/
{{ config(materialized='table') }}

;WITH policy_days_calculated as (
    SELECT P.[policy_id]
    ,P.[written_premium]
    ,DATEDIFF(DAY, P.[start_date],P.[end_date]) AS total_policy_term_in_days
    ,DATEDIFF(DAY, P.[start_date],IIF(GETDATE()>P.[end_date], P.[end_date], GETDATE())) AS number_of_days_policy_active
    FROM  {{ ref('insurance_data_policies') }} as P
    )
select 
[policy_id] AS  id_policy
,[written_premium]*(cast(number_of_days_policy_active as float)/cast(total_policy_term_in_days as float)) AS amt_earned_premium
from policy_days_calculated