/*
1.c)Kādas jaunas dimensijas var atvasināt no customers tabulas?;
*/
SELECT 
{{ dbt_utils.generate_surrogate_key(['customer_segment_name']) }} AS id_location
,customer_segment_name
FROM  {{ ref('customer_silver') }} 

