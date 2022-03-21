with users as (
    select *
    from {{ ref('stg_users') }}
),

orders as (
    select user_id,
    count(order_id) as num_orders,
    sum(order_total) as total_spent,
    min(created_at) as first_order_date,
    max(created_at) as latest_order_date,
    sum(case when promo_id is not null then 1 else 0 end) as promo_use_count
    from {{ ref('stg_orders') }}
    group by 1
),

addresses as (
    select *
    from {{ ref('stg_addresses') }}
),

final as (
    select *
    from users
    left join orders using (user_id)
    left join addresses using (address_id)
)

select * from final