/*
1.b)Dimensijas dim_customers;
*/
SELECT 
id_customer
,customer_first_name
,customer_last_name
,d_customer_birth_date
,customer_gender
,d_customer_created_at
FROM  {{ ref('customer_silver') }} 
