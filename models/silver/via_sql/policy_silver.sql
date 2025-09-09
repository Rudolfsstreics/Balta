WITH duplicates_numbered as (
    SELECT 
    ROW_NUMBER() OVER(PARTITION BY id_policy 
    ORDER BY d_policy_end_date DESC) AS row_num
    ,id_policy
    ,id_customer
    ,policy_product_code
    ,policy_product_variant_name
    ,d_policy_start_date
    ,d_policy_end_date
    ,policy_status_code
    ,amt_policy_written_premium
    ,amt_policy_sum_insured
    ,policy_currency_code
    ,policy_sales_channel_code
    ,policy_version
    FROM  {{ ref('policy_bronze') }} AS cs
    )
SELECT 
id_policy
,id_customer
,policy_product_code
,policy_product_variant_name
,d_policy_start_date
,d_policy_end_date
,policy_status_code
,amt_policy_written_premium
,amt_policy_sum_insured
,policy_currency_code
,policy_sales_channel_code
,policy_version
FROM duplicates_numbered
where row_num = 1