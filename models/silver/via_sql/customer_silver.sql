WITH duplicates_numbered as (
    SELECT 
    ROW_NUMBER() OVER(PARTITION BY id_customer 
    ORDER BY d_customer_created_at DESC) AS row_num
    ,id_customer
    ,customer_first_name
    ,customer_last_name
    ,d_customer_birth_date
    ,customer_gender
    ,customer_city_name
    ,customer_segment_name
    ,d_customer_created_at
    ,customer_country_code
    FROM  {{ ref('customer_bronze') }} AS cs
    )
SELECT 
id_customer
,customer_first_name
,customer_last_name
,d_customer_birth_date
,customer_gender
,customer_city_name
,customer_segment_name
,d_customer_created_at
,customer_country_code
FROM duplicates_numbered
where row_num = 1