{{ config(materialized = 'table') }}

select
    subscription_id,
    user_id,
    dbt_valid_from as effective_start_date,
    dbt_valid_to   as effective_end_date,
    dbt_valid_to is null as is_current
from {{ ref('subscription_snapshot_check') }}
