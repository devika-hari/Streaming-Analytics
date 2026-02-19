-- stg_subscriptions
-- Grain: 1 row per user per subscription event
-- This can be the basis for SCD Type 2 in later layers

select
    cast(subscription_id as varchar) as subscription_id,
    cast(user_id as varchar)         as user_id,
    cast(monthly_price as double)     as monthly_price,
    cast(start_date as date)         as start_date,
    cast(end_date as date)           as end_date
from {{ source('raw', 'subscriptions') }}
where subscription_id is not null
  and user_id is not null
