with promos as (
    select *
    from {{ ref('stg_promos')}}
),

orders as (
    select promo_id,
    count(order_id) as num_orders,
    count(distinct user_id) as num_users,
    sum(order_total) as total_order_dollars
    from {{ ref('stg_orders')}}
    group by 1
),

final as (
    select *
    from promos 
    left join orders using (promo_id)
)

select * from final