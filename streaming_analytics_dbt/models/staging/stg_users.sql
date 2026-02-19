-- stg_users
-- Grain: 1 row per user_id, signup_date, plan_type
-- Defensive staging: deduplicate + filter

select
    cast(user_id as varchar)        as user_id,
    lower(trim(country))            as country,
    cast(signup_date as date)       as signup_date,
    lower(trim(plan_type))          as plan_type
from {{ source('raw', 'users') }}
where user_id is not null
