/*
1.d)Dimensijas dim_products no policies;
*/

{{ config(materialized='table') }}

SELECT distinct CONCAT_WS('/',P.[product_code]
      ,P.[product_variant],P.[policy_version]) as id_product
      ,P.[product_code]
      ,P.[product_variant]
      ,P.[policy_version]
  FROM  {{ ref('insurance_data_policies') }} as P