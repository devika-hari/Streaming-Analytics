--subscription_snapshot_timestamp
--Detects changes based on a timestamp column in the data #Using Business Date
{% snapshot subscription_snapshot_timestamp %}

{{
    config(
        target_schema = 'snapshots',
        unique_key = 'subscription_id',
        strategy = 'timestamp',
        updated_at = 'start_date'
    )
}}

select
    subscription_id,
    user_id,
    start_date
from {{ ref('stg_subscriptions') }}

{% endsnapshot %}
