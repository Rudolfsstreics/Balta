WITH date_validated_duplicates_numbered as (
    SELECT 
    ROW_NUMBER() OVER(PARTITION BY id_claim 
    ORDER BY d_claim_date DESC) AS row_num
    ,id_claim
    ,cm.id_policy
    ,pl.id_customer
    ,d_claim_date
    ,amt_claim_amount
    FROM  {{ ref('claim_bronze') }} AS cm
    LEFT JOIN {{ ref('policy_bronze') }} AS pl ON cm.id_policy = pl.id_policy
    WHERE d_claim_date>=d_policy_start_date and d_claim_date>=d_policy_end_date
    )
SELECT 
id_claim
,id_policy
,id_customer
,d_claim_date
,amt_claim_amount
FROM date_validated_duplicates_numbered
where row_num = 1