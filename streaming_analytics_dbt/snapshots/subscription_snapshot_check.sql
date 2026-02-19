--subscription_snapshot_check
--Detects changes by comparing columns


{% snapshot subscription_snapshot_check %}

{{
    config(
        target_schema = 'snapshots',
        unique_key = 'subscription_id',
        strategy = 'check',
        check_cols = ['start_date']
    )
}}

select
    subscription_id,
    user_id,
    start_date
from {{ ref('stg_subscriptions') }}

{% endsnapshot %}
