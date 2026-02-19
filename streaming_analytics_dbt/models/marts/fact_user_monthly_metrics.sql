{{ config(materialized='table') }}

-- grain: user_key - month

with monthly as (

    select 
        user_id,
        amount,
        date_trunc('month', payment_date) as year_month
    from {{ ref('stg_payments') }}

),

aggregated as (

    select
        user_id,
        year_month,
        sum(amount) as total_revenue
    from monthly
    group by user_id, year_month

),

joined as (

    select
        u.user_key,
        a.year_month,
        a.total_revenue
    from aggregated a
    inner join {{ ref('dim_users') }} u
        on a.user_id = u.user_id

)

select *
from joined
