-- stg_payments
-- Grain: 1 row per payment
-- Each record represents a payment event

select
    cast(payment_id as varchar)      as payment_id,
    cast(user_id as varchar)         as user_id,
    cast(payment_date as date)       as payment_date,
    cast(amount as double)           as amount
from {{ source('raw', 'payments') }}
where payment_id is not null
  and user_id is not null