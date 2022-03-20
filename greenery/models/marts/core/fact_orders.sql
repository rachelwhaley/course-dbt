with orders as (
    select * from 
    {{ ref('stg_orders')}}
),

items as ( 
    select order_id,
    count(product_id) as num_products
    from {{ ref('stg_order_items')}}
    group by 1
),

final as (
    select * 
    from orders
    left join items using (order_id)
)

select * from final