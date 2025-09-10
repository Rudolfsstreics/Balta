/*
1.c)Kādas jaunas dimensijas var atvasināt no customers tabulas?;
*/
SELECT distinct 
{{ dbt_utils.generate_surrogate_key(['customer_country_code','customer_city_name']) }} AS id_location
,customer_city_name
,customer_country_code
FROM  {{ ref('customer_silver') }}  
