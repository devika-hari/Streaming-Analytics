-- Analysis: -- Monthly Active Users (MAU)
-- Users who generated revenue in a given month

select
    year_month,
    count(distinct user_key) as monthly_active_users
from {{ ref('fact_user_monthly_metrics') }}
where total_revenue > 0
group by year_month
order by year_month
