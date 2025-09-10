SELECT id_policy
      ,id_customer
      ,d_policy_start_date
      ,d_policy_end_date
      ,DATEDIFF(day, d_policy_end_date, d_policy_start_date) AS cnt_policy_period_days_total
      ,DATEDIFF(DAY, d_policy_start_date,CASE WHEN CAST(GETDATE() as DATE) > d_policy_end_date THEN d_policy_end_date ELSE CAST(GETDATE() as DATE) END ) AS cnt_policy_period_days_active
      ,policy_status_code
      ,policy_sales_channel_code
  FROM  {{ ref('policy_silver') }}
