/*
1.d)Dimensijas dim_products no policies;
*/
SELECT 
{{ dbt_utils.generate_surrogate_key(['policy_product_code','policy_product_variant_name','policy_version']) }} AS id_product
,policy_product_code
,policy_product_variant_name
,policy_version
FROM  {{ ref('policy_silver') }}