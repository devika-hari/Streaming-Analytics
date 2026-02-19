{{ config(materialized='table') }}

with users as (

    select
        user_id,
        row_number() over (
            partition by user_id
            order by user_id
        ) as rn
    from {{ ref('stg_users') }}

),

deduplicated as (

    select
        user_id
    from users
    where rn = 1

)

select
    {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_key,
    user_id
from deduplicated
