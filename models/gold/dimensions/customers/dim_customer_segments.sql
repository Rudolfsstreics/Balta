/*
1.c)Kādas jaunas dimensijas var atvasināt no customers tabulas?;
Prasītu ģenerēt jaunu ID lokācijai

*/
{{ config(materialized='table') }}

SELECT distinct C.[segment]
  FROM  {{ ref('customers_raw') }}  as C
