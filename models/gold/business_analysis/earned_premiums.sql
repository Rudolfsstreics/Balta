/*
2.a)Aprēķināt nopelnīto prēmiju earned_premium katrai polisei
Definīcija - Nopelnītā prēmija ir tā parakstītās prēmijas daļa(written_premium), kas atbilst riskam, kas jau ir “iztērēts” jeb apdrošināšanas seguma periodam, kas līdz attiecīgajam datumam ir beidzies


formula of Earned Premium Calculator

The formula to calculate earned premium is:

Earned Premium = Written Premium × (Number of Days Policy Active / Total Policy Term in Days)

Where:

    Written Premium = total premium amount recorded at the start of the policy
    Number of Days Policy Active = days the policy has been active within the reporting period
    Total Policy Term in Days = total duration of the policy (typically 365 days for annual coverage)

*/
WITH policy_days_calculated as (
    SELECT id_policy
    ,amt_policy_written_premium
    ,DATEDIFF(DAY, d_policy_start_date,d_policy_end_date) AS cnt_days_total_policy_term
    --,DATEDIFF(DAY, d_policy_start_date,IIF(CAST(GETDATE() as DATE) > d_policy_end_date, d_policy_end_date, CAST(GETDATE() as DATE))) AS cnt_days_policy_active
    ,DATEDIFF(DAY, d_policy_start_date,CASE WHEN CAST(GETDATE() as DATE) > d_policy_end_date THEN d_policy_end_date ELSE CAST(GETDATE() as DATE) END ) AS cnt_days_policy_active
    FROM  {{ ref('policy_silver') }} 
    )
select 
id_policy AS  id_policy
,amt_policy_written_premium*(cast(cnt_days_policy_active as float)/cast(cnt_days_total_policy_term as float)) AS amt_earned_premium
from policy_days_calculated
