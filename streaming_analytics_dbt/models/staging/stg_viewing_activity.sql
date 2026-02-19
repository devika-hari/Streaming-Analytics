-- stg_viewing_activity
-- Grain: 1 row per user per viewing event per day

select
    cast(user_id as varchar)       as user_id,
    cast(watch_date as date)        as watch_date,
    cast(hours_watched as double)  as hours_watched
from {{ source('raw', 'viewing_activity') }}
where user_id is not null
