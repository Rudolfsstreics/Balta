/*
1.c)Kādas jaunas dimensijas var atvasināt no customers tabulas?;

*/
{{ config(materialized='table') }}

SELECT distinct CONCAT_WS('/',C.[country],C.[city]) AS id_location
        ,C.[city]
      ,C.[country]
  FROM  {{ ref('customers_raw') }}  as C
