/*
1.b)Dimensijas dim_customers;
*/

{{ config(materialized='table') }}

SELECT C.[customer_id]
      ,C.[first_name]
      ,C.[last_name]
      ,C.[birth_date]
      ,C.[gender]
      ,C.[city]
      ,C.[segment]
      ,C.[created_at]
      ,C.[country]
  FROM  {{ ref('insurance_data_customers') }} as C

