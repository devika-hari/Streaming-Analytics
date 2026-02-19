{{ config(materialized = 'table') }}

-- FACTLESS FACT (EXPLODED)
-- Grain: 1 row per user per active month
-- Handles monthly AND yearly subscriptions uniformly

with base as (

    select
        user_id,
        subscription_id,
        date_trunc('month', start_date) as start_month,
        date_trunc('month', end_date)   as end_month
    from {{ ref('stg_subscriptions') }}

),

expanded as (

    select
        user_id,
        subscription_id,
        generate_series(
            start_month,
            end_month,
            interval '1 month'
        ) as active_month
    from base

)

select
    user_id,
    subscription_id,
    active_month as year_month
from expanded
