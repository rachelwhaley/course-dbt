with users as (
    select *
    from {{ ref('stg_users') }}
),

orders as (
    select user_id,
    count(order_id) as num_orders,
    sum(order_total) as total_spent
    from {{ ref('stg_orders') }}
    group by 1
),

addresses as (
    select *
    from {{ ref('stg_addresses') }}
),

pageviews as (
    select user_id,
    count(event_id) as pageview_count
    from {{ ref('stg_events')}}
    where page_url is not null
    group by 1
),

final as (
    select *
    from users
    left join orders using (user_id)
    left join addresses using (address_id)
    left join pageviews using (user_id)
)

select * from final