WITH duplicates_numbered as (
    SELECT 
    ROW_NUMBER() OVER(PARTITION BY id_offer 
    ORDER BY dt_offer_date DESC) AS row_num
    ,id_offer
    ,id_customer
    ,offer_product_code
    ,offer_product_variant_name
    ,dt_offer_date
    ,amt_offer_premium
    ,offer_sales_source_name
    ,amt_offer_sum_insured
    ,offer_coverage_hash
    FROM  {{ ref('offer_bronze') }} AS cs
    )
SELECT 
id_offer
    ,id_customer
    ,offer_product_code
    ,offer_product_variant_name
    ,dt_offer_date
    ,amt_offer_premium
    ,offer_sales_source_name
    ,amt_offer_sum_insured
    ,offer_coverage_hash
FROM duplicates_numbered
where row_num = 1