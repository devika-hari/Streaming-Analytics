-- Analysis: Monthly Revenue (MR)
-- Total revenue across all users per month

select
    year_month,
    sum(total_revenue) as monthly_recurring_revenue
from {{ ref('fact_user_monthly_metrics') }}
group by year_month
order by year_month
