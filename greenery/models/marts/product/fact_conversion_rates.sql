with session_orders as (
    select 
        session_id,
        user_id,
        order_id
    from {{ ref('stg_events') }}
    where order_id is not null 
    group by 1,2,3
),

pageviews as (
    select 
        session_id,
        product_id
    from {{ ref('stg_events')}}
    where event_type = 'page_view'
    and product_id is not null 
    group by 1,2
),

products as (
    select product_id, name
    from {{ ref('stg_products') }}
),

joined as (
    select
        product_id,
        name,
        count(distinct session_id) as unique_sessions,
        sum(case when order_id is not null then 1 else 0 end) as num_with_purchase
    from pageviews
    left join products using (product_id)
    left join session_orders using (session_id)
    group by 1,2
),

final as (
    select 
        product_id,
        name,
        unique_sessions,
        num_with_purchase,
        round(num_with_purchase*100.0/unique_sessions,2) as conversion_rate_percent
    from joined
)

select * from final